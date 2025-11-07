import flixel.addons.display.FlxBackdrop;
var backdrop:FlxBackdrop;
var nyansesii:FunkinSprite;

var botbtn:FunkinSprite;
var merdacam:FlxCamera;
function create(e){
	menuItems.insert(2, 'Change Diff');

    eventCreate(e);
    /// backdrop
        backdrop = new FlxBackdrop().loadGraphic(Paths.image("alloy/drawers"));
        add(backdrop);

        backdrop.alpha = 0.7;
        backdrop.antialiasing = false;
        backdrop.velocity.set(100 * (Conductor.bpm/ 90), 90);
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
        remove(members[3]);
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


function update(){
#if android
    for (touch in FlxG.touches.list)
    {
        if (touch.justPressed || FlxG.mouse.justPressed)
        {
            // usa a câmera do botão (merdacam)
            var pos = touch.getWorldPosition(merdacam);

            // usa overlapsPoint com o mesmo espaço de coordenadas
            if (botbtn.overlapsPoint(pos, true, merdacam))
            {
                PlayState.instance.player.cpu = !PlayState.instance.player.cpu;
                trace("merda");
            }
        }
    }
#end
// if (FlxG.mouse.justPressed)
// {
//     // converte a posição do mouse pra coordenadas da merdacam
//     var mousePos = FlxG.mouse.getWorldPosition(merdacam);

//     // checa se o mouse está sobre o botão (usando a mesma câmera)
//     if (botbtn.overlapsPoint(mousePos, true, merdacam))
//     {
//         PlayState.instance.player.cpu = !PlayState.instance.player.cpu;
//         trace("clicou no botão!");
//     }
// }


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
        trace(merdacam);
        FlxG.cameras.remove(merdacam);
        merdacam.destroy();
        merdacam = null;
        trace(merdacam);
    }
}
