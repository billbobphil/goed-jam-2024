extends Node2D

@onready var fuelGame = $Games/FuelGame;
@onready var buildingGame = $Games/BuildingGame;
@onready var gameSelectionCanvas = $CanvasLayer;
var activeGame = null;
@onready var interactable : Interactable = $Interactable;

func _on_interactable_player_interacted():
	gameSelectionCanvas.visible = true;

func _on_interactable_player_exited_interactable():
	if activeGame != null:
		activeGame.disableGame();
	gameSelectionCanvas.visible = false;
	activeGame = null;
	
func _on_fuel_button_pressed():
	if activeGame == null:
		fuelGame.enableGame();
		activeGame = fuelGame;
		gameSelectionCanvas.visible = false;

func _on_exit_button_pressed():
	if activeGame == null:
		gameSelectionCanvas.visible = false;
		interactable.reenableInteraction();


func _on_building_button_pressed():
	if activeGame == null:
		buildingGame.enableGame();
		activeGame = buildingGame;
		gameSelectionCanvas.visible = false;
