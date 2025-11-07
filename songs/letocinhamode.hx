function create(){ if(!FlxG.save.data.letocinhaMode) disableScript(); }
function postCreate(){
    var theStrs;
    theStrs = PlayState.opponentMode ? cpuStrums : playerStrums; 
    trace(PlayState.opponentMode);
    var umm = 0;
    for(i in theStrs.members){
        if(umm <= 1) i.x -= 30; else i.x += 30;
        var cu = new FunkinSprite().makeSolid(i.width + 10, 900, 0xFF000000);
        insert(0, cu);
        cu.alpha = FlxG.save.data.letocinhadefalpha;
        cu.x = i.x - 5;
        cu.cameras = [camHUD];
        if(umm >= 4) umm = 0; else umm++;
    }   
    if(FlxG.save.data.letocinhamultispeed){
        for(i in 0...theStrs.members.length){
            if(i <= 1) theStrs.members[i].scrollSpeed = FlxG.save.data.letocinhascroll1;
            if(i >= 2) theStrs.members[i].scrollSpeed = FlxG.save.data.letocinhascroll2;
        }
    } else {
        scrollSpeed = FlxG.save.data.letocinhadefscroll;
    }
}