import flixel.text.FlxTextAlign;
import flixel.input.touch.FlxTouch;

var defaultHoldTime = 8;
var songIsPaused = false;

var botplayText:FlxText;

var botbtn:FunkinSprite;
function postCreate(){
    if(dad != null)         dad.holdTime =          defaultHoldTime;
    if(gf != null)          gf.holdTime =   defaultHoldTime;
    if(bf != null)          bf.holdTime =           defaultHoldTime;

    botplayText = new FlxText(FlxG.width / 2 , 100, 0, "CPU", 30);
    add(botplayText);
    botplayText.screenCenter();
    botplayText.y = 30;
    botplayText.alignment = FlxTextAlign.CENTER;
    botplayText.cameras = [camHUD];

    botbtn = new FunkinSprite().makeSolid(150,120, 0xFFFFFFFF);
    add(botbtn);
    botbtn.updateHitbox();
    botbtn.cameras = [camHUD];
    botbtn.setPosition(healthBar.x + healthBar.width, healthBar.y - (botbtn.height / 2));
    FlxG.mouse.visible = true;
}   
var fg = FlxG.keys.justPressed;
var delta = 0;
function update(elapsed){
    keyshit();
    functionsthing();
    botplayText.visible = player.cpu;
    if(player.cpu){

        delta += elapsed * (Conductor.bpm / 100);

        botplayText.alpha = (( 70 + 30 * Math.cos(delta)) / 100);
        botplayText.x = (FlxG.width / 2 - (botplayText.width / 2)) + 20 * Math.sin(delta);
    }
    for (touch in FlxG.touches.list)
    {
        if (touch.justPressed)
        {
            var pos = touch.getWorldPosition(camHUD);

            if (botbtn.overlapsPoint(pos))
            {
                player.cpu = !player.cpu;
            }
        }
    }

}
function keyshit(){
    if(fg.Z){
        songIsPaused = !songIsPaused;
    }
    if(fg.C){
        player.cpu = !player.cpu;
    }
}
function functionsthing(){
    if(songIsPaused){
        inst.pause();
        vocals.pause();
        for (strumLine in strumLines.members) strumLine.vocals.pause();
    } else {
        
        inst.resume();
        vocals.resume();
        
        inst.pitch = FlxG.save.data.curPitch;
        vocals.pitch = FlxG.save.data.curPitch;
        for (strumLine in strumLines.members){ strumLine.vocals.resume(); strumLine.vocals.pitch = FlxG.save.data.curPitch; }
    }
}
