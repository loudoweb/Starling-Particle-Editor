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


interface SettingsListener
{

    function updateXPosVariance(value : Float) : Void
    ;
    function updateYPosVariance(value : Float) : Void
    ;
    function updateMaxParticles(value : Float) : Void
    ;
    function updateLifeSpan(value : Float) : Void
    ;
    function updateLifeSpanVariance(value : Float) : Void
    ;
    function updateStartSize(value : Float) : Void
    ;
    function updateStartSizeVariance(value : Float) : Void
    ;
    function updateFinishSize(value : Float) : Void
    ;
    function updateFinishSizeVariance(value : Float) : Void
    ;
    function updateEmitAngle(value : Float) : Void
    ;
    function updateEmitAngleVariance(value : Float) : Void
    ;
    
    function updateStartRotation(value : Float) : Void
    ;
    function updateStartRotationVariance(value : Float) : Void
    ;
    function updateEndRotation(value : Float) : Void
    ;
    function updateEndRotationVariance(value : Float) : Void
    ;
    
    function updateSpeed(value : Float) : Void
    ;
    function updateSpeedVariance(value : Float) : Void
    ;
    function updateGravityX(value : Float) : Void
    ;
    function updateGravityY(value : Float) : Void
    ;
    function updateTanAcceleration(value : Float) : Void
    ;
    function updateTanAccelerationVariance(value : Float) : Void
    ;
    function updateRadialAcceleration(value : Float) : Void
    ;
    function updateRadialAccelerationVariance(value : Float) : Void
    ;
    
    function updateEmitterType(value : Int) : Void
    ;
    
    function updateMaxRadius(value : Float) : Void
    ;
    function updateMaxRadiusVariance(value : Float) : Void
    ;
    function updateMinRadius(value : Float) : Void
    ;
    function updateMinRadiusVariance(value : Float) : Void
    ;
    function updateDegreesPerSecond(value : Float) : Void
    ;
    function updateDegreesPerSecondVariance(value : Float) : Void
    ;
    
    function updateStartRed(value : Float) : Void
    ;
    function updateStartGreen(value : Float) : Void
    ;
    function updateStartBlue(value : Float) : Void
    ;
    function updateStartAlpha(value : Float) : Void
    ;
    
    function updateFinishRed(value : Float) : Void
    ;
    function updateFinishGreen(value : Float) : Void
    ;
    function updateFinishBlue(value : Float) : Void
    ;
    function updateFinishAlpha(value : Float) : Void
    ;
    
    function updateStartRedVariance(value : Float) : Void
    ;
    function updateStartGreenVariance(value : Float) : Void
    ;
    function updateStartBlueVariance(value : Float) : Void
    ;
    function updateStartAlphaVariance(value : Float) : Void
    ;
    
    function updateFinishRedVariance(value : Float) : Void
    ;
    function updateFinishGreenVariance(value : Float) : Void
    ;
    function updateFinishBlueVariance(value : Float) : Void
    ;
    function updateFinishAlphaVariance(value : Float) : Void
    ;
    
    function updateSourceBlend(value : Int) : Void
    ;
    function updateDestinationBlend(value : Int) : Void
    ;
}

