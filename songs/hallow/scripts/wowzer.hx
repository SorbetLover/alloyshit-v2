var preloadthing:FlxSprite;
function postCreate(){
    preloadthing = new FunkinSprite();
    preloadthing.frames = Paths.getFrames("modassets/fever/paintingShit");
    add(preloadthing);
    preloadthing.alpha = 0.001;
}
function onNoteHit(e){
    if(e.noteType == "painting" && e.player){
        e.animCancelled = true;
        boyfriend.playAnim("fever dodge");
    }
}
function onNoteCreation(e){
    if(e.noteType == "painting"){
        e.noteSprite = "modassets/fever/notes/hallowNotes";
        e.note.extra.set("animPlayed", false);
    }
}
function update(elapsed){
    strumLines.members[1].notes.forEachAlive(function(note:Note){
        if(note.extra.get("animPlayed") == false && note.strumRelativePos <= 950 * PlayState.instance.inst.pitch && note.noteType == "painting"){
            new FlxTimer().start(0.8, function(asd:FlxTimer){spawnfuck();});
            note.extra.set("animPlayed", true);
        }
    });
}
function onPlayerMiss(e){
    if(e.noteType == "painting"){
        health = 0;
    }
}
function spawnfuck(){
    trace("cu");
    var fuck = new FunkinSprite();
    fuck.frames = Paths.getFrames("modassets/fever/paintingShit");
    add(fuck);
    fuck.x = boyfriend.x - 50;
    // fuck.y += 200;
    fuck.y += 100;
    fuck.animation.addByPrefix("paintingShit", "paintingShit", 30, false);
    fuck.playAnim("paintingShit");

    new FlxTimer().start(2, function(h:FlxTimer){
        fuck.destroy();
    });
}
