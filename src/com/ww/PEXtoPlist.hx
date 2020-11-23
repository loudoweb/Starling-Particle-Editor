/**
 *	Copyright (c) 2013 Devon O. Wolfgang, Jack Ront
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

package com.ww;

import haxe.xml.Access;

/**
	 * Converts an xml string into a plist string. 
	 * Primarily the work of Jack Ront of allplaynowork.com
	 * 
	 * @author Devon O.
	 * @author Jack Ront
	 */
class PEXtoPlist
{
	
    
    public function new()
    {
    }
    
    /**
		 * Creates a plist from the passed xml string
		 * @param	$pexData	XML String of .pex file
		 * @return
		 */
    public static function createPlist(pexData : String) : Xml
    {
        var pexXML : Xml = Xml.parse(pexData);
        var pexFast : Access = new Access(pexXML.firstChild());
        var plistXML : Xml = getBlankPlist();
        var dictXML : Xml = plistXML.firstElement().firstElement();
        
        // Do conversions.
        convertToInteger(dictXML, "maxParticles", pexFast);
        
        // Angle.
        convertToNumber(dictXML, "angle", pexFast);
        convertToNumber(dictXML, "angleVariance", pexFast);
        
        // Duration.
        convertToNumber(dictXML, "duration", pexFast);
        
        // Blend func.
        convertToInteger(dictXML, "blendFuncSource", pexFast);
        convertToInteger(dictXML, "blendFuncDestination", pexFast);
        
        // Colours.
        convertToNumber(dictXML, "startColorRed", pexFast, "startColor", "red");
        convertToNumber(dictXML, "startColorGreen", pexFast, "startColor", "green");
        convertToNumber(dictXML, "startColorBlue", pexFast, "startColor", "blue");
        convertToNumber(dictXML, "startColorAlpha", pexFast, "startColor", "alpha");
        
        convertToNumber(dictXML, "startColorVarianceRed", pexFast, "startColorVariance", "red");
        convertToNumber(dictXML, "startColorVarianceGreen", pexFast, "startColorVariance", "green");
        convertToNumber(dictXML, "startColorVarianceBlue", pexFast, "startColorVariance", "blue");
        convertToNumber(dictXML, "startColorVarianceAlpha", pexFast, "startColorVariance", "alpha");
        
        convertToNumber(dictXML, "finishColorRed", pexFast, "finishColor", "red");
        convertToNumber(dictXML, "finishColorGreen", pexFast, "finishColor", "green");
        convertToNumber(dictXML, "finishColorBlue", pexFast, "finishColor", "blue");
        convertToNumber(dictXML, "finishColorAlpha", pexFast, "finishColor", "alpha");
        
        convertToNumber(dictXML, "finishColorVarianceRed", pexFast, "finishColorVariance", "red");
        convertToNumber(dictXML, "finishColorVarianceGreen", pexFast, "finishColorVariance", "green");
        convertToNumber(dictXML, "finishColorVarianceBlue", pexFast, "finishColorVariance", "blue");
        convertToNumber(dictXML, "finishColorVarianceAlpha", pexFast, "finishColorVariance", "alpha");
        
        // Particle size.
        convertToNumber(dictXML, "startParticleSize", pexFast);
        convertToNumber(dictXML, "startParticleSizeVariance", pexFast);
        convertToNumber(dictXML, "finishParticleSize", pexFast);
        convertToNumber(dictXML, "finishParticleSizeVariance", pexFast, "FinishParticleSizeVariance");
        
        //Position.
        convertToNumber(dictXML, "sourcePositionx", pexFast, "sourcePosition", "x");
        convertToNumber(dictXML, "sourcePositiony", pexFast, "sourcePosition", "y");
        convertToNumber(dictXML, "sourcePositionVariancex", pexFast, "sourcePositionVariance", "x");
        convertToNumber(dictXML, "sourcePositionVariancey", pexFast, "sourcePositionVariance", "y");
        
        // Spinning.
        convertToNumber(dictXML, "rotationStart", pexFast);
        convertToNumber(dictXML, "rotationStartVariance", pexFast);
        convertToNumber(dictXML, "rotationEnd", pexFast);
        convertToNumber(dictXML, "rotationEndVariance", pexFast);
        
        // Emitter mode.
        convertToInteger(dictXML, "emitterType", pexFast);
        
        ///// Mode A: Gravity + tangential accel + radial accel.
        
        // Gravity.
        convertToNumber(dictXML, "gravityx", pexFast, "gravity", "x");
        convertToNumber(dictXML, "gravityy", pexFast, "gravity", "y");
        
        // Speed.
        convertToNumber(dictXML, "speed", pexFast);
        convertToNumber(dictXML, "speedVariance", pexFast);
        
        // Radial acceleration.
        convertToNumber(dictXML, "radialAcceleration", pexFast);
        convertToNumber(dictXML, "radialAccelVariance", pexFast);
        
        // Tangential acceleration.
        convertToNumber(dictXML, "tangentialAcceleration", pexFast);
        convertToNumber(dictXML, "tangentialAccelVariance", pexFast);
        
        ///// Mode B: radius movement.
        
        //Radius.
        convertToNumber(dictXML, "maxRadius", pexFast);
        convertToNumber(dictXML, "maxRadiusVariance", pexFast);
        convertToNumber(dictXML, "minRadius", pexFast);
        
        // Rotations per second.
        convertToNumber(dictXML, "rotatePerSecond", pexFast);
        convertToNumber(dictXML, "rotatePerSecondVariance", pexFast);
        
        ///// End of mode specific params.
        
        // Life span.
        convertToNumber(dictXML, "particleLifeSpan", pexFast);
        convertToNumber(dictXML, "particleLifespanVariance", pexFast);
        
        // Texture.
        convertToString(dictXML, "textureFileName", pexFast, "texture", "name");
        
        
        // Print plist.
        return getExportXML(plistXML);
    }
    
