extends Node2D

class_name CutscenePlayer

enum FollowUpScene {
	Platformer,
	Logistics
}

@export var scenes : Array[PackedScene] = []
var activeSceneIndex = 0;
var activeScene = null;
var canAdvanceScene : bool = true;
@export var followUpScene : FollowUpScene = FollowUpScene.Platformer;

func _ready():
	var createdScene = scenes[activeSceneIndex].instantiate();
	add_child(createdScene);
	activeScene = createdScene;

func _process(_delta):
	if Input.is_action_just_pressed("cutscene_advance") && canAdvanceScene:
		activeSceneIndex += 1;
		if activeSceneIndex >= scenes.size():
			goToFollowUpScene();
			return;
		
		nextScene();

func nextScene():
	canAdvanceScene = false;
	var animationPlayer = activeScene.get_node("AnimationPlayer");
	animationPlayer.play("fade_out");
	await animationPlayer.animation_finished;
	var newScene = scenes[activeSceneIndex].instantiate();
	add_child(newScene);
	activeScene.queue_free();
	activeScene = newScene;
	canAdvanceScene = true;

func goToFollowUpScene():
	if followUpScene == FollowUpScene.Platformer:
		SceneChangeManager.goToPlatformer();
	elif followUpScene == FollowUpScene.Logistics:
		SceneChangeManager.goToLogistics();