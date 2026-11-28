import flixel.util.FlxColor;
import core.api.DiscordAPI;
import openfl.display.BlendMode;

var p1:Array<String> = ['bg', 'ice', 'fog', 'ground', 'evilness', 'fgIce', 'orgh' /*, 'fog1', 'fog2'*/];
var p2:Array<String> = ['bg2', 'iceback', 'plat', 'floor', 'icefront'];
var introcc = CustomShader.loadShader('colorcorrection');
var colorcorrection = CustomShader.applyToCameras('colorcorrection', [camGame, camHUD]);
var black:FlxSprite;
var textevil = new FlxText();
var screen:Array<FlxSprite> = [];
var zepStrums = null;
var bfStrums = null;
var bg:FunkinSprite;
var snowOverlay:FunkinSprite;
var addepic:FlxSprite;
var transition = null;

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

	bg = new FunkinSprite(0, 0, true);
	bg.loadGraphic(Paths.getPath("game/stages/try-harder/Transition", 'image'));
	bg.scrollFactor.set(0, 0);
	bg.setGraphicSize(Std.int(bg.width * 2.0));
	screen.push(bg);

	textevil.setFormat(Paths.getPath('Sonic Advanced 2.ttf', 'font'), 40, 0xFF000000, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFFFFE100);
	textevil.borderSize = 2.5;
	textevil.antialiasing = false;
	textevil.scrollFactor.set(0, 0);
	textevil.scale.set(2, 2.2);
	textevil.text = "Breaking a sweat already..?";
	textevil.x = (1280 / 2) - (textevil.width / 2);
	textevil.y = (720 / 2) - (textevil.height / 2);
	screen.push(textevil);

	for (item in screen) {
		item.antialiasing = true;
		item.visible = false;
		add(item);
	}

	zepStrums = getStrumline('mighty');
	bfStrums = getStrumline('mobian_bf');
	transition = stage.getObject("transition");

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

	snowOverlay = new FunkinSprite(0, 0, true);
	snowOverlay.loadGraphic(Paths.getPath("game/stages/try-harder/snow overlay", 'image'));
	snowOverlay.cameras = [camOther];
	snowOverlay.scrollFactor.set(0, 0);
	snowOverlay.setGraphicSize(Std.int(snowOverlay.width * 1.10));
	snowOverlay.alpha = 0;
	snowOverlay.shader = colorcorrection;
	colorcorrection.setFloat('saturation', 0.3);
	add(snowOverlay);

	addepic = new FlxSprite(0,0).makeGraphic(1280, 720, 0xFF0A274F);
    addepic.scrollFactor.set(0, 0);
    addepic.setGraphicSize(Std.int(addepic.width * 2.0));
    addepic.blend = BlendMode.ADD;
    addepic.alpha = 0;
    add(addepic);
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
		case 1358:
			FlxTween.tween(black, {alpha: 1}, 0.5);
		case 1372:
			for (layer in gf.layers)
				layer.visible = true;
			for (i in p1)
				stage.getObject(i).visible = true;
			for (i in p2)
				stage.getObject(i).visible = false;
			FlxTween.tween(black, {alpha: 0}, 1);
		case 1616:
			for (item in screen) {
				item.visible = true;
			}
			combo.visible = false;
			textevil.text = "Breaking a sweat already..? \nhere, no need to thank me...";
			healthBar.visible = false;
			healthBarBG.visible = false;
			scoreText.visible = false;
			iconP1.visible = false;
			iconP2.visible = false;

			zepStrums.alpha = 0;
		case 1632:
			var username:String = 'BOYFRIEND';
			if (DiscordAPI.username != 'Unknown')
				username = DiscordAPI.username;
			textevil.text = "Breaking a sweat already..? \nhere, no need to thank me... \n" + username + ".";
		case 1648:
			for (item in screen) {
				item.visible = false;
			}

			if (SaveData.data.shaders) {
				for (layer in gf.layers)
					layer.shader = introcc;

				for (layer in boyfriend.layers)
					layer.shader = introcc;

				for (layer in dad.layers)
					layer.shader = introcc;

				colorcorrection = CustomShader.applyToCameras('colorcorrection', [camGame, camHUD]);
				colorcorrection.setFloat('brightness', 0.0);
				colorcorrection.setFloat('contrast', 1.35);
				colorcorrection.setFloat('saturation', 0.40);
				colorcorrection.setFloat('customred', 0.1);
				colorcorrection.setFloat('customgreen', 0.1);
				colorcorrection.setFloat('customblue', 0.15);
			}
			FlxTween.tween(bfStrums, {alpha: 0}, 1, {ease: FlxEase.cubeOut});

		case 1896:
			combo.visible = true;
			healthBar.visible = true;
			healthBarBG.visible = true;
			scoreText.visible = true;
			iconP1.visible = true;
			iconP2.visible = true;
			scoreText.y -= SaveData.data.downscroll ? 300 : -300;
			healthBarBG.y -= SaveData.data.downscroll ? 300 : -300;
			healthBar.y -= SaveData.data.downscroll ? 300 : -300;
			FlxTween.tween(scoreText, {y: scoreText.y + (SaveData.data.downscroll ? -300 : 300)}, 0.6, {ease: FlxEase.cubeOut});
			FlxTween.tween(healthBarBG, {y: healthBarBG.y + (SaveData.data.downscroll ? -300 : 300)}, 0.6, {ease: FlxEase.cubeOut});
			FlxTween.tween(healthBar, {y: healthBar.y + (SaveData.data.downscroll ? -300 : 300)}, 0.6, {ease: FlxEase.cubeOut});

			FlxTween.tween(zepStrums, {alpha: 1}, 0.25);
			FlxTween.tween(bfStrums, {alpha: 1}, 0.25);
		case 1903:
			FlxTween.tween(stage.getObject("snowAtlas"), {alpha: 1}, 0.25, {ease: FlxEase.cubeOut});

			FlxTween.tween(addepic, {alpha: 1}, 0.25, {ease: FlxEase.cubeOut});
			FlxTween.tween(snowOverlay, {alpha: 1}, 0.25, {ease: FlxEase.cubeOut});
			transition.alpha = 1;
			transition.x = -4200;
			FlxTween.tween(transition, {x: 3200}, 1, {ease: FlxEase.linear});
	}
}

function onDestroy() {
	if (black != null) {
		remove(black, true);
		black.destroy();
		black = null;
	}
}