import flixel.text.FlxTextAlign;
import flixel.input.touch.FlxTouch;

var defaultHoldTime = 6;
var songIsPaused = false;

var botplayText:FlxText;
var theStrs;
function postCreate(){
    theStrs = PlayState.opponentMode ? cpu : player;
    if(dad != null)         dad.holdTime =          defaultHoldTime;
    if(gf != null)          gf.holdTime =       defaultHoldTime;
    if(bf != null)          bf.holdTime =           defaultHoldTime;

    botplayText = new FlxText(FlxG.width / 2 , 100, 0, "CPU", 30);
    add(botplayText);
    botplayText.screenCenter();
    botplayText.y = 30;
    botplayText.alignment = FlxTextAlign.CENTER;
    botplayText.cameras = [camHUD];
    
    if(FlxG.save.data.hidingHUD == null) FlxG.save.data.hidingHUD = false;
    
    #if android 
        FlxG.save.data.hidingHUD = false;
        camHUD.visible = FlxG.save.data.hidingHUD;
    #end
}   
var fg = FlxG.keys.justPressed;
var fgp = FlxG.keys.pressed;
var delta = 0;
function update(elapsed){
    
    keyshit();
    functionsthing();
    botplayText.visible = theStrs.cpu;
    if(theStrs.cpu){

        delta += elapsed * (Conductor.bpm / 100);

        botplayText.alpha = (( 70 + 30 * Math.cos(delta)) / 100);
        botplayText.x = (FlxG.width / 2 - (botplayText.width / 2)) + 20 * Math.sin(delta);
    }
    if(camHUD.visible == false) theStrs.cpu = true;
}
function keyshit(){
    if(FlxG.keys.justPressed.Z){
        songIsPaused = !songIsPaused;
    }
    if(FlxG.keys.justPressed.C){
        theStrs.cpu = !theStrs.cpu;
    }
    if(FlxG.keys.justPressed.TAB && FlxG.keys.pressed.SHIFT){
        camHUD.visible = !camHUD.visible;
        FlxG.save.data.hidingHUD = camHUD.visible;
        trace(player.cpu);

    }
}
function functionsthing(){
    if(songIsPaused){
        if(inst.paused == false) {
            inst.pause();
            vocals.pause();
            for (strumLine in strumLines.members) strumLine.vocals.pause();
        }
    } else {
        if(inst.paused){
            inst.resume();
            vocals.resume();
            
            for (strumLine in strumLines.members){
                strumLine.vocals.resume(); strumLine.vocals.pitch = FlxG.save.data.curPitch; 
            }
        }
            inst.pitch = FlxG.save.data.curPitch;
            vocals.pitch = FlxG.save.data.curPitch;
    }
}