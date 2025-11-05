import flixel.text.FlxTextAlign;

var defaultHoldTime = 8;
var songIsPaused = false;

var botplayText:FlxText;
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
}   
var fg = FlxG.keys.justPressed;
var delta = 0;
function update(elapsed){
    keyshit();
    functionsthing();
    botplayText.visible = player.cpu;
    if(player.cpu){

        delta += elapsed * 5;

        botplayText.alpha = (( 70 + 30 * Math.cos(delta)) / 100);
        botplayText.x = (FlxG.width / 2 - (botplayText.width / 2)) + 20 * Math.sin(delta);
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
