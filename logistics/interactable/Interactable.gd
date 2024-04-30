extends Area2D

class_name Interactable

signal player_entered_interactable
signal player_exited_interactable
signal player_interacted

var playerCanInteract : bool = false;

@onready var interactKeySprite : Sprite2D = $InteractKeySprite

func _ready():
	interactKeySprite.visible = false

func _process(_delta):
	if playerCanInteract:
		if Input.is_action_just_pressed("logistics-interact"):
			print("player interacted");
			player_interacted.emit();
			playerCanInteract = false;

func reenableInteraction():
	playerCanInteract = true;

func _on_body_entered(body:Node2D):
	if body is PlayerLogistics:
		playerCanInteract = true;
		interactKeySprite.visible = true;
		player_entered_interactable.emit();

func _on_body_exited(body:Node2D):
	if body is PlayerLogistics:
		playerCanInteract = false;
		interactKeySprite.visible = false;
		player_exited_interactable.emit();
