function postCreate(){
		var cu = new FunkinSprite().makeSolid(bg.width, 200,0xFF000000);
		cu.setPosition(bg.x,bg.y - 20);
		add(cu);

		var cu = new FunkinSprite().makeSolid(bg.width, 200,0xFF000000);
		cu.setPosition(bg.x,bg.y + bg.height - 180);
		add(cu);

		iconP2.setIcon("duos/ayw", false);

		comboGroup.x = 10000;

}
var cursingchar = false;
function setsingchar(){
	cursingchar = !cursingchar;
}
function onNoteHit(e){
	if(e.note.strumLine.opponentSide){
		// trace(cursingchar ? "Wrench" : "Aiden", e.note.strumLine.opponentSide);
		e.preventAnim();
		switch(cursingchar){
			case false:
				strumLines.members[0].characters[0].playSingAnim(e.direction);
			case true:
				strumLines.members[0].characters[1].playSingAnim(e.direction);

		}	
	}
}