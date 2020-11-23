/**
 *	Copyright (c) 2013 Devon O. Wolfgang, 2020 Ludovic Bas (html5 port)
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


import com.onebyonedesign.particleeditor.ParticleEditor;
import com.onebyonedesign.particleeditor.ParticleView;
import com.onebyonedesign.particleeditor.SettingsModel;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.geom.Rectangle;
import starling.core.Starling;
import openfl.Assets;
import haxe.xml.Access;

/**
	 * Entry point of particle editor
	 * @author Devon O.
	 */
class Main extends Sprite
{

    var DEFAULT_CONFIG = "assets/fire.pex";
    
    /** Starling instance */
    var mStarling : Starling;
    
    /** Starling view port */
    var mViewPort : Rectangle = new Rectangle(0, 0, 400, 500);
    
    public function new()
    {
        super();
				
        if (stage != null)
        {
            init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }
    
    private function init(event : Event = null) : Void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);
        
        initStage();
        initParticleDisplay();
    }
    
    private function initStage() : Void
    {
        stage.showDefaultContextMenu = false;
    }
    
    private function initParticleDisplay() : Void
    {
        mStarling = new Starling(ParticleView, stage, mViewPort);
        mStarling.addEventListener("rootCreated", onStarlingRoot);
        mStarling.antiAliasing = 4;
        mStarling.stage.color = 0x000000;
        mStarling.enableErrorChecking = false;
        mStarling.start();
    }
    
    private function onStarlingRoot(event : Dynamic) : Void
    {
        mStarling.removeEventListener("rootCreated", onStarlingRoot);
        
        var settings : SettingsModel = new SettingsModel();
        settings.x = mViewPort.width;
        addChild(settings);
        
        var initialConfig  = new Access(Xml.parse(Assets.getText(DEFAULT_CONFIG)).firstElement());
        
        var editor : ParticleEditor = new ParticleEditor(settings, initialConfig, cast mStarling.root);
    }
}

