import flixel.addons.display.FlxBackdrop;


var backdrop:FlxBackdrop;
var nyansesii:FunkinSprite;

var botbtn:FunkinSprite;
var merdacam:FlxCamera;

var backdrop1:FlxBackdrop;

var pauseBeat = 0;
var pauseStep = 0;
//// 140 bpm
function create(e){

	menuItems.insert(2, 'Change Diff');

    eventCreate(e);
    /// backdrop
        backdrop = new FlxBackdrop().loadGraphic(Paths.image("alloy/drawers"));
        add(backdrop);

        backdrop.alpha = 0.5;
        backdrop.antialiasing = false;
        backdrop.velocity.set(100 * (Conductor.bpm/ 90), 90);

        backdrop1 = new FlxBackdrop().loadGraphic(Paths.image("menuBGHexL6"));
        add(backdrop1);        
        backdrop1.velocity.set(29,30);
        backdrop1.alpha = 0.1;
            backdrop2 = new FlxBackdrop().loadGraphic(Paths.image("menuBGHexL6"));
        insert(100, backdrop2);        
        backdrop2.velocity.set(-29,-30);
        backdrop2.alpha = 0.1;
    /// baby
        nyansesii = new FunkinSprite().loadGraphic(Paths.image("alloy/jolly"));
        nyansesii.scale.set(2.2,2.2);
        add(nyansesii);
        nyansesii.updateHitbox();
        nyansesii.y = FlxG.height - nyansesii.height;
        nyansesii.x = FlxG.width - nyansesii.width;
}
function eventCreate(e){
        e.music = "property-surgery";
}
var pitchthing:FlxText;
    
function postCreate(){
    if(Conductor.isSorbetBuild){
        bg.visible = false;
    } else {
        camera.bgColor = 0x00000000;
    }
    // trace(FlxG.save.data.curPitch);
        if(FlxG.save.data.curPitch == null || FlxG.save.data.curPitch < 0) FlxG.save.data.curPitch = 1;
        
        pitchthing = new FlxText(900,400, 0, "[Yr][I+][O-]\n  Pitch = " + FlxG.save.data.curPitch, 30);
        pitchthing.font = Paths.font("notosans.ttf");
        add(pitchthing);
    // merdacam
        merdacam = new FlxCamera();
        FlxG.cameras.add(merdacam, false);
        merdacam.bgColor = 0x00FFFFFF;    
    //botplay
    #if mobile
        botbtn = new FunkinSprite().makeSolid(300,120,0x33FFFFFF);
        botbtn.x = FlxG.width - 500;
        botbtn.updateHitbox();
        add(botbtn);
        botbtn.cameras = [merdacam];
    #end
}
var fg = FlxG.keys.justPressed;
var fag = FlxG.keys.pressed;

var bpm = 140;
var secPerBeat = 60 / bpm;
var lastStep = -1;

function songShitUpdate()
{   
    
    var curTime = pauseMusic.time / 1000;
    var curStep = Math.floor((curTime / secPerBeat) * 4);
    if(curTime <= 1){
        lastStep = curStep;
    }
    if (curStep > lastStep)
    {
        for (i in lastStep + 1...curStep + 1)
        {
            coolStep(i);
        }

        lastStep = curStep;
    }
}

function coolStep(step){
    switch(step){
        case 256,258,266,272,274,282,288,290,298,304,306,314,320,322,330,336,338,346,352,354,362,368,370,378,384,386,394,400,402,410,416,418,426,432,434,442,448,450,458,464,466,474,480,482,490,496,498,506,640,642,650,656,658,666,672,674,682,688,690,698,704,706,714,720,722,730,736,738,746,752,754,762:
            backdrop1.alpha = 0.6;
    }
}
function onStepHit(step:Int)
{
    trace("Step:", step);
}


function update(elapsed){
    if (pauseMusic != null && pauseMusic.volume < 0.7)
        pauseMusic.volume += 0.08 * elapsed;
    songShitUpdate();
    backdrop1.alpha = FlxMath.lerp(backdrop1.alpha * 100, 0.1 * 100, 0.04) / 100;


#if android
    for (touch in FlxG.touches.list)
    {
        if (touch.justPressed || FlxG.mouse.justPressed)
        {
            var pos = touch.getWorldPosition(merdacam);

            if (botbtn.overlapsPoint(pos, true, merdacam))
            {
                PlayState.instance.player.cpu = !PlayState.instance.player.cpu;
                trace("merda");
            }
        }
    }
#end


    if(fg.Y) FlxG.save.data.curPitch = 1;

    if(fag.SHIFT){
        if(fg.I) FlxG.save.data.curPitch += 0.05;
        if(fg.O) FlxG.save.data.curPitch -= 0.05; 
    } else if (fag.CONTROL) {
        if(fg.I) FlxG.save.data.curPitch += 1;
        if(fg.O) FlxG.save.data.curPitch -= 1; 
    } else {

        if(fg.I) FlxG.save.data.curPitch += 0.1;
        if(fg.O) FlxG.save.data.curPitch -= 0.1;
    }

    FlxG.save.data.curPitch = FlxMath.bound(FlxG.save.data.curPitch, 0.1, 50);
    pitchthing.text = "[Yr][I+][O-]\nPitch = " + FlxG.save.data.curPitch;
    if (controls.ACCEPT) if (menuItems[curSelected] == "Change Diff") openSubState(new ModSubState("mod/PauseDiffs"), true);
}

function destroy() {
    if (merdacam != null) {
        FlxG.cameras.remove(merdacam);
        merdacam.destroy();
        merdacam = null;
    }
}
