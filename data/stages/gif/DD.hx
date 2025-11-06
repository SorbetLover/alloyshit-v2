function postCreate(){
	camGame.followLerp = 0.6;
	iconP1.visible = false;
	iconP2.visible = false;

	iconP2.setIcon("duos/mng", true);
}

function onNoteHit(e){
	if(e.noteType != null){
		e.preventAnim();
		switch(e.noteType){
			case "mnk":
				strumLines.members[0].characters[1].playSingAnim(e.direction);
			case "gif":
				strumLines.members[0].characters[0].playSingAnim(e.direction);
				
		}
	}
}