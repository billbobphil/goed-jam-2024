extends Game

@export var speed : float = 100;
@export var windows : Array[Vector2];
var currentWindow : Vector2;
@onready var progressBar = $FillBar;
@onready var minBar = $MinBar;
@onready var maxBar = $MaxBar;
@onready var scored : Label = $Scored;
var canPress : bool = true;

signal fuel_gained

func _ready():
	visible = false;
	resetGame();

func resetGame():
	var currentPick = windows.pick_random();

	while(currentPick == currentWindow):
		currentPick = windows.pick_random();

	currentWindow = currentPick;
	minBar.value = currentWindow.x;
	maxBar.value = currentWindow.y;
	progressBar.value = 0;
	canPress = true;

func _process(delta):
	if !isGameActive:
		return;

	if Input.is_action_just_released("logistics-fuel-increase"):
		canPress = false;
		processButtonRelease();

	if Input.is_action_pressed("logistics-fuel-increase") && canPress:
		progressBar.value += speed * delta;

func processButtonRelease():
	if(progressBar.value > currentWindow.x && progressBar.value < currentWindow.y):
		fuel_gained.emit(1);
		SoundEffectAccess.soundEffects.resourceGet.play();
		scored.visible = true;
		resetGame();
		await get_tree().create_timer(.75).timeout;
		scored.visible = false;
	else:
		resetGame();
		

func enableGame():
	isGameActive = true;
	visible = true;
	resetGame();

func disableGame():
	scored.visible = false;
	isGameActive = false;
	visible = false;

func _on_button_pressed():
	SoundEffectAccess.soundEffects.computerOff.play();
	isGameActive = false;
	visible = false;
	if interactable:
		interactable.reenableInteraction();
