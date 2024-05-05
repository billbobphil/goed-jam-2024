extends Node2D


@onready var buildPrompt : Node2D = $BuildPrompt;
@onready var notEnoughMaterialsPrompt : Node2D = $NotEnoughMaterialsPrompt;

func _ready():
	buildPrompt.hide();
	notEnoughMaterialsPrompt.hide();

func _process(_delta):
	if buildPrompt.visible && Input.is_action_just_pressed("platformer-interact"):
		goToNextScene();

func _on_area_2d_body_entered(body:Node2D):
	if body is PlayerPlatformer:
		if(body.numberOfCollectibles >= 7):
			buildPrompt.show();
		else:
			notEnoughMaterialsPrompt.show();

func _on_area_2d_body_exited(body:Node2D):
	if body is PlayerPlatformer:
		buildPrompt.hide();
		notEnoughMaterialsPrompt.hide();


func goToNextScene():
	SceneChangeManager.goToCutsceneTwo();