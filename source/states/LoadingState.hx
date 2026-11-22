function onCreate() {
	final randomNum:Int = FlxG.random.int(1, 59);
	final bg:FunkinSprite = new FunkinSprite(0, 0, true);
	bg.loadGraphic(Paths.getPath('menus/loading/' + randomNum, 'image'));
	bg.setGraphicSize(1280, 720);
	bg.updateHitbox();
	bg.screenCenter();
	bg.alpha = 0.5;
	add(bg);
}