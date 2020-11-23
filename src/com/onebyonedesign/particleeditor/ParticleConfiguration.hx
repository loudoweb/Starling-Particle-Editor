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
import haxe.xml.Access;


/**
 * Holds and updates the XML Config for the given particle
 * @author Devon O.
 */
class ParticleConfiguration implements SettingsListener
{
    public var xml(get, never) : Access;

    
    /** Particle configuration (.pex) */
    private var mConfig : Access;
    
    public function new(initialConfig : Access)
    {
        mConfig = initialConfig;
    }
    
    /** Randomize all particle x.settings */
    public function randomize() : Void
    {
        var randSetting : Float;
		
		randSetting = randRange(1, 0, 0);
        mConfig.node.emitterType.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(1000, 1, 2);
        mConfig.node.maxParticles.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(10, 0, 2);
        mConfig.node.particleLifeSpan.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(10, 0, 2);
        mConfig.node.particleLifespanVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(70, 0, 2);
        mConfig.node.startParticleSize.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(70, 0, 2);
        mConfig.node.startParticleSizeVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(70, 0, 2);
        mConfig.node.finishParticleSize.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(70, 0, 2);
        mConfig.node.FinishParticleSizeVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.angle.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.angleVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.rotationStart.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.rotationStartVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.rotationEnd.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.rotationEndVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(1000, 0, 2);
        mConfig.node.sourcePositionVariance.x.set("x", Std.string(randSetting));
        
       randSetting = randRange(1000, 0, 2);
        mConfig.node.sourcePositionVariance.x.set("y", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.speed.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.speedVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, -500, 2);
        mConfig.node.gravity.x.set("x", Std.string(randSetting));
        
       randSetting = randRange(500, -500, 2);
        mConfig.node.gravity.x.set("y", Std.string(randSetting));
        
       randSetting = randRange(500, -500, 2);
        mConfig.node.tangentialAcceleration.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.tangentialAccelVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, -500, 2);
        mConfig.node.radialAcceleration.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.radialAccelVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.maxRadius.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.maxRadiusVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.minRadius.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(500, 0, 2);
        mConfig.node.minRadiusVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, -360, 2);
        mConfig.node.rotatePerSecond.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(360, 0, 2);
        mConfig.node.rotatePerSecondVariance.x.set("value", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColor.x.set("red", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColor.x.set("green", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColor.x.set("blue", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColor.x.set("alpha", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColor.x.set("red", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColor.x.set("green", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColor.x.set("blue", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColor.x.set("alpha", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColorVariance.x.set("red", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColorVariance.x.set("green", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColorVariance.x.set("blue", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.startColorVariance.x.set("alpha", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColorVariance.x.set("red", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColorVariance.x.set("green", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColorVariance.x.set("blue", Std.string(randSetting));
        
       randSetting = randRange(1, 0, 2);
        mConfig.node.finishColorVariance.x.set("alpha", Std.string(randSetting));
    }
    
    /* INTERFACE com.onebyonedesign.particleeditor.x.settingsListener */
    
    public function updateXPosVariance(value : Float) : Void
    {
        mConfig.node.sourcePositionVariance.x.set("x", Std.string(value));
    }
    
    public function updateYPosVariance(value : Float) : Void
    {
        mConfig.node.sourcePositionVariance.x.set("y", Std.string(value));
    }
    
    public function updateMaxParticles(value : Float) : Void
    {
        mConfig.node.maxParticles.x.set("value", Std.string(value));
    }
    
    public function updateLifeSpan(value : Float) : Void
    {
        mConfig.node.particleLifeSpan.x.set("value", Std.string(value));
    }
    
    public function updateLifeSpanVariance(value : Float) : Void
    {
        mConfig.node.particleLifespanVariance.x.set("value", Std.string(value));
    }
    
    public function updateStartSize(value : Float) : Void
    {
        mConfig.node.startParticleSize.x.set("value", Std.string(value));
    }
    
    public function updateStartSizeVariance(value : Float) : Void
    {
        mConfig.node.startParticleSizeVariance.x.set("value", Std.string(value));
    }
    
    public function updateFinishSize(value : Float) : Void
    {
        mConfig.node.finishParticleSize.x.set("value", Std.string(value));
    }
    
    public function updateFinishSizeVariance(value : Float) : Void
    {
        mConfig.node.FinishParticleSizeVariance.x.set("value", Std.string(value));
    }
    
    public function updateEmitAngle(value : Float) : Void
    {
        mConfig.node.angle.x.set("value", Std.string(value));
    }
    
    public function updateEmitAngleVariance(value : Float) : Void
    {
        mConfig.node.angleVariance.x.set("value", Std.string(value));
    }
    
    public function updateStartRotation(value : Float) : Void
    {
        mConfig.node.rotationStart.x.set("value", Std.string(value));
    }
    
    public function updateStartRotationVariance(value : Float) : Void
    {
        mConfig.node.rotationStartVariance.x.set("value", Std.string(value));
    }
    
    public function updateEndRotation(value : Float) : Void
    {
        mConfig.node.rotationEnd.x.set("value", Std.string(value));
    }
    
    public function updateEndRotationVariance(value : Float) : Void
    {
        mConfig.node.rotationEndVariance.x.set("value", Std.string(value));
    }
    
    public function updateSpeed(value : Float) : Void
    {
        mConfig.node.speed.x.set("value", Std.string(value));
    }
    
    public function updateSpeedVariance(value : Float) : Void
    {
        mConfig.node.speedVariance.x.set("value", Std.string(value));
    }
    
    public function updateGravityX(value : Float) : Void
    {
        mConfig.node.gravity.x.set("x", Std.string(value));
    }
    
    public function updateGravityY(value : Float) : Void
    {
        mConfig.node.gravity.x.set("y", Std.string(value));
    }
    
    public function updateTanAcceleration(value : Float) : Void
    {
        mConfig.node.tangentialAcceleration.x.set("value", Std.string(value));
    }
    
    public function updateTanAccelerationVariance(value : Float) : Void
    {
        mConfig.node.tangentialAccelVariance.x.set("value", Std.string(value));
    }
    
    public function updateRadialAcceleration(value : Float) : Void
    {
        mConfig.node.radialAcceleration.x.set("value", Std.string(value));
    }
    
    public function updateRadialAccelerationVariance(value : Float) : Void
    {
        mConfig.node.radialAccelVariance.x.set("value", Std.string(value));
    }
    
    public function updateEmitterType(value : Int) : Void
    {
        mConfig.node.emitterType.x.set("value", Std.string(value));
    }
    
    public function updateMaxRadius(value : Float) : Void
    {
        mConfig.node.maxRadius.x.set("value", Std.string(value));
    }
    
    public function updateMaxRadiusVariance(value : Float) : Void
    {
        mConfig.node.maxRadiusVariance.x.set("value", Std.string(value));
    }
    
    public function updateMinRadius(value : Float) : Void
    {
        mConfig.node.minRadius.x.set("value", Std.string(value));
    }
    
    public function updateMinRadiusVariance(value : Float) : Void
    {
        mConfig.node.minRadiusVariance.x.set("value", Std.string(value));
    }
    
    public function updateDegreesPerSecond(value : Float) : Void
    {
        mConfig.node.rotatePerSecond.x.set("value", Std.string(value));
    }
    
    public function updateDegreesPerSecondVariance(value : Float) : Void
    {
        mConfig.node.rotatePerSecondVariance.x.set("value", Std.string(value));
    }
    
    public function updateStartRed(value : Float) : Void
    {
        mConfig.node.startColor.x.set("red", Std.string(value));
    }
    
    public function updateStartGreen(value : Float) : Void
    {
        mConfig.node.startColor.x.set("green", Std.string(value));
    }
    
    public function updateStartBlue(value : Float) : Void
    {
        mConfig.node.startColor.x.set("blue", Std.string(value));
    }
    
    public function updateStartAlpha(value : Float) : Void
    {
        mConfig.node.startColor.x.set("alpha", Std.string(value));
    }
    
    public function updateFinishRed(value : Float) : Void
    {
        mConfig.node.finishColor.x.set("red", Std.string(value));
    }
    
    public function updateFinishGreen(value : Float) : Void
    {
        mConfig.node.finishColor.x.set("green", Std.string(value));
    }
    
    public function updateFinishBlue(value : Float) : Void
    {
        mConfig.node.finishColor.x.set("blue", Std.string(value));
    }
    
    public function updateFinishAlpha(value : Float) : Void
    {
        mConfig.node.finishColor.x.set("alpha", Std.string(value));
    }
    
    public function updateStartRedVariance(value : Float) : Void
    {
        mConfig.node.startColorVariance.x.set("red", Std.string(value));
    }
    
    public function updateStartGreenVariance(value : Float) : Void
    {
        mConfig.node.startColorVariance.x.set("green", Std.string(value));
    }
    
    public function updateStartBlueVariance(value : Float) : Void
    {
        mConfig.node.startColorVariance.x.set("blue", Std.string(value));
    }
    
    public function updateStartAlphaVariance(value : Float) : Void
    {
        mConfig.node.startColorVariance.x.set("alpha", Std.string(value));
    }
    
    public function updateFinishRedVariance(value : Float) : Void
    {
        mConfig.node.finishColorVariance.x.set("red", Std.string(value));
    }
    
    public function updateFinishGreenVariance(value : Float) : Void
    {
        mConfig.node.finishColorVariance.x.set("green", Std.string(value));
    }
    
    public function updateFinishBlueVariance(value : Float) : Void
    {
        mConfig.node.finishColorVariance.x.set("blue", Std.string(value));
    }
    
    public function updateFinishAlphaVariance(value : Float) : Void
    {
        mConfig.node.finishColorVariance.x.set("alpha", Std.string(value));
    }
    
    public function updateSourceBlend(value : Int) : Void
    {
        mConfig.node.blendFuncSource.x.set("value", Std.string(value));
    }
    
    public function updateDestinationBlend(value : Int) : Void
    {
        mConfig.node.blendFuncDestination.x.set("value", Std.string(value));
    }
    
    private function get_xml() : Access
    {
        return mConfig;
    }
    
    /** Create a random number between min and max with decimals decimal places */
    private function randRange(max : Float, min = 0.0, decimals = 0) : Float
    {
        if (min > max)
        {
            return Math.NaN;
        }
        var rand : Float = Math.random() * (max - min) + min;
        var d : Float = Math.pow(10, decimals);
        return ~~Math.round((d * rand) + 0.5) / d;
    }
}

