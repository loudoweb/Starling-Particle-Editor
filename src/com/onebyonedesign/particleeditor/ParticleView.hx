/**
 *	Copyright (c) 2014 Devon O. Wolfgang
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

import openfl.Assets;
import openfl.display.BitmapData;
import haxe.xml.Access;
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.PDParticleSystem;
import starling.textures.Texture;

/**
	 * The Starling particle system view
	 * @author Devon O.
	 */
class ParticleView extends Sprite implements SettingsListener
{
    public var settings(never, set) : SettingsModel;
    public var particleData(get, set) : BitmapData;
    public var particleConfig(never, set) : ParticleConfiguration;

    public static var CIRCLE_DATA : BitmapData;
    public static var STAR_DATA : BitmapData;
    public static var BLOB_DATA : BitmapData;
    public static var CUSTOM_DATA : BitmapData;
    public static var SELECTED_DATA : BitmapData;
    public static var HEART_DATA : BitmapData;
    
    /** the particle system */
    private var mParticleSystem : PDParticleSystem;
    
    /** Particle texture */
    private var mTexture : Texture;
    
    /** Settings */
    private var mSettings : SettingsModel;
    
    /** Particle Config */
    private var mParticleConfig : ParticleConfiguration;
    
    public function new()
    {
        super();
        CIRCLE_DATA = Assets.getBitmapData("assets/fire_particle.png");
        STAR_DATA = Assets.getBitmapData("assets/star.png");
        BLOB_DATA = Assets.getBitmapData("assets/blob.png");
        HEART_DATA = Assets.getBitmapData("assets/heart.png");
        CUSTOM_DATA = new BitmapData(64, 64, true, 0x00000000);
        
        SELECTED_DATA = CIRCLE_DATA;
    }
    
    /** Set the Settings Model */
    private function set_settings(value : SettingsModel) : SettingsModel
    {
        mSettings = value;
        mSettings.addListener(this);
        return value;
    }
    
    /** Set the bitmap data for the particle system particle */
    private function set_particleData(value : BitmapData) : BitmapData
    {
        SELECTED_DATA = value;
        recreateSystem();
        return value;
    }
    
    /** Set the particle system config */
    private function set_particleConfig(value : ParticleConfiguration) : ParticleConfiguration
    {
        this.mParticleConfig = value;
        init(mParticleConfig.xml.x.toString());
        return value;
    }
    
    /** get the particle system particle bitmap data */
    private function get_particleData() : BitmapData
    {
        return SELECTED_DATA;
    }
    
    /* INTERFACE com.onebyonedesign.particleeditor.SettingsListener */
    
    public function updateXPosVariance(value : Float) : Void
    {
        mParticleSystem.emitterXVariance = value;
    }
    
    public function updateYPosVariance(value : Float) : Void
    {
        mParticleSystem.emitterYVariance = value;
    }
    
    public function updateMaxParticles(value : Float) : Void
    {
        //mParticleSystem.mMaxNumParticles = value;
        mParticleSystem.capacity = Std.int(value);
        mParticleSystem.emissionRate = mParticleSystem.capacity / mParticleSystem.lifespan;
    }
    
    public function updateLifeSpan(value : Float) : Void
    {
        mParticleSystem.lifespan = value;
    }
    
    public function updateLifeSpanVariance(value : Float) : Void
    {
        mParticleSystem.lifespanVariance = value;
    }
    
    public function updateStartSize(value : Float) : Void
    {
        mParticleSystem.startSize = value;
    }
    
    public function updateStartSizeVariance(value : Float) : Void
    {
        mParticleSystem.startSizeVariance = value;
    }
    
    public function updateFinishSize(value : Float) : Void
    {
        mParticleSystem.endSize = value;
    }
    
    public function updateFinishSizeVariance(value : Float) : Void
    {
        mParticleSystem.endSizeVariance = value;
    }
    
    public function updateEmitAngle(value : Float) : Void
    {
        mParticleSystem.emitAngle = value * Math.PI / 180;
    }
    
    public function updateEmitAngleVariance(value : Float) : Void
    {
        mParticleSystem.emitAngleVariance = value * Math.PI / 180;
    }
    
    public function updateStartRotation(value : Float) : Void
    {
        mParticleSystem.startRotation = value * Math.PI / 180;
    }
    
    public function updateStartRotationVariance(value : Float) : Void
    {
        mParticleSystem.startRotationVariance = value * Math.PI / 180;
    }
    
    public function updateEndRotation(value : Float) : Void
    {
        mParticleSystem.endRotation = value * Math.PI / 180;
    }
    
    public function updateEndRotationVariance(value : Float) : Void
    {
        mParticleSystem.endRotationVariance = value * Math.PI / 180;
    }
    
    public function updateSpeed(value : Float) : Void
    {
        mParticleSystem.speed = value;
    }
    
    public function updateSpeedVariance(value : Float) : Void
    {
        mParticleSystem.speedVariance = value;
    }
    
    public function updateGravityX(value : Float) : Void
    {
        mParticleSystem.gravityX = value;
    }
    
    public function updateGravityY(value : Float) : Void
    {
        mParticleSystem.gravityY = value;
    }
    
    public function updateTanAcceleration(value : Float) : Void
    {
        mParticleSystem.tangentialAcceleration = value;
    }
    
