function postCreate() {
	var randomNum:Int = FlxG.random.int(1, 59);
	var bg:FunkinSprite = new FunkinSprite(0, 0, true);
	bg.loadGraphic(Paths.getPath('menus/loading/' + randomNum, 'image'));
	bg.screenCenter();
	add(bg);
}