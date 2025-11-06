//
import funkin.game.HudCamera;
import funkin.backend.scripting.events.NoteHitEvent;

public var pixelNotesForBF = true;
public var pixelNotesForDad = true;
public var pixelSplashes = true;
public var enablePixelUI = true;
public var enablePixelGameOver = true;
public var enableCameraHacks = false;
public var enablePauseMenu = false;
public var isSpooky = false;

var oldStageQuality = FlxG.game.stage.quality;
public var daPixelZoom = PlayState.daPixelZoom;

/**
 * UI
 */
function onNoteCreation(event) {
	if ((event.note.strumLine == playerStrums && !pixelNotesForBF) || (event.note.strumLine == cpuStrums && !pixelNotesForDad)) return;
	event.cancel();

	var note = event.note;
	var strumID = event.strumID;
	if (event.note.isSustainNote) {
		note.loadGraphic(Paths.image('modassets/gif/pixel/NOTE_assetsENDS'), true, 7, 6);
		var maxCol = Math.floor(note.graphic.width / 7);
		note.animation.add("hold", [strumID%maxCol]);
		note.animation.add("holdend", [maxCol + strumID%maxCol]);
	} else {
		note.loadGraphic(Paths.image('modassets/gif/pixel/NOTE_assets'), true, 17, 17);
		var maxCol = Math.floor(note.graphic.width / 17);
		note.animation.add("scroll", [maxCol + strumID%maxCol]);
	}
	var strumScale = event.note.strumLine.strumScale;
	note.scale.set(daPixelZoom*strumScale, daPixelZoom*strumScale);
	note.updateHitbox();
	note.antialiasing = false;
}

function onPostNoteCreation(event) if (pixelSplashes)
	event.note.splash = "pixel-default";

function onStrumCreation(event) {
	if ((event.player == 1 && !pixelNotesForBF) || (event.player == 0 && !pixelNotesForDad)) return;
	event.cancel();

	var strum = event.strum;
	strum.loadGraphic(Paths.image('modassets/gif/pixel/NOTE_assets'), true, 17, 17);
	var maxCol = Math.floor(strum.graphic.width / 17);
	var strumID = event.strumID % maxCol;

	strum.animation.add("static", [strumID]);
	strum.animation.add("pressed", [maxCol + strumID, (maxCol*2) + strumID], 12, false);
	strum.animation.add("confirm", [(maxCol*3) + strumID, (maxCol*4) + strumID], 24, false);

	var strumScale = strumLines.members[event.player].strumScale;
	strum.scale.set(daPixelZoom*strumScale, daPixelZoom*strumScale);
	strum.updateHitbox();
	strum.antialiasing = false;
}
var ddddddd = 3;
function onCountdown(event) {
	if (!enablePixelUI) return;

	if (event.soundPath != null) event.soundPath = "gif/countdown_giffany_" + ddddddd;
	event.antialiasing = false;
	event.scale = 1;
	event.spritePath = switch(event.swagCounter) {
		case 2: 'modassets/gif/countdown/countdownimg_broken_1';
		case 1: 'modassets/gif/countdown/countdownimg_broken_2';
		case 0: 'modassets/gif/countdown/countdownimg_broken_3';
		case 3: 'modassets/gif/countdown/countdownimg_gif_0b';
	};
	ddddddd -=1;
}

function onPlayerHit(event:NoteHitEvent) {
	if (!enablePixelUI) return;
	event.ratingPrefix = "stages/school/ui/";
	event.ratingScale = daPixelZoom * 0.7;
	event.ratingAntialiasing = false;

	event.numScale = daPixelZoom;
	event.numAntialiasing = false;
}

/**
 * CAMERA HACKS!!
 */
function postCreate() {
	if (enablePauseMenu)
		PauseSubState.script = 'data/scripts/week6-pause';

	if (enablePixelGameOver) {
		gameOverSong = "pixel/gameOver";
		lossSFX = "pixel/gameOverSFX";
		retrySFX = "pixel/gameOverEnd";
	}
}


function destroy() {
	// resets the stage quality
	FlxG.game.stage.quality = oldStageQuality;
}