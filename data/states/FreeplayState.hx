var shittext:FlxText;
var ptmode = false;
function postCreate(){

    if(FlxG.save.data.letocinhaMode){
            var shit = new FunkinSprite().makeSolid(400,130,0x88000000);
            add(shit);
            shit.x = FlxG.width - shit.width;
            shit.y = FlxG.height - shit.height;

            shittext = new FlxText(100,100,500, "BPM: 250\nDIFF: MEDIUM-EASY", 20);
            shittext.font = Paths.font("vcr.ttf");
            shittext.setPosition(shit.x + 10,shit.y + 10);
            add(shittext);
            updatetext(curSelected);
    }
    // for(i in 0...songs.length){
    //     songs[i].opponentModeAllowed = true; 
    //     songs[i].coopAllowed = true; 
    // }
}
function onChangeSelection(e){
    if(FlxG.save.data.letocinhaMode){
        updatetext(e.value);
    }
}
function updatetext(val:Int) {
    var song = songs[val];
    var custom = song.customValues;

    var thelength = custom.duration != null ? custom.duration : "TBA";
    var translateddiff = custom.diff;
    var translatedmech = custom.mechanics != null ? custom.mechanics : "nenhuma";

    if (ptmode) {
        switch (custom.diff) {
            case "EASY-EASY":       translateddiff = "FÁCIL-SÉRIO";
            case "EASY-NORMAL":     translateddiff = "FÁCIL-NORMAL";
            case "EASY-HARD":       translateddiff = "FÁCIL-DIFÍCIL";

            case "MEDIUM-EASY":     translateddiff = "MÉDIO-FÁCIL";
            case "MEDIUM-NORMAL":   translateddiff = "MÉDIO-NORMAL";
            case "MEDIUM-HARD":     translateddiff = "MÉDIO-DIFÍCIL";

            case "HARD-EASY":       translateddiff = "DIFÍCIL-FÁCIL";
            case "HARD-NORMAL":     translateddiff = "DIFÍCIL-NORMAL";
            case "HARD-HARD":       translateddiff = "DIFÍCIL-MESMO";

            case "NOT FOR YOU":     translateddiff = "Masoquismo";
            default:
        }

        if (custom.mechanics == "none")
            translatedmech = "nenhuma";

        shittext.text = 
            "BPM: " + song.bpm + "\n" +
            "DIFICULDADE: " + translateddiff + "\n" +
            "MECÂNICAS: " + translatedmech + "\n" +
            "DURAÇÃO: " + thelength;
    } else {
        shittext.text = 
            "BPM: " + song.bpm + "\n" +
            "DIFF: " + custom.diff + "\n" +
            "MECHANICS: " + custom.mechanics + "\n" +
            "LENGTH: " + thelength;
    }
}

function update(){
    if(FlxG.keys.justPressed.P){
        ptmode = !ptmode;
        updatetext(curSelected);
    }
}