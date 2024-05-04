extends Node2D

@onready var canvas : CanvasLayer = $CanvasLayer;
@onready var interactable : Interactable = $Interactable;

func _ready():
	canvas.hide();

func _on_button_pressed():
	canvas.hide();
	interactable.reenableInteraction();

func _on_interactable_player_exited_interactable():
	canvas.hide();

func _on_interactable_player_interacted():
	print('interacted');
	canvas.show();
