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

class TitleState extends FlxState
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

	var G:FlxText;
	var A:FlxText;
	var M:FlxText;
	var E:FlxText;
	var start:FlxText;

	override public function create()
	{
		FlxG.mouse.visible = false;

		new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			gamestart();
		});

		// bg stuff
		cyan = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/cyanBG'));
		cyan.screenCenter();
		cyan.visible = false;
		add(cyan);

		building3 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings3'));
		building3.screenCenter();
		FlxTween.tween(building3, {y: building3.y - 20}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		building3.visible = false;
		add(building3);

		building2 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings2'));
		building2.screenCenter();
		FlxTween.tween(building2, {y: building2.y - 15}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		building2.visible = false;
		add(building2);

		building1 = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/buildings1'));
		building1.screenCenter();
		FlxTween.tween(building1, {y: building1.y - 10}, 0.5, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		building1.visible = false;
		add(building1);

		clouds = new FlxBackdrop(Paths.image('bg/clouds'), 0.2, 0, true, false, 0, 0);
		clouds.scrollFactor.set(0.3, 0);
		clouds.useScaleHack = false;
		clouds.immovable = true;
		clouds.velocity.set(X);
		clouds.visible = false;
		add(clouds);

		floor = new FlxSprite(0, 50).loadGraphic(Paths.image('bg/floor'));
		floor.screenCenter();
		floor.visible = false;
		add(floor);

		// block stuff

		gunbase = new FlxSprite(50, 500).loadGraphic(Paths.image('shootbase'));
		gunbase.visible = false;
		add(gunbase);

		gun = new FlxSprite(gunbase.x - 140, gunbase.y - 100).loadGraphic(Paths.image('gunthing'));
		gun.visible = false;
		add(gun);

		start = new FlxText(12, 600, 0, "Press Enter To Start", 12);
		start.scrollFactor.set();
		start.setFormat(Paths.font("chat text.ttf"), 24, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		start.screenCenter(X);
		start.visible = false;
		add(start);

		G = new FlxText(350, 50, 0, "G", 12);
		G.scrollFactor.set();
		G.setFormat(Paths.font("chat text.ttf"), 150, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		G.visible = false;
		add(G);

		A = new FlxText(500, 50, 0, "A", 12);
		A.scrollFactor.set();
		A.setFormat(Paths.font("chat text.ttf"), 150, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		A.visible = false;
		add(A);

		M = new FlxText(650, 50, 0, "M", 12);
		M.scrollFactor.set();
		M.setFormat(Paths.font("chat text.ttf"), 150, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		M.visible = false;
		add(M);

		E = new FlxText(800, 50, 0, "E", 12);
		E.scrollFactor.set();
		E.setFormat(Paths.font("chat text.ttf"), 150, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		E.visible = false;
		add(E);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			if (FlxG.sound.music == null)
			{
				FlxG.sound.playMusic(Paths.music('GameMusic'), 1, true);
			}
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}

	function gamestart()
	{
		G.visible = true;
		FlxG.sound.play(Paths.sound('startSound'));
		new FlxTimer().start(0.5, function(tmr:FlxTimer)
		{
			A.visible = true;
			FlxG.sound.play(Paths.sound('startSound'));
			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				M.visible = true;
				FlxG.sound.play(Paths.sound('startSound'));
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					E.visible = true;
					FlxG.sound.play(Paths.sound('startSound'));
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						FlxG.sound.playMusic(Paths.music('GameMusic'), 1, true);
						gunbase.visible = true;
						gun.visible = true;
						start.visible = true;
						floor.visible = true;
						building1.visible = true;
						building2.visible = true;
						building3.visible = true;
						clouds.visible = true;
						cyan.visible = true;
						FlxG.sound.play(Paths.sound('startSoundfinal'));
					});
				});
			});
		});
	}
}
