import flixel.text.FlxTextAlign;

var deletedicons = false;
var mark;
var bon;
var fox;
var fred;
var gfr;
var spat = "stages/ourple/bite/";

var fredjumpF:FunkinSprite;
var markCamera:FlxCamera;

var stageback:FunkinSprite;
var stagefront:FunkinSprite;

var doorL:FunkinSprite;
var doorR:FunkinSprite;

var dbl;
var dbr;
var lbl;
var lbr;
var tablet;

var start1;
var start2;
var start3;

var closeddoory:Int = 0;
var foxyX = 0;
var bonnieX = 0;
var freddyX = 0;
var shitOffsetY = 0;
function create(){
    stageC();
}
var killbonnie = false;
var camfy = 0;
function postCreate(){
    camGame.bgColor = 0xFF000000;
    mark = strumLines.members[1].characters[0];
    fred = strumLines.members[0].characters[0];
    bon = strumLines.members[0].characters[1];
    fox = strumLines.members[0].characters[2];
    gfr = strumLines.members[0].characters[3];
    stagePC();
    markCamera = new FlxCamera(0,0, FlxG.width, FlxG.height, 1);
    FlxG.cameras.insert(markCamera, FlxG.cameras.list.indexOf(camHUD), false);
    markCamera.bgColor = 0x00FFFFFF;


    defaultCamZoom = 0.58;
    FlxG.camera.zoom = defaultCamZoom;
    healthBar.visible = false;
    healthBarBG.visible = false;
    strumLines.members[1].characters[0].idleSuffix = "-alt";


    fredjumpF = new FunkinSprite();
    fredjumpF.frames = Paths.getSparrowAtlas(spat + "freddyjump");
    fredjumpF.scrollFactor.set(0,0);
    fredjumpF.screenCenter();
    fredjumpF.scale.set(0.4,0.4);
    fredjumpF.cameras = [camHUD];
    fredjumpF.visible = false;
    fredjumpF.animation.addByPrefix("jump", "FredJUMPSCARE", 24, false, false);
    insert(0, fredjumpF);
    fredjumpF.y -= 100;

    mark.cameras = [markCamera];
    mark.scale.set(0.6,0.6);
    mark.fixChar(true, false);
    mark.scrollFactor.set(0,0);
    // mark.x = FlxG.width - (mark.width * 0.6); 
    mark.x = 0 - 70;
    mark.y = -80;
    gf.x += 10293;
    for(i in [fox, bon, fred, gfr]){
        remove(i);
        insert(members.indexOf(stageback) + 1, i);
        i.scale.set(0.9,0.9);
    }

    for (i in members) {
        if (Std.isOfType(i, FunkinSprite)) {
            cast(i, FunkinSprite).scrollFactor.set(0, 0);
        }
    }
    //////////////////////////

    fox.x = -1130;
    fox.y -= 400;   
    foxyX = fox.x;
    fox.x -= 900;

    bon.x = -1250;
    bon.y = -330;
    bonnieX = bon.x;
    bon.x -= 900;

    gfr.x = -700;
    gfr.y -= 300;


    fred.x += 300;
    fred.y -= 400;

    gfr.visible = false;
    for(i in [fox, bon, fred, gfr]){
        i.y += shitOffsetY;
        i.scrollFactor.set(1,1);
    }

    hudpc();

    if(FlxG.width == 1560){
        camfy = 0;
        defaultCamZoom += 0.1;
        FlxG.camera.zoom = defaultCamZoom;
    }

}
var jumpscaring = false;
function postUpdate(){
    if(jumpscaring == false && paused == false){
            camGame.fade(0xFF000000, 0, true);
    }
    camFollow.setPosition(0,camfy);
    if(deletedicons == false){
        ///////// cant do it on postCreate
        var fh = 0;
        for(i in members){
            if(i.ID == 9991 || i.ID == 9992){
                i.visible = false;
                deletedicons = true;
                fh++;
                if(fh == 2) break;
            }
        }
    }

    if(Conductor.curStep >= 1190) bon.visible = false;
}
// function onSongStart(){
//     fredjumpF.playAnim("jump");
// }
function jumpscare(ver){
    switch(ver){
        case "-2":
            mark.playAnim("scream", true);
            fredjumpF.visible = true;
            fredjumpF.playAnim("jump", true);
            camGame.fade(0xFF000000, 0, false);
            swapside(false);
            jumpscaring = true;
            mark.fixChar(true, false);


        case "-1":
            mark.playAnim("scream", true);

        default:
            fredjumpF.visible = true;
            fredjumpF.playAnim("jump", true);
            camGame.fade(0xFF000000, 0, false);
            jumpscaring = true;

        case "0":
            fredjumpF.visible = true;
            fredjumpF.playAnim("jump", true);
            camGame.fade(0xFF000000, 0, false);
            jumpscaring = true;
        
        case "1":
            fredjumpF.visible = false;
            jumpscaring = false;
            camGame.fade(0xFF000000, 0, true);



    }
}

