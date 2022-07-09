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

class PlayState extends FlxState
{
	// menu variables
	var menuthings:Array<String> = ['fight', 'act', 'item', 'spare'];
	var finalthings:Array<String> = ['fight', 'act', 'item', 'spare', 'spells'];
	var curSelected:Int = 0;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var isfinale:Bool = false;
	var menuItem:FlxSprite;

	// boss guy variables
	var boss:FlxSprite;

	// boss battle variables
	var bossHealth:Int = 100;
	var genocidebossHealth:Int = 3642005;
	var bossHealthBar:FlxBar;
	var damage:Int = 10;
	var bossHealthBarBG:FlxSprite;
	var lives:Int = 0;
	var bossBattleLives:Int = 3;
	var playerhealth:Int = 100;
	var isbossbattle:Bool = false;
	var playerhealthBar:FlxBar;

	// attack variables
	var attackKnife:FlxSprite;
	var isAttacking:Bool = false;

	public var enemyAttacking:Bool = true;

	var finalAttack:Bool = false;
	var attackslider:Array<String> = ['miss', 'red', 'orange', 'yellow', 'green', 'perfect'];
	var miss:Bool = false;

	// attacks
	var chain:FlxBackdrop;

	// gamemode variables
	public var isNeutral:Bool = true;
	public var isGenocide:Bool = false;
	public var isPacifist:Bool = false;

	public var camHUD:FlxCamera;
	public var camGame:FlxCamera;
	public var camOther:FlxCamera;

	var txtbox:FlxSprite;
	var text:FlxTypeText;

	var outer:FlxGroup;

	var attacksGroup:FlxGroup;

	override public function create()
	{
		outer = FlxCollision.createCameraWall(FlxG.camera, false, 220);

		bossHealthBarBG = new FlxSprite(0, 50).loadGraphic(Paths.image('healthBar'));
		bossHealthBarBG.screenCenter(X);
		bossHealthBarBG.scale.set(2, 2);
		add(bossHealthBarBG);

		bossHealthBar = new FlxBar(bossHealthBarBG.x + 4, bossHealthBarBG.y + 4, LEFT_TO_RIGHT, Std.int(bossHealthBarBG.width - 8),
			Std.int(bossHealthBarBG.height - 8), this, "bossHealth", 0, 100, true);
		bossHealthBar.scale.set(2, 2);
		bossHealthBar.color = FlxColor.WHITE;
		add(bossHealthBar);

		// ui
		txtbox = new FlxSprite(0, 350).loadGraphic(Paths.image('ui/txtBox'));
		txtbox.screenCenter(X);
		txtbox.scale.set(3, 2.75);
		add(txtbox);

		text = new FlxTypeText(0, 350, FlxG.width - 30, "the battle begins", 16, true);
		text.setFormat(Paths.font("chat text.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		text.prefix = "*";
		text.screenCenter(X);
		text.start(0.02, false, false, null);
		add(text);

		playerhealthBar = new FlxBar(0, 525, LEFT_TO_RIGHT, 150, 10, this, "playerhealth", 0, 100, true);
		playerhealthBar.scale.set(2.5, 2.5);
		playerhealthBar.createFilledBar(0xFFFFEE00, 0xFFFFEE00);
		playerhealthBar.screenCenter(X);
		add(playerhealthBar);

		var nametext:FlxText = new FlxText(12, FlxG.height - 204, 0, "chara", 12);
		nametext.scrollFactor.set();
		nametext.setFormat(Paths.font("chat text.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(nametext);

		var hp:FlxText = new FlxText(playerhealthBar.x - 125, 500, 0, "hp", 12);
		hp.scrollFactor.set();
		hp.setFormat(Paths.font("chat text.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(hp);

		var level:FlxText = new FlxText(200, FlxG.height - 204, 0, "", 12);
		level.scrollFactor.set();
		level.setFormat(Paths.font("chat text.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(level);

		if (isNeutral)
		{
			level.text = "LV 8";
		}

		if (isGenocide)
		{
			level.text = "LV 19";
		}

		if (isPacifist)
		{
			level.text = "LV 1";
		}

		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camOther);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...menuthings.length)
		{
			var offset:Float = 100 - (Math.max(menuthings.length, 8) - 8) * 80;
			menuItem = new FlxSprite(0, (i * 140) + offset);
			menuItem.frames = Paths.getSparrowAtlas('fightmenu/menu_' + menuthings[i]);
			menuItem.animation.addByPrefix('idle', menuthings[i] + " basic", 27);
			menuItem.animation.addByPrefix('selected', menuthings[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItem.scale.set(2, 2);
			menuItems.add(menuItem);
			var scr:Float = (menuthings.length - 4) * 0.135;
			if (menuthings.length < 6)
				scr = 0;
			if (isfinale = true)
				menuthings == finalthings;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override public function update(elapsed:Float)
	{
		if (playerhealth == 0)
		{
			FlxG.switchState(new MainMenuState());
		}

		FlxG.collide(soul, outer); // DONT DELETE HAS BORDER FOR THE BATTLE BOX STUPID DUMB BITCH ALEX DO. NOT. DELETE!

		if (!selectedSomethin)
		{
			if (FlxG.keys.justPressed.A)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (FlxG.keys.justPressed.M)
			{
				FlxG.resetState();
			}

			if (FlxG.keys.justPressed.P)
			{
				chainattack1();
			}

			if (FlxG.keys.justPressed.O)
			{
				funniattack();
			}

			if (FlxG.keys.justPressed.D)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (FlxG.keys.justPressed.ENTER)
			{
				if (menuthings[curSelected] == 'donate')
				{
					trace("no");
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					var daChoice:String = menuthings[curSelected];
					switch (daChoice)
					{
						case 'fight':
							trace("no");
							selectedSomethin = false;
						case 'act':
							trace("no");
							selectedSomethin = false;
						case 'item':
							trace("no");
							selectedSomethin = false;
						case 'spare':
							trace("no");
							selectedSomethin = false;
						case 'spells':
					}
				};
			}
		}
		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(Y);
		});
	}

	function damagetake(soul:FlxObject, chain:FlxObject):Void
	{
		playerhealth -= damage;
		trace(playerhealth);
	}

	function attack()
	{
		isAttacking = true;
	}

	function attack1() {}

	function attack2() {}

	function attack3() {}

	function attack4() {}

	function funniattack()
	{
		var uboa:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('ui/uboa'));
		uboa.scale.set(2, 2);
		add(uboa);
		uboa.angle = FlxAngle.angleBetween(soul, uboa, true);
		FlxTween.tween(uboa, {y: soul.y, x: soul.x}, 0.5, {ease: FlxEase.circOut});
	}

	function chainattack1()
	{
		chain = new FlxBackdrop(Paths.image('chainattack'), 0, 0.2, false, true, 0, 60);
		chain.scrollFactor.set(0.1, -0.1);
		chain.useScaleHack = false;
		chain.immovable = true;
		chain.velocity.set(X, Y);
		chain.angle = FlxAngle.angleBetween(soul, chain);
		add(chain);
	}

	function attackfinale() {}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			spr.offset.x = 0.85 * (spr.frameWidth / 2 + 180);
			spr.offset.y = 0.70 * spr.frameHeight;
			FlxG.log.add(spr.frameWidth);

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
				spr.offset.x = 0.85 * (spr.frameWidth / 2 + 180);
				spr.offset.y = 0.60 * spr.frameHeight;
				FlxG.log.add(spr.frameWidth);
			}
		});
	}
}
