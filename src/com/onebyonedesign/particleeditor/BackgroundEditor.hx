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

import flash.display.Sprite;
import flash.events.Event;
import starling.core.Starling;
import starling.display.Stage;
import simplegui.SimpleGUI;

/**
	 * Small panel to modify the color of the particle editor background.
	 * @author Devon O.
	 */
class BackgroundEditor extends Sprite
{
    
    private var mGUI : SimpleGUI;
    
    private var mStage : Stage;
    
    public var r : Float;
    public var g : Float;
    public var b : Float;
    
    
    public function new()
    {
        super();
        mStage = Starling.current.stage;
        
        splitColors(mStage.color);
        
        addEventListener(Event.ADDED_TO_STAGE, init);
        addEventListener(Event.REMOVED_FROM_STAGE, destroy);
    }
    
    private function destroy(event : Event) : Void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
        mGUI = null;
    }
    
    private function init(event : Event) : Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        initUI();
        
        //HACK
        x -= 210;
    }
    
    private function initUI() : Void
    {
        mGUI = new SimpleGUI(this, "Background Editor");
        
        mGUI.addSlider("r", 0, 1.0, {
                    label : "R",
                    callback : onRed
                });
        mGUI.addSlider("g", 0, 1.0, {
                    label : "G",
                    callback : onGreen
                });
        mGUI.addSlider("b", 0, 1.0, {
                    label : "B",
                    callback : onBlue
                });
        
        mGUI.addButton("Done", {
                    callback : onDone
                });
        
        mGUI.show();
    }
    
    private function onRed(o : Dynamic) : Void
    {
        combineColors();
    }
    
    private function onGreen(o : Dynamic) : Void
    {
        combineColors();
    }
    
    private function onBlue(o : Dynamic) : Void
    {
        combineColors();
    }
    
    private function splitColors(color : Int) : Void
    {
        r = color >> 16;
        g = Std.int(color >> 8) & 0xFF;
        b = color & 0xFF;
        
        r /= 0xFF;
        g /= 0xFF;
        b /= 0xFF;
    }
    
    private function combineColors() : Void
    {
        var red : Int = Std.int(r * 0xFF);
        var green : Int = Std.int(g * 0xFF);
        var blue : Int = Std.int(b * 0xFF);
        mStage.color = red << 16 | green << 8 | blue;
    }
    
    private function onDone(o : Dynamic) : Void
    {
        dispatchEvent(new Event(Event.COMPLETE));
    }
}

