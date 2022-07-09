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
import flixel.math.FlxVelocity;
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

class Level4 extends FlxState
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

	var block:FlxSprite;
	var block2:FlxSprite;
	var block3:FlxSprite;
	var block4:FlxSprite;
	var block5:FlxSprite;
	var bounceblock:FlxSprite;
	var endblock:FlxSprite;
	var moveblock:FlxSprite;
	var fakemoveblock:FlxSprite;
	var fakemoveblock2:FlxSprite;
	var fakemoveblock3:FlxSprite;
	var fakemoveblock4:FlxSprite;
	var fakemoveblock5:FlxSprite;
	var coinmoveblock:FlxSprite;
	var coinblock:FlxSprite;

	var outer:FlxGroup;

	var bullets:Int = 2;
	var grpBullets:FlxTypedGroup<FlxSprite>;

	var canClick:Bool = true; // outside of functions
	var coolbool:Bool = true;

	var lives:FlxText;
	var blockOrder:FlxText;

	override public function create()
	{
		if (FlxG.mouse.visible = true)
		{
			FlxG.mouse.visible = false;
		}

		outer = FlxCollision.createCameraWall(FlxG.camera, true, 20);

		FlxG.mouse.visible = false;

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
		endblock = new FlxSprite(600, 850).loadGraphic(Paths.image('blocks/levelend'));
		endblock.immovable = true;
		add(endblock);

		moveblock = new FlxSprite(900, 350).loadGraphic(Paths.image('blocks/move'));
		moveblock.immovable = true;
		add(moveblock);

		fakemoveblock = new FlxSprite(900, 50).loadGraphic(Paths.image('blocks/move'));
		add(fakemoveblock);

		fakemoveblock3 = new FlxSprite(900, 175).loadGraphic(Paths.image('blocks/move'));
		add(fakemoveblock3);

		fakemoveblock2 = new FlxSprite(900, 550).loadGraphic(Paths.image('blocks/move'));
		add(fakemoveblock2);

		fakemoveblock4 = new FlxSprite(900, 425).loadGraphic(Paths.image('blocks/move'));
		add(fakemoveblock4);

		fakemoveblock5 = new FlxSprite(900, 300).loadGraphic(Paths.image('blocks/move'));
		add(fakemoveblock5);

		coinmoveblock = new FlxSprite(900, 300).loadGraphic(Paths.image('blocks/move'));
		coinmoveblock.immovable = true;
		add(coinmoveblock);

		coinblock = new FlxSprite(600, -500).loadGraphic(Paths.image('blocks/secret/coin'));
		coinblock.immovable = true;
		add(coinblock);

		// gun stuff
		gunbase = new FlxSprite(50, 500).loadGraphic(Paths.image('shootbase'));
		add(gunbase);

		bullet = new FlxSprite(50, 500).loadGraphic(Paths.image('bullet'));
		bullet.elasticity = 1;

		gun = new FlxSprite(gunbase.x - 140, gunbase.y - 100).loadGraphic(Paths.image('gunthing'));
		add(gun);

		cross = new FlxSprite(0, 0).loadGraphic(Paths.image('crosshair'));
		add(cross);

		lives = new FlxText(0, 0, 0, "" + bullets, 12);
		lives.setFormat(Paths.font("chat text.ttf"), 20, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(lives);

		var blockrandom:Int = FlxG.random.int(0, 19);
		trace(blockrandom);
		switch (blockrandom)
		{
			case 0: // first
				coinmoveblock.y = 50;
				moveblock.y = 175;
			case 1:
				coinmoveblock.y = 50;
				moveblock.y = 300;
			case 2:
				coinmoveblock.y = 50;
				moveblock.y = 425;
			case 3:
				coinmoveblock.y = 50;
				moveblock.y = 550;
			case 4: // second
				coinmoveblock.y = 175;
				moveblock.y = 50;
			case 5:
				coinmoveblock.y = 175;
				moveblock.y = 300;
			case 6:
				coinmoveblock.y = 175;
				moveblock.y = 425;
			case 7:
				coinmoveblock.y = 175;
				moveblock.y = 550;
			case 8: // third
				coinmoveblock.y = 300;
				moveblock.y = 50;
			case 9:
				coinmoveblock.y = 300;
				moveblock.y = 175;
			case 10:
				coinmoveblock.y = 300;
				moveblock.y = 425;
			case 11:
				coinmoveblock.y = 300;
				moveblock.y = 550;
			case 12: // fourth
				coinmoveblock.y = 425;
				moveblock.y = 50;
			case 13:
				coinmoveblock.y = 425;
				moveblock.y = 175;
			case 14:
				coinmoveblock.y = 425;
				moveblock.y = 300;
			case 15:
				coinmoveblock.y = 425;
				moveblock.y = 550;
			case 16: // fifth
				coinmoveblock.y = 550;
				moveblock.y = 50;
			case 17:
				coinmoveblock.y = 550;
				moveblock.y = 175;
			case 18:
				coinmoveblock.y = 550;
				moveblock.y = 300;
			case 19:
				coinmoveblock.y = 550;
				moveblock.y = 425;
		}

		blockOrder = new FlxText(0, 680, 0, "block order:" + blockrandom, 12);
		blockOrder.setFormat(Paths.font("chat text.ttf"), 12, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		#if web
		add(blockOrder);
		#else
		blockOrder.text = "block order avaliable on html5 build only";
		add(blockOrder);
		#end
		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(bullet, outer, bulletdeath); // DONT DELETE HAS BORDER FOR THE BATTLE BOX STUPID DUMB BITCH ALEX DO. NOT. DELETE!
		FlxG.collide(bullet, block, bulletdeath);
		FlxG.collide(bullet, block2, bulletdeath);
		FlxG.collide(bullet, block3, bulletdeath);
		FlxG.collide(bullet, block4, bulletdeath);
		FlxG.collide(bullet, block5, bulletdeath);
		FlxG.collide(bullet, bounceblock, ping);
		FlxG.collide(bullet, endblock, end);
		FlxG.collide(bullet, moveblock, move);
		FlxG.collide(bullet, coinmoveblock, move2);
		FlxG.collide(bullet, coinblock, coincollect);

		cross.x = FlxG.mouse.x;
		cross.y = FlxG.mouse.y;
		gun.angle = FlxAngle.angleBetween(gun, cross, true);

		insideUpdate();

		if (gun.angle < -28)
		{
			gun.angle = -28;
		}

		if (gun.angle > 28)
		{
			gun.angle = 28;
		}

		lives.text = "" + bullets;

		if (bullets == 0)
		{
			lost();
		}

		super.update(elapsed);
	}

	function fire() // CODE: NOT WORKY VERY WELL.
	{
		coolbool = false;
		add(bullet);
		bullet.angle = gun.angle;
		// FlxAngle.asRadians(bullet.angle);
		// FlxVelocity.accelerateFromAngle(bullet, bullet.angle, 500, 500, false);
		var vel = FlxVelocity.velocityFromAngle(bullet.angle, 600);
		bullet.velocity.set(vel.x, vel.y);
	}

	function bulletdeath(soul:FlxObject, chain:FlxObject):Void
	{
		bullets--;
		coolbool = true;
		remove(bullet);
		bullet.x = 50;
		bullet.y = 500;
	}

	function ping(Bat:FlxObject, Ball:FlxObject):Void
	{
		var batmid:Int = Std.int(bounceblock.x) + 20;
		var ballmid:Int = Std.int(bullet.x) + 3;
		var diff:Int;

		bullet.angle = bullet.angle - 90;
		if (ballmid < batmid)
		{
			// Ball is on the left of the bat
			diff = batmid - ballmid;
			bullet.velocity.x = (-10 * diff);
		}
		else if (ballmid > batmid)
		{
			// Ball on the right of the bat
			diff = ballmid - batmid;
			bullet.velocity.x = (10 * diff);
		}
		else
		{
			// Ball is perfectly in the middle
			// A little random X to stop it bouncing up!
			bullet.velocity.x = 2 + FlxG.random.int(0, 8);
		}
	}

	function end(Bat:FlxObject, Ball:FlxObject):Void
	{
		remove(bullet);
		openSubState(new WinSubState());
	}

	function lost()
	{
		openSubState(new LoseSubState());
	}

	function rotate(Bat:FlxObject, Ball:FlxObject):Void
	{
		bullet.angle = 90;
	}

	function move(Bat:FlxObject, Ball:FlxObject):Void
	{
		FlxTween.tween(endblock, {y: endblock.y - 500}, 1, {ease: FlxEase.quartInOut});
		coolbool = true;
		remove(bullet);
		bullet.x = 50;
		bullet.y = 500;
	}

	function move2(Bat:FlxObject, Ball:FlxObject):Void
	{
		FlxTween.tween(coinblock, {y: coinblock.y + 500}, 1, {ease: FlxEase.quartInOut});
		coolbool = true;
		remove(bullet);
		bullet.x = 50;
		bullet.y = 500;
	}

	function coincollect(Bat:FlxObject, Ball:FlxObject):Void
	{
		FlxG.sound.play(Paths.sound('startSound'));
		remove(coinblock);
		coolbool = true;
		remove(bullet);
		bullet.x = 50;
		bullet.y = 500;
	}

	function insideUpdate()
	{
		if (canClick)
		{
			if (FlxG.mouse.justPressed)
			{
				fire();
				canClick = false;
			}
		}
		else if (coolbool)
			canClick = true;
	}
}
