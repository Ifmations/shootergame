package;

import flixel.FlxG;
import flixel.FlxSprite;

class Gun extends FlxSprite
{
	final SPEED:Int = 1000;

	public function new(xPos:Int = 0, yPos:Int = 0)
	{
		super(xPos, yPos);
		loadGraphic(Paths.image('shootbase'));
	}

	function movement()
	{
		final up = FlxG.keys.anyPressed([UP, W]);
		final down = FlxG.keys.anyPressed([DOWN, S]);

		if (up)
		{
			velocity.y = -SPEED;
		}
		else if (down)
		{
			velocity.y = SPEED;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
	}
}
