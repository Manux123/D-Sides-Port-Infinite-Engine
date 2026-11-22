import utils.InfiniteUtil;
import flixel.util.FlxStringUtil;
import flixel.text.FlxTextBorderStyle;
import game.PlayStateConfig;

function postCreate() {
	scoreText.text = "Score: 0 • Misses: 0";
	scoreText.setFormat(Paths.getPath('tomo.otf', 'font'), 24, 0xFFFFFFFF, "center");
	scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000, 3, 1);

	healthBarBG.y -= 10.5;
	healthBarBG.x -= 6;
	combo.numberOffsetX = 50;
	combo.numberOffsetY = 20;
	combo.x = FlxG.width * 0.15;
	combo.y = FlxG.height * 0.8;
}

var intendedScore:Float = 0;

function onUpdateScore(elapsed:Float) {
	intendedScore = FlxMath.lerp(intendedScore, PlayStateConfig.score, FlxMath.bound(elapsed * 16, 0, 1));

	var displayScore:String = InfiniteUtil.formatNumber(Math.round(intendedScore));

	if (SaveData.data.botplay)
		scoreText.text = 'BOTPLAY';
	else
		scoreText.text = 'Score: $displayScore • Misses: ${PlayStateConfig.misses}';

	return true;
}