    public function updateTanAccelerationVariance(value : Float) : Void
    {
        mParticleSystem.tangentialAccelerationVariance = value;
    }
    
    public function updateRadialAcceleration(value : Float) : Void
    {
        mParticleSystem.radialAcceleration = value;
    }
    
    public function updateRadialAccelerationVariance(value : Float) : Void
    {
        mParticleSystem.radialAccelerationVariance = value;
    }
    
    public function updateEmitterType(value : Int) : Void
    {
        mParticleSystem.emitterType = value;
    }
    
    public function updateMaxRadius(value : Float) : Void
    {
        mParticleSystem.maxRadius = value;
    }
    
    public function updateMaxRadiusVariance(value : Float) : Void
    {
        mParticleSystem.maxRadiusVariance = value;
    }
    
    public function updateMinRadius(value : Float) : Void
    {
        mParticleSystem.minRadius = value;
    }
    
    public function updateMinRadiusVariance(value : Float) : Void
    {
        mParticleSystem.minRadiusVariance = value;
    }
    
    public function updateDegreesPerSecond(value : Float) : Void
    {
        mParticleSystem.rotatePerSecond = value * Math.PI / 180;
    }
    
    public function updateDegreesPerSecondVariance(value : Float) : Void
    {
        mParticleSystem.rotatePerSecondVariance = value * Math.PI / 180;
    }
    
    public function updateStartRed(value : Float) : Void
    {
        mParticleSystem.startColor.red = value;
    }
    
    public function updateStartGreen(value : Float) : Void
    {
        mParticleSystem.startColor.green = value;
    }
    
    public function updateStartBlue(value : Float) : Void
    {
        mParticleSystem.startColor.blue = value;
    }
    
    public function updateStartAlpha(value : Float) : Void
    {
        mParticleSystem.startColor.alpha = value;
    }
    
    public function updateFinishRed(value : Float) : Void
    {
        mParticleSystem.endColor.red = value;
    }
    
    public function updateFinishGreen(value : Float) : Void
    {
        mParticleSystem.endColor.green = value;
    }
    
    public function updateFinishBlue(value : Float) : Void
    {
        mParticleSystem.endColor.blue = value;
    }
    
    public function updateFinishAlpha(value : Float) : Void
    {
        mParticleSystem.endColor.alpha = value;
    }
    
    public function updateStartRedVariance(value : Float) : Void
    {
        mParticleSystem.startColorVariance.red = value;
    }
    
    public function updateStartGreenVariance(value : Float) : Void
    {
        mParticleSystem.startColorVariance.green = value;
    }
    
    public function updateStartBlueVariance(value : Float) : Void
    {
        mParticleSystem.startColorVariance.blue = value;
    }
    
    public function updateStartAlphaVariance(value : Float) : Void
    {
        mParticleSystem.startColorVariance.alpha = value;
    }
    
    public function updateFinishRedVariance(value : Float) : Void
    {
        mParticleSystem.endColorVariance.red = value;
    }
    
    public function updateFinishGreenVariance(value : Float) : Void
    {
        mParticleSystem.endColorVariance.green = value;
    }
    
    public function updateFinishBlueVariance(value : Float) : Void
    {
        mParticleSystem.endColorVariance.blue = value;
    }
    
    public function updateFinishAlphaVariance(value : Float) : Void
    {
        mParticleSystem.endColorVariance.alpha = value;
    }
    
    public function updateSourceBlend(value : Int) : Void
    {
        recreateSystem();
    }
    
    public function updateDestinationBlend(value : Int) : Void
    {
        recreateSystem();
    }
    
    /** Initialize the particle system */
    private function init(cfg : String) : Void
    {
        mTexture = Texture.fromBitmapData(SELECTED_DATA);
        mParticleSystem = new PDParticleSystem(cfg, mTexture);
        mParticleSystem.emitterX = 200;
        mParticleSystem.emitterY = 300;
        addChild(mParticleSystem);
        
        startSystem();
    }
    
    /** Start the particle system */
    private function startSystem() : Void
    {
        stage.addEventListener(TouchEvent.TOUCH, onTouch);
        Starling.current.juggler.add(mParticleSystem);
        mParticleSystem.start();
    }
    
    /** Move the particle system with mouse click and drag */
    private function onTouch(event : TouchEvent) : Void
    {
        var touch : Touch = event.getTouch(stage);
        if (touch != null && touch.phase != TouchPhase.HOVER)
        {
            if (touch.globalX <= 400 && touch.globalY <= 500)
            {
                mParticleSystem.emitterX = touch.globalX;
                mParticleSystem.emitterY = touch.globalY;
            }
        }
    }
    
    /** destroy then recreate particle system from updated config */
    private function recreateSystem() : Void
    {
        var ex : Float = mParticleSystem.emitterX;
        var ey : Float = mParticleSystem.emitterY;
        mParticleSystem.stop();
        Starling.current.juggler.remove(mParticleSystem);
        removeChild(mParticleSystem);
        mParticleSystem.dispose();
        
        mTexture.dispose();
        
        mTexture = Texture.fromBitmapData(SELECTED_DATA);
        mParticleSystem = new PDParticleSystem(mParticleConfig.xml.x.toString(), mTexture);
        mParticleSystem.emitterX = ex;
        mParticleSystem.emitterY = ey;
        mParticleSystem.start();
        Starling.current.juggler.add(mParticleSystem);
        addChild(mParticleSystem);
    }
}

