var speakshit = [];
var diggo:FunkinSprite;
var diggospeak:FunkinSprite;
var diggoround:FunkinSprite;
var circs = [];
var ogx = [];
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
				circs.push(circle);
				var speak = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/speak"));
				speak.x = circle.x;
				speak.y = circle.y;
				add(speak);
				speakshit.push(speak);
		}
		ogx.push(dad.x);
		ogx.push(boyfriend.x);
		diggo = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/diggos"));
		// diggospeak = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/speak"));
		// diggoround = new FunkinSprite().loadGraphic(Paths.image("stages/hecker/discord/round"));
		add(diggo);
		// add(diggoround);
		// add(diggospeak);

		// diggo.screenCenter();
		// diggospeak.screenCenter();
		// diggoround.screenCenter();

		diggo.x = (boyfriend.x - dad.x) + 27;
		diggo.scale.set(0.01,0.01);
		diggo.alpha = 0.0001;
		diggo.y = dad.y; 
	} else {
		boyfriend.y = dad.y - boyfriend.height;
		dad.y -= 50;
		boyfriend.x -= 160;
		dad.x += 30;
	}
}
var diggoin = false;
var diggot = false;
var join:FlxSound = FlxG.sound.load(Paths.sound("discjoin"));
var leave:FlxSound = FlxG.sound.load(Paths.sound("discleave"));
function diggoshite(es){
	var e:Bool = (es == "true") ? true : false;
	// join.play(true);
	join.volume = 0.75;
	leave.volume = 0.75;
	diggot = e;
	if(e == true){
		join.play(true);
	} else {
		leave.play(true);
	}
	new FlxTimer().start(0.25, function(tmr:FlxTimer){
		diggoin = e;
		if(e == true){
			FlxTween.cancelTweensOf(diggo);
			FlxTween.tween(diggo.scale, {x: 1, y:1}, 0.5 * inst.pitch, {ease:FlxEase.elasticOut});
			diggo.alpha = 1;
		} else {
			FlxTween.cancelTweensOf(diggo);
			FlxTween.tween(diggo.scale, {x: 0.05, y:0.05}, 0.15 * inst.pitch, {ease:FlxEase.linear});
			FlxTween.tween(diggo, {alpha:0}, 0.15 * inst.pitch);
		}
	} );
}
var tsped = 15;
function onPlayerHit(e){
	if(!diggoin) e.healthGain = 0.02; else e.healthGain = 0.1;
}
function onDadHit(){
	if(!diggoin && health >= 0.1) health -= 0.025;
}
function postUpdate(elapsed){
	leave.pitch = inst.pitch;
	join.pitch = inst.pitch;
	// if(diggoin){
		// health += 0.02*elapsed;
	// }
	if(health <= 0.1 && diggot == false){
		diggoshite("true");
	} else if (diggot == true && health >= 0.5){
		diggoshite("false");
	}
	if(PlayState.difficulty == "raluca"){
		if(diggoin){
			dad.x = FlxMath.lerp(dad.x, ogx[0] - 150, tsped * elapsed);
			boyfriend.x = FlxMath.lerp(boyfriend.x, ogx[1] + 150, tsped * elapsed);
		} else {
			dad.x = FlxMath.lerp(dad.x, ogx[0], tsped * elapsed);
			boyfriend.x = FlxMath.lerp(boyfriend.x, ogx[1], tsped * elapsed);
		}
		circs[0].x = dad.x-5;
		circs[1].x = boyfriend.x-5;
		speakshit[0].x = dad.x-5;
		speakshit[1].x = boyfriend.x-5;
		// if(FlxG.keys.justPressed.F){
			// diggoshit(!diggoin);
		// }
	}
	camFollow.x = FlxMath.bound(camFollow.x,550,600);
	camFollow.y = 300;
	if(PlayState.difficulty == "raluca"){
		speakshit[0].visible = (dad.animation.curAnim.name != "idle") ? true : false;
		speakshit[1].visible = (boyfriend.animation.curAnim.name != "idle") ? true : false;
	}
}
