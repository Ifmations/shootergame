package;

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

class MenuState extends FlxState
{
	var clouds:FlxBackdrop;
	var cyan:FlxSprite;
	var floor:FlxSprite;
	var building1:FlxSprite;
	var building2:FlxSprite;
	var building3:FlxSprite;

	var gunbase:FlxSprite;
	var gun:FlxSprite;
	var cross:FlxSprite;
	var bullet:FlxSprite;

	var tutorial:FlxSprite;
	var L1:FlxSprite;
	var L2:FlxSprite;
	var L3:FlxSprite;
	var L4:FlxSprite;
	var L5:FlxSprite;

	override public function create()
	{
		FlxG.mouse.visible = true;

		// bg stuff
		cyan = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/cyanBG'));
		cyan.screenCenter();
		add(cyan);

		building3 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings3'));
		building3.screenCenter();
		FlxTween.tween(building3, {y: building3.y - 20}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		add(building3);

		building2 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings2'));
		building2.screenCenter();
		FlxTween.tween(building2, {y: building2.y - 15}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		add(building2);

		building1 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings1'));
		building1.screenCenter();
		FlxTween.tween(building1, {y: building1.y - 10}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		add(building1);

		clouds = new FlxBackdrop(Paths.image('bg/clouds'), 0.2, 0, true, false, 0, 0);
		clouds.scrollFactor.set(0.3, 0);
		clouds.useScaleHack = false;
		clouds.immovable = true;
		clouds.velocity.set(X);
		add(clouds);

		floor = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/floor'));
		floor.screenCenter();
		add(floor);

		// block stuff

		gunbase = new FlxSprite(50, 500).loadGraphic(Paths.image('shootbase'));
		add(gunbase);

		gun = new FlxSprite(gunbase.x - 140, gunbase.y - 100).loadGraphic(Paths.image('gunthing'));
		add(gun);

		tutorial = new FlxSprite(25, 25).loadGraphic(Paths.image('levelselect/tutorial'));
		tutorial.screenCenter(X);
		add(tutorial);

		L1 = new FlxSprite(100, 250).loadGraphic(Paths.image('levelselect/level1'));
		add(L1);

		L2 = new FlxSprite(500, 250).loadGraphic(Paths.image('levelselect/level2'));
		L2.screenCenter(X);
		add(L2);

		L3 = new FlxSprite(900, 250).loadGraphic(Paths.image('levelselect/level3'));
		add(L3);

		L4 = new FlxSprite(300, 500).loadGraphic(Paths.image('levelselect/level4'));
		add(L4);

		L5 = new FlxSprite(700, 500).loadGraphic(Paths.image('levelselect/level5'));
		add(L5);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.overlaps(tutorial) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Tutorial());
		}

		if (FlxG.mouse.overlaps(L1) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Level1());
		}

		if (FlxG.mouse.overlaps(L2) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Level2());
		}

		if (FlxG.mouse.overlaps(L3) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Level3());
		}

		if (FlxG.mouse.overlaps(L4) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Level4());
		}

		if (FlxG.mouse.overlaps(L5) && FlxG.mouse.justPressed)
		{
			FlxG.switchState(new Level5());
		}

		super.update(elapsed);
	}
}
