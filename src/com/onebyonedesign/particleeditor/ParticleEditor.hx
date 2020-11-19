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

    import minimalcomps.components.ComboBox; 
    import minimalcomps.components.Component;
    import minimalcomps.components.Label;
    import minimalcomps.components.Window;
    import com.ww.PEXtoPlist;
	import haxe.xml.Access;
    import openfl.events.Event;
	import openfl.events.Event;
    import openfl.net.FileFilter;
    import openfl.net.FileReference;
    import openfl.utils.ByteArray;
    //import uk.co.soulwire.gui.SimpleGUI;
	import SimpleGUI;

	typedef  BlendArray = 	{label:String, data:Int };
	
	/**
	 * Save, load, and modify particle properties
	 * @author Devon O.
	 */
	class ParticleEditor
	{
		/** file reference to download particle */
		private var downloader:FileReference = new FileReference();
		
		/** UI */
		private var mGUI:SimpleGUI;
        
        /** Particle Configuration */
        private var mParticleConfig:ParticleConfiguration;
        
        /** Settings */
        private var mSettings:SettingsModel;
        
        /** Particle View */
        private var mParticleView:ParticleView;
        
        /** texture editor */
		private var mTexEditor:TextureEditor;
		
		/** background editor */
		private var mBGEditor:BackgroundEditor;
		
        /** Blend Mode values */
		private var mBlendArray:Array<BlendArray> = 
		[
			{label:"Zero", data:0x00 },
			{label:"One", data:0x01 },
			{label:"Src", data:0x300 },
			{label:"One - Src", data:0x301 },
			{label:"Src Alpha", data:0x302 },
			{label:"One - Src Alpha", data:0x303 },
			{label:"Dst Alpha", data:0x304 },
			{label:"One - Dst Alpha", data:0x305 },
			{label:"Dst Color", data:0x306 },
			{label:"One - Dst Color", data:0x307}
		];
        
        /**
         * Create a new Particle Editor
         * @param settings
         * @param initialConfig
         * @param particleView
         */
		public function new(settings:SettingsModel, initialConfig:Access, particleView:ParticleView) 
		{
            mSettings = settings;
            mParticleConfig = new ParticleConfiguration(initialConfig);
            mSettings.addListener(mParticleConfig);
            mParticleView = particleView;
            mParticleView.particleConfig = mParticleConfig;
            mParticleView.settings = mSettings;
            
            initUI();
		}
		
		/** Create the SimpleGUI instance */
		private function initUI():Void 
		{
			mGUI = new SimpleGUI(mSettings, "General");
			
			mGUI.addGroup("Save");
			mGUI.addButton("Export Particle", { name:"savePartBtn", callback:saveParticle } );
			mGUI.addToggle("savePlist", { label:"Include .PLIST file", name:"savePlist" } );
			mGUI.addGroup("Load");
			mGUI.addButton("Load Particle", { name:"loadButton", callback:onLoad } );
			mGUI.addGroup("Edit");
			mGUI.addButton("Edit Texture", { name:"editTexBtn", callback:editTexture } );
			mGUI.addButton("Edit Background", { name:"editBGBtn", callback:editBackground } );
            mGUI.addGroup("Random Settings");
            mGUI.addButton("Randomize!", { name:"randomSettings", callback:randomizeSettings } );
			
			mGUI.addColumn("Particles");
			mGUI.addGroup("Emitter Type");
			mGUI.addComboBox("emitterType", [ { label:"Gravity", data:0 }, { label:"Radial", data:1 } ], { name:"emitterType" } );
			
			mGUI.addGroup("Particle Configuration");
			mGUI.addSlider("maxParts", 1.0, 1000.0, { label:"Max Particles", name:"maxParts" } );
			mGUI.addSlider("lifeSpan", 0, 10.0, { label:"Lifespan", name:"lifeSpan" } );
			mGUI.addSlider("lifeSpanVar", 0, 10.0, { label:"Lifespan Variance", name:"lifeSpanVar" } );
			mGUI.addSlider("startSize", 0, 70.0, { label:"Start Size", name:"startSize" } );
			mGUI.addSlider("startSizeVar", 0, 70.0, { label:"Start Size Variance", name:"startSizeVar" } );
			mGUI.addSlider("finishSize", 0, 70.0, { label:"Finish Size", name:"finishSize" } );
			mGUI.addSlider("finishSizeVar", 0, 70.0, { label:"Finish Size Variance", name:"finishSizeVar" } );
			mGUI.addSlider("emitAngle", 0, 360.0, { label:"Emitter Angle", name:"emitAngle" } );
			mGUI.addSlider("emitAngleVar", 0, 360.0, { label:"Angle Variance", name:"emitAngleVar" } );
			mGUI.addSlider("stRot", 0, 360.0, { label:"Start Rot.", name:"stRot" } );
			mGUI.addSlider("stRotVar", 0, 360.0, { label:"Start Rot. Var.", name:"stRotVar" } );
			mGUI.addSlider("endRot", 0, 360.0, { label:"End Rot.", name:"endRot" } );
			mGUI.addSlider("endRotVar", 0, 360.0, { label:"End Rot. Var.", name:"endRotVar" } );
			
			mGUI.addColumn("Particle Behavior");
			mGUI.addGroup("Gravity (gravity emitter)");
			mGUI.addSlider("xPosVar", 0.0, 1000.0, { label:"X Variance", name:"xPosVar" } );
			mGUI.addSlider("yPosVar", 0.0, 1000.0, { label:"Y Variance", name:"yPosVar" } );
			mGUI.addSlider("speed", 0, 500.0, { label:"Speed", name:"speed" } );
			mGUI.addSlider("speedVar", 0, 500.0, { label:"Speed Variance", name:"speedVar" } );
			mGUI.addSlider("gravX", -500, 500.0, { label:"Gravity X", name:"gravX" } );
			mGUI.addSlider("gravY", -500, 500.0, { label:"Gravity Y", name:"gravY" } );
			mGUI.addSlider("tanAcc", -500, 500, { label:"Tan. Acc.", name:"tanAcc" } );
			mGUI.addSlider("tanAccVar", 0.0, 500, { label:"Tan. Acc. Var", name:"tanAccVar" } );
			mGUI.addSlider("radialAcc", -500.00, 500.0, { label:"Rad. Acc.", name:"radialAcc" } );
			mGUI.addSlider("radialAccVar", 0, 500.0, { label:"Rad. Acc. Var.", name:"radialAccVar" } );
			
			mGUI.addGroup("Rotation (radial emitter)");
			mGUI.addSlider("maxRadius", 0, 500.0, { label:"Max Radius", name:"maxRadius" } );
			mGUI.addSlider("maxRadiusVar", 0, 500.0, { label:"Max Rad Variance", name:"maxRadiusVar" } );
			mGUI.addSlider("minRadius", 0, 500.0, { label:"Min Radius", name:"minRadius" } );
            mGUI.addSlider("minRadiusVar", 0, 500.0, { label:"Min Rad Variance", name:"minRadiusVar" } );
			mGUI.addSlider("degPerSec", -360.0, 360.0, { label:"Deg/Sec", name:"degPerSec" } );
			mGUI.addSlider("degPerSecVar", 0.0, 360.0, { label:"Deg/Sec Var.", name:"degPerSecVar" } );
			
			mGUI.addColumn("Particle Color");
			mGUI.addGroup("Start");
			mGUI.addSlider("sr", 0, 1.0, { label:"R", name:"sr" } );
			mGUI.addSlider("sg", 0, 1.0, { label:"G", name:"sg" } );
			mGUI.addSlider("sb", 0, 1.0, { label:"B", name:"sb" } );
			mGUI.addSlider("sa", 0, 1.0, { label:"A", name:"sa" } );
			
			mGUI.addGroup("Finish");
			mGUI.addSlider("fr", 0, 1.0, { label:"R", name:"fr" } );
			mGUI.addSlider("fg", 0, 1.0, { label:"G", name:"fg" } );
			mGUI.addSlider("fb", 0, 1.0, { label:"B", name:"fb" } );
			mGUI.addSlider("fa", 0, 1.0, { label:"A", name:"fa" } );
			
			mGUI.addColumn("Particle Color Variance");
			mGUI.addGroup("Start");
			mGUI.addSlider("svr", 0, 1.0, { label:"R", name:"svr" } );
			mGUI.addSlider("svg", 0, 1.0, { label:"G", name:"svg" } );
			mGUI.addSlider("svb", 0, 1.0, { label:"B", name:"svb" } );
			mGUI.addSlider("sva", 0, 1.0, { label:"A", name:"sva" } );
			
			mGUI.addGroup("Finish");
			mGUI.addSlider("fvr", 0, 1.0, { label:"R", name:"fvr" } );
			mGUI.addSlider("fvg", 0, 1.0, { label:"G", name:"fvg" } );
			mGUI.addSlider("fvb", 0, 1.0, { label:"B", name:"fvb" } );
			mGUI.addSlider("fva", 0, 1.0, { label:"A", name:"fva" } );
			
			mGUI.addGroup("Blend Function");
			mGUI.addComboBox("srcBlend", mBlendArray, {  label:"Source", name:"srcBlend" } );
			mGUI.addComboBox("dstBlend", mBlendArray, { label:"Dest.  ", name:"dstBlend" } );
			
			mGUI.show();
		}
        
        //
        // Load a .pex file
        //
		
		/** Browse for particle files to load */
		private function onLoad(o:Event):Void
		{
			downloader.addEventListener(Event.SELECT, onLoadSelect);
			downloader.browse([new FileFilter("Particle Files (*.pex)", "*.pex")]);
		}
		
		/** After selecting particle file to load */
		private function onLoadSelect(event:Event):Void
		{
			downloader.removeEventListener(Event.SELECT, onLoadSelect);
			downloader.addEventListener(Event.COMPLETE, onLoadComplete);
			downloader.load();
		}
		
		/** After particle file has been loaded */
		private function onLoadComplete(event:Event):Void 
		{
			downloader.removeEventListener(Event.COMPLETE, onLoadComplete);
            
			var xml:Xml = null;
			try
			{
				xml = Xml.parse(cast downloader.data);
			}
			catch (err) 
			{
				trace(err);
			}
			if (xml != null) 
			{
				buildParticleFromXML(new Access(xml.firstChild()));
			}
			else 
			{
				showError("Particle file appears to be malformed");
			}
		}
        
        //
        // Error display 
        //
        
        /** Display an Error Window */
        private function showError(label:String):Void
        {
            var errWindow:Window = new Window(mSettings, -300, 100, "ERROR!");
            errWindow.setSize(200, 100);
            errWindow.hasCloseButton = true;
            errWindow.addEventListener(Event.CLOSE, onErrClose);
            var lab:Label = new Label(errWindow.content, 5, 5, label);
        }
		
		/** remove error display window */
		private function onErrClose(event:Event):Void 
		{
			var win:Window = cast event.currentTarget;
			win.parent.removeChild(win);
		}
        
        // 
        // Save zipped particle (.pex and .png)
        //
        
		/** Save particle texture image source and config file and optional .plist config to .zip */
		private function saveParticle(o:Dynamic):Void
		{
			/*var zip:ZipOutput = new ZipOutput();
			var filename:String;
			var filedata:ByteArray;
			var entry:ZipEntry;
            var xml:XML = mParticleConfig.xml;
			
			// add pex to zip
			filename = "particle.pex";
			filedata = new ByteArray();
			filedata.writeUTFBytes(xml.toXMLString());
			filedata.position = 0;
			
			entry = new ZipEntry(filename);
			zip.putNextEntry(entry);
			zip.write(filedata);
			zip.closeEntry();
			
			// texture to zip
			filename = "texture.png";
			filedata = PNGEncoder.encode(mParticleView.particleData);
			filedata.position = 0;
			
			entry = new ZipEntry(filename);
			zip.putNextEntry(entry);
			zip.write(filedata);
			zip.closeEntry();
			
			if (mSettings.savePlist)
			{
				filename = "particle.plist";
				var plist:String = PEXtoPlist.createPlist(xml.toXMLString());
				filedata = new ByteArray();
				filedata.writeUTFBytes(plist);
				filedata.position = 0;
				
				entry = new ZipEntry(filename);
				zip.putNextEntry(entry);
				zip.write(filedata);
				zip.closeEntry();
			}
			
			// finish the zip
			zip.finish();
			*/
			//downloader.save(zip.byteArray, "particle.zip");
		}
        
        //
        // Edit Texture
        //
		
		/** open the texture editor panel */
		private function editTexture(o:Dynamic):Void 
		{
			if (mBGEditor != null) 
                onDoneBGEditing(null);
			mTexEditor = new TextureEditor(mParticleView.particleData);
            
            // Hack to get window below Particle display
            // tex editor x pos set by the editor in init method
			mTexEditor.y = 510;
            
			mTexEditor.addEventListener(Event.COMPLETE, onDoneEditing);
			mSettings.addChild(mTexEditor);
		}
		
		/** after closing texture editor panel */
		private function onDoneEditing(event:Event):Void
		{
			mTexEditor.removeEventListener(Event.COMPLETE, onDoneEditing);
            mParticleView.particleData = mTexEditor.mData;
			mSettings.removeChild(mTexEditor);
			mTexEditor = null;
		}
        
        // 
        // Edit Background color 
        //
		
		/** open background editor panel */
		private function editBackground(o:Dynamic):Void 
		{
			if (mTexEditor != null) 
                onDoneEditing(null);
			mBGEditor = new BackgroundEditor();
            
            // Hack to get window below Particle display
            // bg editor x pos set by the editor in init method
			mBGEditor.y = 510;
            
			mBGEditor.addEventListener(Event.COMPLETE, onDoneBGEditing);
			mSettings.addChild(mBGEditor);
		}
        
        /** after closing background editor panel */
		private function onDoneBGEditing(event:Event):Void 
		{
			mBGEditor.removeEventListener(Event.COMPLETE, onDoneBGEditing);
			mSettings.removeChild(mBGEditor);
			mBGEditor = null;
		}
        
        /** Randomize particle settings */
        private function randomizeSettings(o:Dynamic):Void
        {
            mParticleConfig.randomize();
            
            buildParticleFromXML(mParticleConfig.xml);
        }
        
		/** Set all gui and particle settings from loaded .pex file */
		private function buildParticleFromXML(fast:Access):Void 
		{
			var i = mGUI.components.length;
			
			while (i-- >= 0) 
			{
				var comp:Component = mGUI.components[i];
				var val:Float;
				var idx:Int = 0;
                
                switch(comp.name)
                {
                    case "emitterType" :
                        val = Std.parseFloat(fast.node.emitterType.att.value);
                        switch(val) 
                        {
                            case 0:
                                idx = 0;
                            case 1 :
                                idx = 1;
                            default :
                                idx = 0;
                        }
                        
                        mSettings.emitterType = idx;
                        cast(comp, ComboBox).selectedIndex = idx;
                        
                    case "maxParts" :
                        val = Std.parseFloat(fast.node.maxParticles.att.value);
                        mSettings.maxParts = val;
                        
                    case "lifeSpan" :
                        val = Std.parseFloat(fast.node.particleLifeSpan.att.value);
                        mSettings.lifeSpan = val;
                        
                    case "lifeSpanVar" :
                        val = Std.parseFloat(fast.node.particleLifespanVariance.att.value);
                        mSettings.lifeSpanVar = val;
                        
                    case "startSize" :
                        val = Std.parseFloat(fast.node.startParticleSize.att.value);
                        mSettings.startSize = val;
                        
                    case "startSizeVar" :
                        val = Std.parseFloat(fast.node.startParticleSizeVariance.att.value);
                        mSettings.startSizeVar = val;
                        
                    case "finishSize" :
                        val = Std.parseFloat(fast.node.finishParticleSize.att.value);
                        mSettings.finishSize = val;
                        
                    case "finishSizeVar" :
                        val = Std.parseFloat(fast.node.FinishParticleSizeVariance.att.value);
                        mSettings.finishSizeVar = val;
                        
                    case "emitAngle" :
                        val = Std.parseFloat(fast.node.angle.att.value);
                        mSettings.emitAngle = val;
                        
                    case "emitAngleVar" :      
                        val = Std.parseFloat(fast.node.angleVariance.att.value);
                        mSettings.emitAngleVar = val;
                        
                    case "stRot" :
                        val = Std.parseFloat(fast.node.rotationStart.att.value);
                        mSettings.stRot = val;
                        
                    case "stRotVar" :
                        val = Std.parseFloat(fast.node.rotationStartVariance.att.value);
                        mSettings.stRotVar = val;
                        
                    case "endRot" :
                        val = Std.parseFloat(fast.node.rotationEnd.att.value);
                        mSettings.endRot = val;
                        
                    case "endRotVar" :
                        val = Std.parseFloat(fast.node.rotationEndVariance.att.value);
                        mSettings.endRotVar = val;
                        
                    case "xPosVar" :
                        val = Std.parseFloat(fast.node.sourcePositionVariance.att.x);
                        mSettings.xPosVar = val;
                        
                    case "yPosVar" :
                        val = Std.parseFloat(fast.node.sourcePositionVariance.att.y);
                        mSettings.yPosVar = val;
                        
                    case "speed" :
                        val = Std.parseFloat(fast.node.speed.att.value);
                        mSettings.speed = val;
                        
                    case "speedVar" :
                        val = Std.parseFloat(fast.node.speedVariance.att.value);
                        mSettings.speedVar = val;
                        
                    case "gravX" :
                        val = Std.parseFloat(fast.node.gravity.att.x);
                        mSettings.gravX = val;
                        
                    case "gravY" :
                        val = Std.parseFloat(fast.node.gravity.att.y);
                        mSettings.gravY = val;
                        
                    case "tanAcc" :
                        val = Std.parseFloat(fast.node.tangentialAcceleration.att.value);
                        mSettings.tanAcc = val;
                        
                    case "tanAccVar" :
                        val = Std.parseFloat(fast.node.tangentialAccelVariance.att.value);
                        mSettings.tanAccVar = val;
                        
                    case "radialAcc" :
                        val = Std.parseFloat(fast.node.radialAcceleration.att.value);
                        mSettings.radialAcc = val;
                        
                    case "radialAccVar" :
                        val = Std.parseFloat(fast.node.radialAccelVariance.att.value);
                        mSettings.radialAccVar = val;
                        
                    case "maxRadius" :
                        val = Std.parseFloat(fast.node.maxRadius.att.value);
                        mSettings.maxRadius = val;
                        
                    case "maxRadiusVar" :
                        val = Std.parseFloat(fast.node.maxRadiusVariance.att.value);
                        mSettings.maxRadiusVar = val;
                        
                    case "minRadius" :
                        val = Std.parseFloat(fast.node.minRadius.att.value);
                        mSettings.minRadius = val;
                        
                    case "minRadiusVar" :
                        val = Std.parseFloat(fast.node.minRadiusVariance.att.value);
                        mSettings.minRadiusVar = val;
                        
                    case "degPerSec" :
                        val = Std.parseFloat(fast.node.rotatePerSecond.att.value);
                        mSettings.degPerSec = val;
                        
                    case "degPerSecVar" :
                        val = Std.parseFloat(fast.node.rotatePerSecondVariance.att.value);
                        mSettings.degPerSecVar = val;
                        
                    case "sr" :
                        val = Std.parseFloat(fast.node.startColor.att.red);
                        mSettings.sr = val;
                        
                    case "sg" :
                        val = Std.parseFloat(fast.node.startColor.att.green);
                        mSettings.sg = val;
                        
                    case "sb" :
                        val = Std.parseFloat(fast.node.startColor.att.blue);
                        mSettings.sb = val;
                        
                    case "sa" :
                        val = Std.parseFloat(fast.node.startColor.att.alpha);
                        mSettings.sa = val;
                        
                    case "fr" :
                        val = Std.parseFloat(fast.node.finishColor.att.red);
                        mSettings.fr = val;
                        
                    case "fg" :
                        val = Std.parseFloat(fast.node.finishColor.att.green);
                        mSettings.fg = val;
                        
                    case "fb" :
                        val = Std.parseFloat(fast.node.finishColor.att.blue);
                        mSettings.fb = val;
                        
                    case "fa" :
                        val = Std.parseFloat(fast.node.finishColor.att.alpha);
                        mSettings.fa = val;
                        
                    case "svr" :
                        val = Std.parseFloat(fast.node.startColorVariance.att.red);
                        mSettings.svr = val;
                        
                    case "svg" :
                        val = Std.parseFloat(fast.node.startColorVariance.att.green);
                        mSettings.svg = val;
                        
                    case "svb" :
                        val = Std.parseFloat(fast.node.startColorVariance.att.blue);
                        mSettings.svb = val;
                        
                    case "sva" :
                        val = Std.parseFloat(fast.node.startColorVariance.att.alpha);
                        mSettings.sva = val;
                        
                    case "fvr" :
                        val = Std.parseFloat(fast.node.finishColorVariance.att.red);
                        mSettings.fvr = val;
                        
                    case "fvg" :
                        val = Std.parseFloat(fast.node.finishColorVariance.att.green);
                        mSettings.fvg = val;
                        
                    case "fvb" :
                        val = Std.parseFloat(fast.node.finishColorVariance.att.blue);
                        mSettings.fvb = val;
                        
                    case "fva" :
                        val = Std.parseFloat(fast.node.finishColorVariance.att.alpha);
                        mSettings.fva = val;
                        
                    case "srcBlend" :
                        val = Std.parseFloat(fast.node.blendFuncSource.att.value);
                        switch(val) 
                        {
                            case 0x00 :
                                idx = 0;
                            case 0x01 :
                                idx = 1;
                            case 0x300 :
                                idx = 2;
                            case 0x301 :
                                idx = 3;
                            case 0x302 :
                                idx = 4;
                            case 0x303 :
                                idx = 5;
                            case 0x304 :
                                idx = 6;
                            case 0x305 :
                                idx = 7;
                            case 0x306 :
                                idx = 8;
                            case 0x307 :
                                idx = 9;
                        }
                        mSettings.srcBlend = Std.int(val);
                        cast(comp, ComboBox).selectedIndex = idx;
                        
                    case "dstBlend" :
                        val = Std.parseFloat(fast.node.blendFuncDestination.att.value);
                        switch(val) 
                        {
                            case 0x00 :
                                idx = 0;
                            case 0x01 :
                                idx = 1;
                            case 0x300 :
                                idx = 2;
                            case 0x301 :
                                idx = 3;
                            case 0x302 :
                                idx = 4;
                            case 0x303 :
                                idx = 5;
                            case 0x304 :
                                idx = 6;
                            case 0x305 :
                                idx = 7;
                            case 0x306 :
                                idx = 8;
                            case 0x307 :
                                idx = 9;
                            default :
                                idx = 1;
                        }
                        mSettings.dstBlend = Std.int(val);
                        cast(comp, ComboBox).selectedIndex = idx;
                        
                    default :
                        trace("Couldn't update setting for comp named: '" + comp.name + "'");
				}
			}
			fast = null;
		}
	}
