import flixel.addons.display.FlxBackdrop;
var backdrop:FlxBackdrop;
var nyansesii:FunkinSprite;
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
        nyansesii.scale.set(2,2);
        nyansesii.updateHitbox();
        nyansesii.y = FlxG.height - nyansesii.height;
        nyansesii.x = FlxG.width - nyansesii.width;
        add(nyansesii);
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
}
var fg = FlxG.keys.justPressed;
var fag = FlxG.keys.pressed;


function update(){
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