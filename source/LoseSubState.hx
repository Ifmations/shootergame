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

class LoseSubState extends FlxSubState
{
	var won:FlxText;
	var cont:FlxText;
	var bg:FlxSprite;

	override public function create()
	{
		FlxG.mouse.visible = false;

		new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			FlxTween.tween(cont, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
			FlxTween.tween(won, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
			FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		});

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		add(bg);

		won = new FlxText(800, 50, 0, "YOU LOST! \n better luck next time", 12);
		won.scrollFactor.set();
		won.setFormat(Paths.font("chat text.ttf"), 100, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		won.screenCenter(X);
		won.alpha = 0;
		add(won);

		cont = new FlxText(12, 600, 0, "Press Enter To go to menu", 12);
		cont.scrollFactor.set();
		cont.setFormat(Paths.font("chat text.ttf"), 24, FlxColor.BLACK, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.WHITE);
		cont.screenCenter(X);
		cont.alpha = 0;
		add(cont);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}
