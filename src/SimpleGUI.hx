package;
import minimalcomps.components.Component;
import openfl.display.DisplayObjectContainer;
/**
 * ...
 * @author Ludovic Bas - www.lugludum.com
 */
class SimpleGUI extends simplegui.SimpleGUI
{
	public var components(get, set):Array<Component>;
	
	public function get_components():Array<Component>
	{
		return _components;
	}
	public function set_components(comp:Array<Component>):Array<Component>
	{
		_components = comp;
		return _components;
	}

	public function new(target:DisplayObjectContainer, title:String = null, hotKey:Dynamic = null)
	{
		super(target, title, hotKey);
	}
	
}