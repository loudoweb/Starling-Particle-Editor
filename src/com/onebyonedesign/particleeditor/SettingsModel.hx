/**
 *	Copyright (c) 2013 Devon O. Wolfgang
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */

package com.onebyonedesign.particleeditor;

import openfl.display.Sprite;

/**
	 * Because the SoulWire SimpleGUI works by modifying the properties of a display object, 
	 * this class was created to contain all modifiable properties.
 * SimpleGUI is attached to this and its changes are sent to SettingsListener objects
	 * @author Devon O.
	 */
@:final class SettingsModel extends Sprite
{
    public var xPosVar(get, set) : Float;
    public var yPosVar(get, set) : Float;
    public var maxParts(get, set) : Float;
    public var lifeSpan(get, set) : Float;
    public var lifeSpanVar(get, set) : Float;
    public var startSize(get, set) : Float;
    public var startSizeVar(get, set) : Float;
    public var finishSize(get, set) : Float;
    public var finishSizeVar(get, set) : Float;
    public var emitAngle(get, set) : Float;
    public var emitAngleVar(get, set) : Float;
    public var stRot(get, set) : Float;
    public var stRotVar(get, set) : Float;
    public var endRot(get, set) : Float;
    public var endRotVar(get, set) : Float;
    public var speed(get, set) : Float;
    public var speedVar(get, set) : Float;
    public var gravX(get, set) : Float;
    public var gravY(get, set) : Float;
    public var tanAcc(get, set) : Float;
    public var tanAccVar(get, set) : Float;
    public var radialAcc(get, set) : Float;
    public var radialAccVar(get, set) : Float;
    public var emitterType(get, set) : Int;
    public var maxRadius(get, set) : Float;
    public var maxRadiusVar(get, set) : Float;
    public var minRadius(get, set) : Float;
    public var minRadiusVar(get, set) : Float;
    public var degPerSec(get, set) : Float;
    public var degPerSecVar(get, set) : Float;
    public var sr(get, set) : Float;
    public var sg(get, set) : Float;
    public var sb(get, set) : Float;
    public var sa(get, set) : Float;
    public var fr(get, set) : Float;
    public var fg(get, set) : Float;
    public var fb(get, set) : Float;
    public var fa(get, set) : Float;
    public var svr(get, set) : Float;
    public var svg(get, set) : Float;
    public var svb(get, set) : Float;
    public var sva(get, set) : Float;
    public var fvr(get, set) : Float;
    public var fvg(get, set) : Float;
    public var fvb(get, set) : Float;
    public var fva(get, set) : Float;
    public var srcBlend(get, set) : Int;
    public var dstBlend(get, set) : Int;
    public var savePlist(get, set) : Bool;

    private var mListeners : Array<SettingsListener>;
    
    private var _xPosVar : Float = 0.0;
    private var _yPosVar : Float = 0.0;
    private var _maxParts : Float = 500.0;
    private var _lifeSpan : Float = 2.0;
    private var _lifeSpanVar : Float = 1.9;
    private var _startSize : Float = 70.0;
    private var _startSizeVar : Float = 49.53;
    private var _finishSize : Float = 10.0;
    private var _finishSizeVar : Float = 5.0;
    private var _emitAngle : Float = 270.0;
    private var _emitAngleVar : Float = 0.0;
    
    private var _stRot : Float = 0.0;
    private var _stRotVar : Float = 0.0;
    private var _endRot : Float = 0.0;
    private var _endRotVar : Float = 0.0;
    
    private var _speed : Float = 100;
    private var _speedVar : Float = 30.0;
    private var _gravX : Float = 0.0;
    private var _gravY : Float = 0.0;
    private var _tanAcc : Float = 0.0;
    private var _tanAccVar : Float = 0.0;
    private var _radialAcc : Float = 0.0;
    private var _radialAccVar : Float = 0.0;
    
    private var _emitterType : Int = 0;
    
    private var _maxRadius : Float = 100;
    private var _maxRadiusVar : Float = 0.0;
    private var _minRadius : Float = 0.0;
    private var _minRadiusVar : Float = 0.0;
    private var _degPerSec : Float = 0.0;
    private var _degPerSecVar : Float = 0.0;
    
    
    // <startColor red="1.00" green="0.31" blue="0.00" alpha="0.62"/>
    private var _sr : Float = 1.0;
    private var _sg : Float = .31;
    private var _sb : Float = 0.0;
    private var _sa : Float = .62;
    
    // <finishColor red="1.00" green="0.31" blue="0.00" alpha="0.00"/>
    private var _fr : Float = 1.0;
    private var _fg : Float = .31;
    private var _fb : Float = 0.0;
    private var _fa : Float = 0.0;
    
    private var _svr : Float = 0.0;
    private var _svg : Float = 0.0;
    private var _svb : Float = 0.0;
    private var _sva : Float = 0.0;
    
    private var _fvr : Float = 0.0;
    private var _fvg : Float = 0.0;
    private var _fvb : Float = 0.0;
    private var _fva : Float = 0.0;
    
    private var _srcBlend : Int = 0x302;
    private var _dstBlend : Int = 0x01;
    
    private var _savePlist : Bool = false;
    
    public function new()
    {
        super();
        mListeners = new Array<SettingsListener>();
    }
    
    public function addListener(listener : SettingsListener) : Void
    {
        mListeners.push(listener);
    }
    
    private function get_xPosVar() : Float
    {
        return _xPosVar;
    }
    
    private function set_xPosVar(value : Float) : Float
    {
        _xPosVar = value;
        
        for (listener in mListeners)
        {
            listener.updateXPosVariance(value);
        }
        return value;
    }
    
    private function get_yPosVar() : Float
    {
        return _yPosVar;
    }
    
    private function set_yPosVar(value : Float) : Float
    {
        _yPosVar = value;
        
        for (listener in mListeners)
        {
            listener.updateYPosVariance(value);
        }
        return value;
    }
    
    private function get_maxParts() : Float
    {
        return _maxParts;
    }
    
    private function set_maxParts(value : Float) : Float
    {
        _maxParts = value;
        
        for (listener in mListeners)
        {
            listener.updateMaxParticles(value);
        }
        return value;
    }
    
    private function get_lifeSpan() : Float
    {
        return _lifeSpan;
    }
    
    private function set_lifeSpan(value : Float) : Float
    {
        if (Math.isNaN(value))
        {
            value = 0.0;
        }
        
        _lifeSpan = value;
        
        for (listener in mListeners)
        {
            listener.updateLifeSpan(value);
        }
        return value;
    }
    
    private function get_lifeSpanVar() : Float
    {
        return _lifeSpanVar;
    }
    
    private function set_lifeSpanVar(value : Float) : Float
    {
        if (Math.isNaN(value))
        {
            value = 0.0;
        }
        
        _lifeSpanVar = value;
        
        for (listener in mListeners)
        {
            listener.updateLifeSpanVariance(value);
        }
        return value;
    }
    
    private function get_startSize() : Float
    {
        return _startSize;
    }
    
    private function set_startSize(value : Float) : Float
    {
        _startSize = value;
        
        for (listener in mListeners)
        {
            listener.updateStartSize(value);
        }
        return value;
    }
    
    private function get_startSizeVar() : Float
    {
        return _startSizeVar;
    }
    
    private function set_startSizeVar(value : Float) : Float
    {
        _startSizeVar = value;
        
        for (listener in mListeners)
        {
            listener.updateStartSizeVariance(value);
        }
        return value;
    }
    
    private function get_finishSize() : Float
    {
        return _finishSize;
    }
    
    private function set_finishSize(value : Float) : Float
    {
        _finishSize = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishSize(value);
        }
        return value;
    }
    
    private function get_finishSizeVar() : Float
    {
        return _finishSizeVar;
    }
    
    private function set_finishSizeVar(value : Float) : Float
    {
        if (Math.isNaN(value))
        {
            value = 0.0;
        }
        
        _finishSizeVar = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishSizeVariance(value);
        }
        return value;
    }
    
    private function get_emitAngle() : Float
    {
        return _emitAngle;
    }
    
    private function set_emitAngle(value : Float) : Float
    {
        _emitAngle = value;
        
        for (listener in mListeners)
        {
            listener.updateEmitAngle(value);
        }
        return value;
    }
    
    private function get_emitAngleVar() : Float
    {
        return _emitAngleVar;
    }
    
    private function set_emitAngleVar(value : Float) : Float
    {
        _emitAngleVar = value;
        
        for (listener in mListeners)
        {
            listener.updateEmitAngleVariance(value);
        }
        return value;
    }
    
    private function get_stRot() : Float
    {
        return _stRot;
    }
    
    private function set_stRot(value : Float) : Float
    {
        _stRot = value;
        
        for (listener in mListeners)
        {
            listener.updateStartRotation(value);
        }
        return value;
    }
    
    private function get_stRotVar() : Float
    {
        return _stRotVar;
    }
    
    private function set_stRotVar(value : Float) : Float
    {
        _stRotVar = value;
        
        for (listener in mListeners)
        {
            listener.updateStartRotationVariance(value);
        }
        return value;
    }
    
    private function get_endRot() : Float
    {
        return _endRot;
    }
    
    private function set_endRot(value : Float) : Float
    {
        _endRot = value;
        
        for (listener in mListeners)
        {
            listener.updateEndRotation(value);
        }
        return value;
    }
    
    private function get_endRotVar() : Float
    {
        return _endRotVar;
    }
    
    private function set_endRotVar(value : Float) : Float
    {
        _endRotVar = value;
        
        for (listener in mListeners)
        {
            listener.updateEndRotationVariance(value);
        }
        return value;
    }
    
    private function get_speed() : Float
    {
        return _speed;
    }
    
    private function set_speed(value : Float) : Float
    {
        _speed = value;
        
        for (listener in mListeners)
        {
            listener.updateSpeed(value);
        }
        return value;
    }
    
    private function get_speedVar() : Float
    {
        return _speedVar;
    }
    
    private function set_speedVar(value : Float) : Float
    {
        _speedVar = value;
        
        for (listener in mListeners)
        {
            listener.updateSpeedVariance(value);
        }
        return value;
    }
    
    private function get_gravX() : Float
    {
        return _gravX;
    }
    
    private function set_gravX(value : Float) : Float
    {
        _gravX = value;
        
        for (listener in mListeners)
        {
            listener.updateGravityX(value);
        }
        return value;
    }
    
    private function get_gravY() : Float
    {
        return _gravY;
    }
    
    private function set_gravY(value : Float) : Float
    {
        _gravY = value;
        
        for (listener in mListeners)
        {
            listener.updateGravityY(value);
        }
        return value;
    }
    
    private function get_tanAcc() : Float
    {
        return _tanAcc;
    }
    
    private function set_tanAcc(value : Float) : Float
    {
        _tanAcc = value;
        
        for (listener in mListeners)
        {
            listener.updateTanAcceleration(value);
        }
        return value;
    }
    
    private function get_tanAccVar() : Float
    {
        return _tanAccVar;
    }
    
    private function set_tanAccVar(value : Float) : Float
    {
        _tanAccVar = value;
        
        for (listener in mListeners)
        {
            listener.updateTanAccelerationVariance(value);
        }
        return value;
    }
    
    private function get_radialAcc() : Float
    {
        return _radialAcc;
    }
    
    private function set_radialAcc(value : Float) : Float
    {
        _radialAcc = value;
        
        for (listener in mListeners)
        {
            listener.updateRadialAcceleration(value);
        }
        return value;
    }
    
    private function get_radialAccVar() : Float
    {
        return _radialAccVar;
    }
    
    private function set_radialAccVar(value : Float) : Float
    {
        _radialAccVar = value;
        
        for (listener in mListeners)
        {
            listener.updateRadialAccelerationVariance(value);
        }
        return value;
    }
    
    private function get_emitterType() : Int
    {
        return _emitterType;
    }
    
    private function set_emitterType(value : Int) : Int
    {
        _emitterType = value;
        
        for (listener in mListeners)
        {
            listener.updateEmitterType(value);
        }
        return value;
    }
    
    private function get_maxRadius() : Float
    {
        return _maxRadius;
    }
    
    private function set_maxRadius(value : Float) : Float
    {
        _maxRadius = value;
        
        for (listener in mListeners)
        {
            listener.updateMaxRadius(value);
        }
        return value;
    }
    
    private function get_maxRadiusVar() : Float
    {
        return _maxRadiusVar;
    }
    
    private function set_maxRadiusVar(value : Float) : Float
    {
        _maxRadiusVar = value;
        
        for (listener in mListeners)
        {
            listener.updateMaxRadiusVariance(value);
        }
        return value;
    }
    
    private function get_minRadius() : Float
    {
        return _minRadius;
    }
    
    private function set_minRadius(value : Float) : Float
    {
        _minRadius = value;
        
        for (listener in mListeners)
        {
            listener.updateMinRadius(value);
        }
        return value;
    }
    
    private function get_minRadiusVar() : Float
    {
        return _minRadiusVar;
    }
    
    private function set_minRadiusVar(value : Float) : Float
    {
        if (Math.isNaN(value))
        {
            value = 0.0;
        }
        
        _minRadiusVar = value;
        
        for (listener in mListeners)
        {
            listener.updateMinRadiusVariance(value);
        }
        return value;
    }
    
    private function get_degPerSec() : Float
    {
        return _degPerSec;
    }
    
    private function set_degPerSec(value : Float) : Float
    {
        _degPerSec = value;
        
        for (listener in mListeners)
        {
            listener.updateDegreesPerSecond(value);
        }
        return value;
    }
    
    private function get_degPerSecVar() : Float
    {
        return _degPerSecVar;
    }
    
    private function set_degPerSecVar(value : Float) : Float
    {
        _degPerSecVar = value;
        
        for (listener in mListeners)
        {
            listener.updateDegreesPerSecondVariance(value);
        }
        return value;
    }
    
    private function get_sr() : Float
    {
        return _sr;
    }
    
    private function set_sr(value : Float) : Float
    {
        _sr = value;
        
        for (listener in mListeners)
        {
            listener.updateStartRed(value);
        }
        return value;
    }
    
    private function get_sg() : Float
    {
        return _sg;
    }
    
    private function set_sg(value : Float) : Float
    {
        _sg = value;
        
        for (listener in mListeners)
        {
            listener.updateStartGreen(value);
        }
        return value;
    }
    
    private function get_sb() : Float
    {
        return _sb;
    }
    
    private function set_sb(value : Float) : Float
    {
        _sb = value;
        
        for (listener in mListeners)
        {
            listener.updateStartBlue(value);
        }
        return value;
    }
    
    private function get_sa() : Float
    {
        return _sa;
    }
    
    private function set_sa(value : Float) : Float
    {
        _sa = value;
        
        for (listener in mListeners)
        {
            listener.updateStartAlpha(value);
        }
        return value;
    }
    
    private function get_fr() : Float
    {
        return _fr;
    }
    
    private function set_fr(value : Float) : Float
    {
        _fr = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishRed(value);
        }
        return value;
    }
    
    private function get_fg() : Float
    {
        return _fg;
    }
    
    private function set_fg(value : Float) : Float
    {
        _fg = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishGreen(value);
        }
        return value;
    }
    
    private function get_fb() : Float
    {
        return _fb;
    }
    
    private function set_fb(value : Float) : Float
    {
        _fb = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishBlue(value);
        }
        return value;
    }
    
    private function get_fa() : Float
    {
        return _fa;
    }
    
    private function set_fa(value : Float) : Float
    {
        _fa = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishAlpha(value);
        }
        return value;
    }
    
    private function get_svr() : Float
    {
        return _svr;
    }
    
    private function set_svr(value : Float) : Float
    {
        _svr = value;
        
        for (listener in mListeners)
        {
            listener.updateStartRedVariance(value);
        }
        return value;
    }
    
    private function get_svg() : Float
    {
        return _svg;
    }
    
    private function set_svg(value : Float) : Float
    {
        _svg = value;
        
        for (listener in mListeners)
        {
            listener.updateStartGreenVariance(value);
        }
        return value;
    }
    
    private function get_svb() : Float
    {
        return _svb;
    }
    
    private function set_svb(value : Float) : Float
    {
        _svb = value;
        
        for (listener in mListeners)
        {
            listener.updateStartBlueVariance(value);
        }
        return value;
    }
    
    private function get_sva() : Float
    {
        return _sva;
    }
    
    private function set_sva(value : Float) : Float
    {
        _sva = value;
        
        for (listener in mListeners)
        {
            listener.updateStartAlphaVariance(value);
        }
        return value;
    }
    
    private function get_fvr() : Float
    {
        return _fvr;
    }
    
    private function set_fvr(value : Float) : Float
    {
        _fvr = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishRedVariance(value);
        }
        return value;
    }
    
    private function get_fvg() : Float
    {
        return _fvg;
    }
    
    private function set_fvg(value : Float) : Float
    {
        _fvg = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishGreenVariance(value);
        }
        return value;
    }
    
    private function get_fvb() : Float
    {
        return _fvb;
    }
    
    private function set_fvb(value : Float) : Float
    {
        _fvb = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishBlueVariance(value);
        }
        return value;
    }
    
    private function get_fva() : Float
    {
        return _fva;
    }
    
    private function set_fva(value : Float) : Float
    {
        _fva = value;
        
        for (listener in mListeners)
        {
            listener.updateFinishAlphaVariance(value);
        }
        return value;
    }
    
    private function get_srcBlend() : Int
    {
        return _srcBlend;
    }
    
    private function set_srcBlend(value : Int) : Int
    {
        _srcBlend = value;
        
        for (listener in mListeners)
        {
            listener.updateSourceBlend(value);
        }
        return value;
    }
    
    private function get_dstBlend() : Int
    {
        return _dstBlend;
    }
    
    private function set_dstBlend(value : Int) : Int
    {
        _dstBlend = value;
        
        for (listener in mListeners)
        {
            listener.updateDestinationBlend(value);
        }
        return value;
    }
    
    private function get_savePlist() : Bool
    {
        return _savePlist;
    }
    
    private function set_savePlist(value : Bool) : Bool
    {
        _savePlist = value;
        return value;
    }
}

