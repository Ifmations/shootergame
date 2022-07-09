package;

import Soul;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.BitmapFilter;
import openfl.utils.Assets as OpenFlAssets;

class OptionsState extends FlxState
{
	public static var isMouse:Bool = false;
	public static var isKeys:Bool = true;

	var curSelected:Int = 1;

	private static var creditsStuff:Array<Dynamic> = [['keys'], ['mouse']];

	override public function create()
	{
		super.create();
	}

	var selectedSomethin:Bool = false;

	override public function update(elapsed:Float)
	{
		if (isMouse = true)
		{
			isKeys = false;
		}

		if (isMouse = false)
		{
			isKeys = true;
		}
		super.update(elapsed);
	}

	function save()
	{
		FlxG.save.data.ismouse = isMouse;

		var save:FlxSave = new FlxSave();
		save.bind('controls', 'gamermove'); // Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.flush();
		FlxG.log.add("Settings saved!");
	}

	function loadSettings()
	{
		if (FlxG.save.data.ismouse != null)
		{
			ismouse = FlxG.save.data.ismouse;
		}
	}
}
