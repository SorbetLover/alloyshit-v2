function create(event){
    event.cancel();
    FlxG.camera.fade(0xFF000000, 1, !event.transOut);
    new FlxTimer().start(0.1, function(){
                finish();
    });

}