extends Game

@export var noteScene : PackedScene;
@onready var noteSpawnLocation : Node2D = $NoteSpawnLocation;
@onready var noteContainer : Node = $NoteContainer;
@onready var noteHitterSprite : Sprite2D = $NoteHitter/Sprite2D;
@onready var scored : Label = $Scored;
var notesWithinRange : Array = [];

@export var minimumTimeBetweenNotes : float = 3;
@export var maximumTimeBetweenNotes : float = 7;
var timeSinceLastNote : float = 0;
@export var numberOfNotesBeforeScore : int = 5;
@export var debounceTimeAfterAttempt : float = .75;
var numberOfNotesHit : int = 0;
var timeForThisNote : float = 0
var debounceTimer = 0;
var isDebounced = false;

signal food_gained

func _ready():
	resetGame();
	disableGame();

func _process(delta):
	if !isGameActive:
		return;

	if isDebounced:
		debounceTimer += delta;
		if debounceTimer >= debounceTimeAfterAttempt:
			isDebounced = false;
			debounceTimer = 0;
			noteHitterSprite.modulate = Color(1, 1, 1, 1);

	timeSinceLastNote += delta;
	if timeSinceLastNote >= timeForThisNote:
		spawnNote();
		timeSinceLastNote = 0;

	if Input.is_action_just_pressed("logistics-chop") && !isDebounced:
		if notesWithinRange.size() > 0:
			for note in notesWithinRange:
				note.get_node("Sprite2D").modulate = Color(0, 1, 0, 1);

			notesWithinRange.clear();
			numberOfNotesHit += 1;

			if numberOfNotesHit >= numberOfNotesBeforeScore:
				food_gained.emit(1);
				SoundEffectAccess.soundEffects.resourceGet.play();
				scored.visible = true;
				resetGame();
				await get_tree().create_timer(1).timeout;
				scored.visible = false;
		else:
			isDebounced = true;
			noteHitterSprite.modulate = Color(1, 0, 0, 1);

func enableGame():
	isGameActive = true;
	visible = true;
	resetGame();

func disableGame():
	scored.visible = false;
	isGameActive = false;
	visible = false;
	resetGame();

func resetGame():
	notesWithinRange.clear();
	var activeNotes = noteContainer.get_children();
	for note in activeNotes:
		note.queue_free();
	timeSinceLastNote = 0;
	numberOfNotesHit = 0;
	timeForThisNote = 0;
	debounceTimer = 0;
	isDebounced = false;
	
func getRandomNoteTime():
	timeForThisNote =  randf() * (maximumTimeBetweenNotes - minimumTimeBetweenNotes) + minimumTimeBetweenNotes;

func _on_exit_button_pressed():
	SoundEffectAccess.soundEffects.computerOff.play();
	disableGame();
	if interactable:
		interactable.reenableInteraction();

func spawnNote():
	var newNote = noteScene.instantiate();
	noteContainer.add_child(newNote);
	newNote.global_position = noteSpawnLocation.global_position;
	getRandomNoteTime();


func _on_area_2d_area_exited(area:Area2D):
	if area.get_parent().is_in_group("Note"):
		notesWithinRange.erase(area.get_parent());

func _on_area_2d_area_entered(area:Area2D):
	if area.get_parent().is_in_group("Note"):
		notesWithinRange.append(area.get_parent());

