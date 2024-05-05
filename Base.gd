extends Node2D

@export var menuScene : PackedScene;
@export var cutSceneOne : PackedScene;
@export var platformer : PackedScene;
@export var cutSceneTwo : PackedScene;
@export var logistics : PackedScene;
@export var end : PackedScene;
var activeScene = null;

func _ready():
	var newScene = menuScene.instantiate();
	activeScene = newScene;
	add_child(newScene);

func changeToMenuScene():
	changeToNewScene(menuScene);

func changeToCutSceneOne():
	changeToNewScene(cutSceneOne);

func changeToPlatformer():
	changeToNewScene(platformer);

func changeToCutSceneTwo():
	changeToNewScene(cutSceneTwo);

func changeToLogistics():
	changeToNewScene(logistics);

func changeToEnd():
	changeToNewScene(end);

func changeToNewScene(scene):
	var newScene = scene.instantiate();
	activeScene.queue_free();
	activeScene = newScene;
	add_child(newScene);
	
