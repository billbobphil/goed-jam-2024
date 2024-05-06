extends Node2D

@onready var canvas : CanvasLayer = $CanvasLayer;
@onready var interactable : Interactable = $Interactable;

func _ready():
	canvas.hide();

func _on_button_pressed():
	SoundEffectAccess.soundEffects.computerOff.play();
	canvas.hide();
	interactable.reenableInteraction();

func _on_interactable_player_exited_interactable():
	if canvas.visible:
		SoundEffectAccess.soundEffects.computerOff.play();
	canvas.hide();

func _on_interactable_player_interacted():
	SoundEffectAccess.soundEffects.computerOn.play();
	canvas.show();
