var iconP1A:HealthIcon;
var iconP2A:HealthIcon;
var defScales = [1,1];
var ticons = [];

function postCreate(){
    var eh = -1;
    for(i in [iconP1, iconP2]) { eh++; i.visible = false; if(StringTools.startsWith(i.curCharacter, "sorb/")) defScales[eh] = 0.7;}
    
    iconP1A = new HealthIcon(iconP1.curCharacter, iconP1.isPlayer);
    iconP2A = new HealthIcon(iconP2.curCharacter, iconP2.isPlayer);

    iconP2A.x = healthBar.x - 150;
    iconP1A.x = healthBar.x + (healthBar.width);

    eh = -1;
    for(i in [iconP1A, iconP2A]) { ticons.push(i); eh++; add(i); i.y = healthBar.y - 75; i.cameras = [camHUD]; i.scale.set(defScales[eh], defScales[eh]); }
}
function beatHit(curBeat){
    for(i in [0,1]) ticons[i].scale.set(defScales[i] + 0.1, defScales[i] + 0.1);
}
function postUpdate(){
    ticons[0].scale.x = FlxMath.lerp(ticons[1].scale.x, defScales[1], 0.1);
    ticons[0].scale.y = ticons[1].scale.x;
    
    ticons[1].scale.x = FlxMath.lerp(ticons[1].scale.x, defScales[1], 0.1);
    ticons[1].scale.y = ticons[1].scale.x;
 
    iconP1A.animation.curAnim.curFrame = iconP1.animation.curAnim.curFrame;
    iconP2A.animation.curAnim.curFrame = iconP2.animation.curAnim.curFrame;
}