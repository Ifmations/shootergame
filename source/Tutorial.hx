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

class Tutorial extends FlxState
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
	var bounceblock:FlxSprite;
	var endblock:FlxSprite;
	var moveblock:FlxSprite;
	var coinblock:FlxSprite;

	var outer:FlxGroup;

	var bullets:Int = 9999;
	var grpBullets:FlxTypedGroup<FlxSprite>;

	var canClick:Bool = true; // outside of functions
	var coolbool:Bool = true;

	var txt5:FlxText;

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

		var txt:FlxText = new FlxText(300, 50, 0, "this is a block, it kills your bullet!", 12);
		txt.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt);

		var txt2:FlxText = new FlxText(350, 200, 0, "this makes your bullet bounce away!", 12);
		txt2.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt2);

		var txt4:FlxText = new FlxText(600, 500, 0, "this makes you win!", 12);
		txt4.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt4);

		var txt45:FlxText = new FlxText(450, 550, 0, "press it once you have finished!", 12);
		txt45.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt45);

		var txt3:FlxText = new FlxText(400, 350, 0, "this can move other blocks around", 12);
		txt3.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt3);

		txt5 = new FlxText(0, -500, 0, "some coins can be hidden...", 12);
		txt5.setFormat(Paths.font("chat text.ttf"), 18, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		add(txt5);

		block = new FlxSprite(1100, 50).loadGraphic(Paths.image('blocks/block'));
		block.immovable = true;
		add(block);

		bounceblock = new FlxSprite(1100, 200).loadGraphic(Paths.image('blocks/rebound'));
		bounceblock.immovable = true;
		add(bounceblock);

		endblock = new FlxSprite(1100, 500).loadGraphic(Paths.image('blocks/levelend'));
		endblock.immovable = true;
		add(endblock);

		moveblock = new FlxSprite(1100, 350).loadGraphic(Paths.image('blocks/move'));
		moveblock.immovable = true;
		add(moveblock);

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

		super.create();
	}

	override public function update(elapsed:Float)
	{
		FlxG.collide(bullet, outer, bulletdeath); // DONT DELETE HAS BORDER FOR THE BATTLE BOX STUPID DUMB BITCH ALEX DO. NOT. DELETE!
		FlxG.collide(bullet, block, bulletdeath);
		FlxG.collide(bullet, bounceblock, ping);
		FlxG.collide(bullet, endblock, end);
		FlxG.collide(bullet, moveblock, move);
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

	function rotate(Bat:FlxObject, Ball:FlxObject):Void
	{
		bullet.angle = 90;
	}

	function move(Bat:FlxObject, Ball:FlxObject):Void
	{
		FlxTween.tween(coinblock, {y: coinblock.y + 500}, 1, {ease: FlxEase.quartInOut});
		FlxTween.tween(txt5, {y: coinblock.y + 500}, 1, {ease: FlxEase.quartInOut});
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
		remove(txt5);
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
