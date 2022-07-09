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

class Level5 extends FlxState
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
	var block6:FlxSprite;
	var block7:FlxSprite;
	var block8:FlxSprite;
	var block9:FlxSprite;
	var block10:FlxSprite;
	var block11:FlxSprite;
	var bounceblock2:FlxSprite;
	var endblock:FlxSprite;
	var moveblock:FlxSprite;
	var moveblock2:FlxSprite;
	var coinblock:FlxSprite;
	var upblock:FlxSprite;

	var outer:FlxGroup;

	var bullets:Int = 3;
	var grpBullets:FlxTypedGroup<FlxSprite>;

	var canClick:Bool = true; // outside of functions
	var coolbool:Bool = true;

	var lives:FlxText;

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
		block = new FlxSprite(800, 85).loadGraphic(Paths.image('blocks/block'));
		block.immovable = true;
		add(block);

		block2 = new FlxSprite(800, 650).loadGraphic(Paths.image('blocks/block'));
		block2.immovable = true;
		add(block2);

		block3 = new FlxSprite(800, 560).loadGraphic(Paths.image('blocks/block'));
		block3.immovable = true;
		add(block3);

		block4 = new FlxSprite(800, 480).loadGraphic(Paths.image('blocks/block'));
		block4.immovable = true;
		add(block4);

		block5 = new FlxSprite(800, 395).loadGraphic(Paths.image('blocks/block'));
		block5.immovable = true;
		add(block5);

		bounceblock = new FlxSprite(800, 175).loadGraphic(Paths.image('blocks/rebound'));
		bounceblock.immovable = true;
		add(bounceblock);

		block6 = new FlxSprite(1000, 85).loadGraphic(Paths.image('blocks/block'));
		block6.immovable = true;
		add(block6);

		block7 = new FlxSprite(1000, 650).loadGraphic(Paths.image('blocks/block'));
		block7.immovable = true;
		add(block7);

		block8 = new FlxSprite(1000, 560).loadGraphic(Paths.image('blocks/block'));
		block8.immovable = true;
		add(block8);

		block9 = new FlxSprite(1000, 480).loadGraphic(Paths.image('blocks/block'));
		block9.immovable = true;
		add(block9);

		block10 = new FlxSprite(1000, 175).loadGraphic(Paths.image('blocks/block'));
		block10.immovable = true;
		add(block10);

		block11 = new FlxSprite(1000, 0).loadGraphic(Paths.image('blocks/block'));
		block11.immovable = true;
		add(block11);

		upblock = new FlxSprite(500, 0).loadGraphic(Paths.image('blocks/block'));
		upblock.immovable = true;
		FlxTween.tween(upblock, {y: upblock.y + 720}, 1, {type: FlxTween.PINGPONG, ease: FlxEase.cubeInOut});
		add(upblock);

		bounceblock2 = new FlxSprite(1000, 395).loadGraphic(Paths.image('blocks/rebound'));
		bounceblock2.immovable = true;
		add(bounceblock2);

		endblock = new FlxSprite(600, 850).loadGraphic(Paths.image('blocks/levelend'));
		endblock.immovable = true;
		add(endblock);

		moveblock = new FlxSprite(1150, 350).loadGraphic(Paths.image('blocks/move'));
		moveblock.immovable = true;
		add(moveblock);

		moveblock2 = new FlxSprite(800, 0).loadGraphic(Paths.image('blocks/move'));
		moveblock2.immovable = true;
		add(moveblock2);

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
		FlxG.collide(bullet, block6, bulletdeath);
		FlxG.collide(bullet, block7, bulletdeath);
		FlxG.collide(bullet, block8, bulletdeath);
		FlxG.collide(bullet, block9, bulletdeath);
		FlxG.collide(bullet, block10, bulletdeath);
		FlxG.collide(bullet, block11, bulletdeath);
		FlxG.collide(bullet, upblock, bulletdeath);
		FlxG.collide(bullet, bounceblock, ping);
		FlxG.collide(bullet, bounceblock2, ping);
		FlxG.collide(bullet, endblock, end);
		FlxG.collide(bullet, moveblock, move);
		FlxG.collide(bullet, moveblock2, move2);
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