function onNoteHit(e){
    if(e.noteType == "No Animation"){
        e.preventAnim();
    }
}

function swapside(side){
    switch(side){
        case false, "false":
            mark.x = 0 - 70;
        case true, "true":
            mark.fixChar(true, true);
            FlxTween.tween(mark, {x: FlxG.width - (mark.width - 70)}, 1 * inst.pitch, {ease:FlxEase.cubeInOut});
            

    }
}


function stageC(){
    doorL = new FunkinSprite().loadGraphic(Paths.image(spat + "door"));
    add(doorL);
    doorL.scale.set(1.8,1.8);

    doorR = new FunkinSprite().loadGraphic(Paths.image(spat + "door"));
    add(doorR);
    doorR.flipX = true;
    doorR.scale.set(1.8,1.8);

    doorR.x = 135;
    doorL.x = 100;

    doorR.y = 200 + shitOffsetY;
    doorL.y = 200 + shitOffsetY;



    doorR.y += shitOffsetY;
    doorL.y += shitOffsetY;



    
    stageback = new FunkinSprite().loadGraphic(Paths.image(spat + "stageback"));
    add(stageback);
    // stageback.alpha = 0;
    stageback.scale.set(1.8,1.8);
    stageback.screenCenter();
    stageback.scrollFactor.set(0,0);
    stageback.y += shitOffsetY;

}

function stagePC(){
    stagefront = new FunkinSprite().loadGraphic(Paths.image(spat + "stagefront"));
    stagefront.scrollFactor.set(0,0);
    stagefront.screenCenter();
    stagefront.y += shitOffsetY;
    stagefront.scale.set(stageback.scale.x, stageback.scale.y);
    add(stagefront);

    lbl = new FunkinSprite().loadGraphic(Paths.image(spat + "lightb"));
    add(lbl);
    lbl.scale.set(stageback.scale.x, stageback.scale.y);
    lbl.x = -311;
    lbl.y = 10;
    lbl.y += shitOffsetY;
    
    dbl = new FunkinSprite().loadGraphic(Paths.image(spat + "button"));
    add(dbl);
    dbl.scale.set(stageback.scale.x, stageback.scale.y);
    dbl.x = -335;
    dbl.y = 10;
    dbl.y += shitOffsetY;

    lbr = new FunkinSprite().loadGraphic(Paths.image(spat + "lightb"));
    add(lbr);
    lbr.scale.set(stageback.scale.x, stageback.scale.y);
    lbr.x = 1711;
    lbr.y = 10;
    lbr.y += shitOffsetY;
    
    dbr = new FunkinSprite().loadGraphic(Paths.image(spat + "button"));
    add(dbr);
    dbr.scale.set(stageback.scale.x, stageback.scale.y);
    dbr.x = 1780;
    dbr.y = 10;
    dbr.y += shitOffsetY;
    
    dbr.flipX = true;
    lbr.flipX = true;
    for(i in [dbr, dbl, lbr, lbl]){
        i.visible = false;
        i.scrollFactor.set(stageback.scrollFactor.x,stageback.scrollFactor.y);
    }
    closeddoory = doorL.y;

    for(i in [doorL, doorR]){
        i.y -= 1500;
    }
}

function hudpc(){
    makevig(Paths.image(spat + "overlay"), null);
    makevig(Paths.image(spat + "bddown"), true);
    makevig(Paths.image(spat + "bdup"), false);

    tablet = new FunkinSprite();
    tablet.frames = Paths.getSparrowAtlas((spat + "Djcamera"));
    tablet.animation.addByPrefix("flip", "CamFLIP", 24);
    tablet.animation.addByPrefix("loop", "CamLOOP", 24);
    insert(0,tablet);
    tablet.cameras = [markCamera];
    
    tablet.visible = false;

    tablet.screenCenter();
    tablet.scale.set(0.67,0.67);
    tablet.x += 120;
    tablet.y -= 10;

    start1 = new FunkinSprite().loadGraphic(Paths.image(spat + "bitetitle"));
    start2 = new FunkinSprite().loadGraphic(Paths.image(spat + "news"));
    start1.cameras = [markCamera];
    start2.cameras = [markCamera];
    start1.setGraphicSize(1280,720);
    start2.setGraphicSize(1280,720);
    start1.screenCenter();
    start2.screenCenter();

    start3 = new FlxText(0,0,0, "12:00 AM\n1st Night", 36);
    start3.cameras = [markCamera];
    start3.screenCenter();
    start3.alignment = FlxTextAlign.CENTER;
    insert(1, start3);
    insert(2, start2);
    insert(3, start1);
    start3.font = Paths.font("bite.ttf");











    markCamera.bgColor = 0xFF000000;
}


