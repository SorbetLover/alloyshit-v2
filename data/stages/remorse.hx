var thepossx = [];
var thepossy = [];
function postCreate(){
	for(i in strumLines.members[2].characters){
		i.visible = false;
		i.x += 2000;
	}
	for(i in [0,1]){
		strumLines.members[i].characters[1].alpha = 0.00001;
	}
	for(i in 0...3){
		thepossx.push(strumLines.members[0].members[i].x);
	}
	for(i in 0...3){
		thepossy.push(strumLines.members[0].members[i].y);
	}
	for(i in 0...3){
		thepossx.push(strumLines.members[1].members[i].x);
	}
	for(i in 0...3){
		thepossy.push(strumLines.members[1].members[i].y);
	}
	
	
	intercom.animation.stop();
	intercom2.animation.stop();

	dad.x -= 200;
	dad.scale.set(1,1);
	// camGame.followLerp = 0.01;
}
var firstlerp = true;
function onCameraMove(e){
	e.cancel();
}
function postUpdate(elapsed){
	if(curCameraTarget == 0){
		camFollow.setPosition(300,300);		
	} else {
		camFollow.setPosition(700,300);		

	}

	if(firstlerp){
		for(i in 0...3){
			strumLines.members[0].members[i].x = FlxMath.lerp(strumLines.members[0].members[i].x, thepossx[i], 0.05*elapsed);
			strumLines.members[1].members[i].x = FlxMath.lerp(strumLines.members[1].members[i].x, thepossx[i+3], 0.05*elapsed);
		}
	}
}
var cu2:Bool = false;
function onNoteHit(e){
	if(e.character.curCharacter == "disablethis"){
		trace(e.direction);
		switch(e.direction){
			case 0:
				strumBeat();
			case 1:
				goup = !goup;
			case 2:
				speedBeat();
				skew.zpos += cu2 ? 0.2 : -0.05;
				skew.xpos += cu2 ? 0.2 : -0.2;
				cu2 = !cu2;
		}
	}
}

function strumBeat(){
	strumLines.members[0].members[0].x -= 10; 
	strumLines.members[0].members[1].x -= 10; 

	strumLines.members[0].members[2].x += 10; 
	strumLines.members[0].members[3].x += 10; 

	strumLines.members[1].members[0].x -= 10; 
	strumLines.members[1].members[1].x -= 10; 

	strumLines.members[1].members[2].x += 10; 
	strumLines.members[1].members[3].x += 10; 

}