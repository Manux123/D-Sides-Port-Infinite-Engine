import utils.InfiniteUtil;
import flixel.util.FlxStringUtil;
import flixel.text.FlxTextBorderStyle;

function postCreate() {
	scoreText.text = "Score: 0 | Misses: 0";
	scoreText.setFormat(Paths.getPath('tomo.otf', 'font'), 24, 0xFFFFFFFF, "center");
	scoreText.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000, 3, 1);

	healthBarBG.y -= 10.5;
	healthBarBG.x -= 6;
	rating.x = FlxG.width * 0.15;
	rating.y = FlxG.height * 0.8;
}

function onSkinRating(type, details) {
    if (type == 'numbers')
        return {path: Paths.getPath('game/hud/normal/score/nums/num' + Std.int(details), 'image')};
    return null;
}

var intendedScore:Float = 0;

function onUpdateScore(elapsed:Float) {
	intendedScore = FlxMath.lerp(intendedScore, playStateConfig.score, FlxMath.bound(elapsed * 16, 0, 1));

	var displayScore:String = InfiniteUtil.formatNumber(Math.round(intendedScore));

	if (SaveData.data.botplay)
		scoreText.text = 'BOTPLAY';
	else
		scoreText.text = 'Score: $displayScore | Misses: ${playStateConfig.misses}';

	return true;
}
