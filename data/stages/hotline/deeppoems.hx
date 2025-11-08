function postCreate(){

		var defx = -200;
		var cu = new FunkinSprite().makeSolid(bg.width, 200,0xFF000000);
		cu.setPosition(defx,bg.y + 40);
		add(cu);

		cu.scrollFactor.set(0,0);
		var cu = new FunkinSprite().makeSolid(bg.width, 200,0xFF000000);
		cu.setPosition(defx,bg.y + bg.height - 120);
		add(cu);
		cu.scrollFactor.set(0,0);

		switch(strumLines.members[0].characters[0])
		{
			case "sorb/aiden":
				iconP2.setIcon("duos/ayw", false);
			default:
		}

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