function makevig(pat, another){
    // var thevig = new FunkinSprite().loadGraphic(pat);
    ///    // thevig.cameras = [camHUD];
    // thevig.scrollFactor.set(0,0);     
    // add(thevig);
}
var  leavetime = 0.2;

function aleave(wich){
    leavetime = 0.2 * inst.pitch;
    switch(wich){
        case "0":
            FlxTween.tween(fred, {x: fred.x + 900}, leavetime);
                        closed("true");
                        // closed("false");

        case "1":
            FlxTween.tween(bon, {x: bon.x - 900}, leavetime);
                        closed("false");
            new FlxTimer().start(1, function(cu:FlxTimer){
                killbonnie = true;
            });

        case "2":
            FlxTween.tween(fox, {x: fox.x + 900}, leavetime);
                        closed("false");

        case "3":
            // gfr.visible = false;
            FlxTween.tween(gfr, {alpha: 0}, 2);
    }
}

function aenter(wich){
    switch(wich){
        case "0":
            FlxTween.tween(fred, {x: fred.x - 500}, leavetime);
        case "1":
            FlxTween.tween(bon, {x: bonnieX}, leavetime * 2, {ease:FlxEase.cubeOut});
            
        case "2":
            FlxTween.tween(fox, {x: foxyX}, leavetime);
            fox.playAnim("jumpscare", true);
            
        case "3":
            gfr.visible = true;
            FlxTween.tween(bon, {x: bon.x - 900}, 0.01);


    }
}

function closed(side){
    switch(side){
        case "false":
            FlxTween.tween(doorL, {y: closeddoory - 100}, leavetime);
            dbl.visible = true;

        case "true":
            dbr.visible = true;
            FlxTween.tween(doorR, {y: closeddoory - 100}, leavetime);

    }
}


function opend(side){
    switch(side){
        case "false":
            dbl.visible = false;
            FlxTween.tween(doorL, {y: closeddoory - 1500}, leavetime);
        case "true":
            dbr.visible = false;
            FlxTween.tween(doorR, {y: closeddoory - 1500}, leavetime);
    }
}

function forceopen(){
            dbl.visible = false;
            FlxTween.tween(doorL, {y: closeddoory - 1500}, 1);
            dbr.visible = false;
            FlxTween.tween(doorR, {y:  closeddoory- 1500}, 1);
}
function forceclose(){
            dbl.visible = false;
            FlxTween.tween(doorL, {y: closeddoory}, 1);
            dbr.visible = false;
            FlxTween.tween(doorR, {y:  closeddoory}, 1);
}
function tablets(cu){
    switch(cu){
        case "0":
            tablet.visible = true;
            tablet.playAnim("flip");
            
        
        case "1":
            tablet.playAnim("loop");
            tablet.x += 120 * tablet.scale.x;
            markCamera.bgColor = 0xFF000000;
        case "2":
            tablet.y = 1834;
            markCamera.bgColor = 0x00FFFFFF;
            tablet.visible = false;
    }
}

function killfox(){
    fox.x -= 4272;
}

function fredback(){
                FlxTween.tween(fred, {x: fred.x - 900}, 0.01);

}

function startthing(wich){
    switch(wich){
        case "1": 
            FlxTween.tween(start1, {alpha: 0}, 1 * inst.pitch);
        case "2":
            FlxTween.tween(start2, {alpha: 0}, 1 * inst.pitch);
        case "3":
            FlxTween.tween(start3, {alpha: 0}, 1 * inst.pitch);
            markCamera.bgColor = 0x00FFFFFF;
            camGame.fade(0xFF000000, 1 * inst.pitch, true);
    }
}

function endingthing(){
    aleave("0");
    jumpscaring = true;
    camGame.fade(0xFF000000, 0.5 * inst.pitch, false);

}