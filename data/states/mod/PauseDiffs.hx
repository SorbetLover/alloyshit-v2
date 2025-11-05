import flixel.input.touch.FlxTouch;

var uhhhCam:FlxCamera;
var things:Array = [];
var curSelected = 0;
var grou:FlxSpriteGroup = [];
var btn1:FlxSprite;
var btn2:FlxSprite;
var btn3:FlxSprite;
function create(){
        uhhhCam = new FlxCamera();
        FlxG.cameras.add(uhhhCam, false);
		uhhhCam.bgColor = 0xDD000000;
        trace(PlayState.instance.curSong);
        for (file in Paths.getFolderContent('songs/' + PlayState.instance.curSong + "/charts")){
            if (StringTools.endsWith(file, '.json')){
                var cleanFile = StringTools.replace(file, '.json', ''); 
                things.push(cleanFile);
                
            }
        }
        trace(things);
        grou = new FlxSpriteGroup();
        add(grou);

        for(i in 0...things.length){
            var sss = new Alphabet(200, i * 100, things[i], true, false);
            // insert(sss, 20);

            grou.add(sss);
            add(sss);
            sss.cameras = [uhhhCam];
        }
    
    #if mobile 

    btn1 = new FlxSprite(1100,600).makeGraphic(100,100,0xFF555555);
    add(btn1);
    btn2 = new FlxSprite(1100,450).makeGraphic(100,100,0xFF555555);
    add(btn2);

    btn3 = new FlxSprite(950, 600).makeGraphic(100,100, 0xFF559955);
    add(btn3);
    
    for(rr in [btn1, btn2, btn3]) rr.cameras = [uhhhCam];
    #end
    
}

var sametime:Bool = false;
function update(){
    grou.y = FlxG.height / 4 - (curSelected * 100) + 140;
    if(things[curSelected] != null){
        
        for(ee in 0...grou.length){ grou.members[ee].color = 0xFF555555; }
        grou.members[curSelected].color = 0xFFFFFFFF;
    }
    if(FlxG.keys.justPressed.W && curSelected != 0) curSelected -= 1;
    if(FlxG.keys.justPressed.S && curSelected != things.length - 1) curSelected += 1;
    if(FlxG.keys.justPressed.ESCAPE) {uhhhCam.bgColor = 0x00000000; close(); } 

    if(FlxG.keys.justPressed.ENTER){
        goin();
    }

    
#if mobile
        for (touch in FlxG.touches.list)
        {
            if (touch.justPressed) // ou touch.pressed se quiser enquanto segura
            {
                var pos = touch.getWorldPosition(uhhhCam); // usa a camera correta

                if (btn1.overlapsPoint(pos))
                {
                    curSelected += 1;
                }
                else if (btn2.overlapsPoint(pos))
                {
                    curSelected -= 1;
                }
                else if (btn3.overlapsPoint(pos))
                {
                    goin();
                }
            }
        }
#end
    
}

function goin(){
    PlayState.loadSong(PlayState.instance.curSong, things[curSelected], PlayState.instance.opponentMode, PlayState.instance.coopMode);
		FlxG.switchState(new PlayState());    
}