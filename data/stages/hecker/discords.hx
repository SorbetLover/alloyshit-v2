var speakshit = [];
function postCreate(){
	comboGroup.x += 2000;
	
	if(PlayState.difficulty == "raluca"){

		boyfriend.fixChar(true,true);
		var off = 130;
		dad.x += off;
		boyfriend.x -= off;
	 	for(i in [dad, boyfriend]){

				var circle = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/round"));
				circle.x = i.x - 5;
				circle.y = i.y - 5;
				add(circle);
				
				var speak = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/speak"));
				speak.x = circle.x;
				speak.y = circle.y;
				add(speak);
				speakshit.push(speak);
		}
	} else {
		boyfriend.y = dad.y - boyfriend.height;
		dad.y -= 50;
		boyfriend.x -= 160;
		dad.x += 30;
	}
}

function postUpdate(){
	camFollow.y = 300;
	if(PlayState.difficulty == "raluca"){
		speakshit[0].visible = (dad.animation.curAnim.name != "idle") ? true : false;
		speakshit[1].visible = (boyfriend.animation.curAnim.name != "idle") ? true : false;
	}
}