    private static function getBlankPlist() : Xml
    {
        return Xml.parse("<plist version=\"1.0\">\n<dict>\n</dict>\n</plist>");
    }
    
    private static function getExportXML(xml : Xml) : Xml
    {
        
		xml.insertChild(Xml.parse("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"), 0);
        
        return xml;
    }
    
    private static function extractValue(pex : Access, plistKey : String, pexChildName : String, pexAttributeKey : String) : String
    {
        var str : String;
        
        if (pexAttributeKey == null)
        {
            pexAttributeKey = "value";
        }
        
        if (pexChildName == null)
        {
            pexChildName = plistKey;
        }
        
        str = pex.node.resolve(pexChildName).att.resolve(pexAttributeKey);
        
        return str;
    }
    
    private static function convertToNumber(plist : Xml, plistKey : String, pex : Access, pexChildName : String = null, pexAttributeKey : String = null, mult : Float = 1) : Void
    //			trace("convertToNumber(" + $plistKey + ", " + $pexAttributeKey + ", " + $pexChildName + ")");
    {
        
        var str : String = extractValue(pex, plistKey, pexChildName, pexAttributeKey);
        var value : Float = Std.parseFloat(str) * mult;
        
        // flip gravity for iOS
        if (plistKey == "gravityy")
        {
            value = -value;
        }
        
        // flip angle for iOS
        if (plistKey == "angle")
        {
            value = 360 - value;
        }
        
        // in plist, 'particleLifeSpan' s/b 'particleLifespan'
        if (plistKey == "particleLifeSpan")
        {
            plistKey = "particleLifespan";
        }
        
        //			trace(" --- '" + str + "'" + ($mult != 1 ? " x " + $mult : "") + " => " + value);
        plist.addChild(Xml.parse("<key>" + plistKey + "</key>\n"));
        plist.addChild(Xml.parse("<real>" + value + "</real>\n"));
    }
    
    private static function convertToInteger(plist : Xml, plistKey : String, pex : Access, pexChildName : String = null, pexAttributeKey : String = null, mult : Float = 1) : Void
    //			trace("convertToInteger(" + $plistKey + ", " + $pexAttributeKey + ", " + $pexChildName + ")");
    {
        
        var str : String = extractValue(pex, plistKey, pexChildName, pexAttributeKey);
        var value : Int = Std.int(Std.parseInt(str) * mult);
        
        //			trace(" --- '" + str + "'" + ($mult != 1 ? " x " + $mult : "") + " => " + value);
        plist.addChild(Xml.parse("<key>" + plistKey + "</key>\n"));
        plist.addChild(Xml.parse("<integer>" + value + "</integer>\n"));
    }
    
    private static function convertToString(plist : Xml, plistKey : String, pex : Access, pexChildName : String = null, pexAttributeKey : String = null) : Void
    //			trace("convertToString(" + $plistKey + ", " + $pexAttributeKey + ", " + $pexChildName + ")");
    {
        
        var str : String = extractValue(pex, plistKey, pexChildName, pexAttributeKey);
        
        //			trace(" --- '" + str + "'");
        plist.addChild(Xml.parse("<key>" + plistKey + "</key>\n"));
        plist.addChild(Xml.parse("<string>" + str + "</string>\n"));
    }
}

