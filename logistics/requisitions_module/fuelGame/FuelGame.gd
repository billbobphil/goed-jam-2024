extends Game

@export var speed : float = 100;
@export var windows : Array[Vector2];
var currentWindow : Vector2;
@onready var progressBar = $FillBar;
@onready var minBar = $MinBar;
@onready var maxBar = $MaxBar;
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
		
	resetGame();

func enableGame():
	isGameActive = true;
	visible = true;
	resetGame();

func disableGame():
	isGameActive = false;
	visible = false;

func _on_button_pressed():
	isGameActive = false;
	visible = false;
	if interactable:
		interactable.reenableInteraction();
