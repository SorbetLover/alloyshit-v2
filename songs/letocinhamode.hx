import flixel.text.FlxTextAlign;
function create(){ if(!FlxG.save.data.letocinhaMode) disableScript(); }

var toninhomisses:FlxText;
var letocinhamisses:FlxText;
var tmisses = 0;
var lmisses = 0;
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

    toninhomisses =     new FlxText(0,0,1000,  "0", 20);
    letocinhamisses =   new FlxText(0,0,1000,  "0", 20);
    for(i in [toninhomisses, letocinhamisses]){
        i.alignment = FlxTextAlign.CENTER;
        i.cameras = [camHUD];
        i.y = theStrs.members[0].y - 30;
        i.updateHitbox();
    }
    toninhomisses.x =   theStrs.members[0].x + (theStrs.members[0].width / 2) - (toninhomisses.width / 2) + 60;
    letocinhamisses.x = theStrs.members[2].x + (theStrs.members[2].width / 2) - (toninhomisses.width / 2) + 60;

    add(toninhomisses);
    add(letocinhamisses);
    
    if(FlxG.save.data.letocinhamultispeed){
        for(i in 0...theStrs.members.length){
            if(i <= 1) theStrs.members[i].scrollSpeed = FlxG.save.data.letocinhascroll1;
            if(i >= 2) theStrs.members[i].scrollSpeed = FlxG.save.data.letocinhascroll2;
        }
    } else {
        scrollSpeed = FlxG.save.data.letocinhadefscroll;
    }
}

// function onPlayerHit(e){
//     if(e.direction)
// }

function onPlayerMiss(e){
    switch(e.direction){
        case 0,1: tmisses += 1;
        case 2,3: lmisses += 1;
    }

    toninhomisses.text      = tmisses;
    letocinhamisses.text    = lmisses;
}