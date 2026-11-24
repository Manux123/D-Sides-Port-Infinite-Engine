import flixel.util.FlxColor;

var p1:Array<String> = ['bg', 'ice', 'fog', 'ground', 'evilness', 'fgIce', 'orgh'/*, 'fog1', 'fog2'*/];
var p2:Array<String> = ['bg2', 'iceback', 'plat', 'floor', 'icefront'];
var introcc = CustomShader.loadShader('colorcorrection');
var colorcorrection = CustomShader.applyToCameras('colorcorrection', [camGame, camHUD]);
var black:FlxSprite;

function onCountdown() {
	countDown.skipCountdown = true;

	black = new FlxSprite(-300, -200).makeGraphic(FlxG.width + 600, FlxG.height + 400, FlxColor.BLACK);
	black.scrollFactor.set();
	black.cameras = [camOther];
	add(black);
}

function postCreate() {
	camHUD.alpha = 0;
	scoreText.alpha = 0;
	if (SaveData.data.shaders) {
		colorcorrection.setFloat('brightness', 0.0);
		colorcorrection.setFloat('contrast', 1.35);
		colorcorrection.setFloat('saturation', 0.40);
		colorcorrection.setFloat('customred', 0.1);
		colorcorrection.setFloat('customgreen', 0.1);
		colorcorrection.setFloat('customblue', 0.15);

		introcc.setFloat('brightness', 0.0);
		introcc.setFloat('contrast', 0.8);
		introcc.setFloat('saturation', 0.80);
		introcc.setFloat('customred', 0.0);
		introcc.setFloat('customgreen', 0.0);
		introcc.setFloat('customblue', 0.0);

		for (layer in gf.layers)
			layer.shader = introcc;

		for (layer in boyfriend.layers)
			layer.shader = introcc;

		for (layer in dad.layers)
			layer.shader = introcc;
	}
}

function onStepHit(step:Int) {
	switch (step) {
		case 8:
			FlxTween.tween(black, {alpha: 0}, 10);
		case 176:
			FlxTween.tween(camHUD, {alpha: 1}, 1);
		case 392:
			FlxTween.tween(black, {alpha: 1}, 1.2);
			FlxTween.tween(camHUD, {alpha: 0}, 1);
		case 468:
			stage.getObject('evilness').visible = true;
			stage.getObject('orgh').visible = false;
			black.alpha = 0;
			camHUD.alpha = 1;
			scoreText.alpha = 1;
			FlxG.camera.flash(FlxColor.WHITE, 1);
			if (SaveData.data.shaders) {
				for (layer in gf.layers)
					layer.shader = null;

				for (layer in boyfriend.layers)
					layer.shader = null;

				for (layer in dad.layers)
					layer.shader = null;
				CustomShader.clearAll();
			}
		case 838:
			FlxTween.tween(black, {alpha: 1}, 0.5);
			boyfriend.visible = false;
			for (layer in boyfriend.layers)
				layer.visible = false;
		case 845:
			FlxTween.tween(black, {alpha: 0}, 0.5);
			boyfriend.visible = true;
			for (layer in boyfriend.layers)
				layer.visible = true;
			for (layer in gf.layers)
				layer.visible = false;
			for (i in p1)
				stage.getObject(i).visible = false;
			for (i in p2)
				stage.getObject(i).visible = true;
		case 1359:
			FlxTween.tween(black, {alpha: 1}, 0.5);
		case 1362:
			for (layer in gf.layers)
				layer.visible = true;
			for (i in p1)
				stage.getObject(i).visible = true;
			for (i in p2)
				stage.getObject(i).visible = false;
		case 1372:
			FlxTween.tween(black, {alpha: 0}, 1);
		case 1616:

	}
}

function onDestroy() {
	if (black != null) {
		remove(black, true);
		black.destroy();
		black = null;
	}
}
