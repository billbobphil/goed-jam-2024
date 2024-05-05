extends Node

var baseScene;

func _ready():
	var baseSceneNodes = get_tree().get_nodes_in_group("Base");
	if baseSceneNodes.size() > 0:
		baseScene = baseSceneNodes[0];

func goToMenuScene():
	baseScene.changeToMenuScene();

func goToCutsceneOne():
	baseScene.changeToCutSceneOne();

func goToPlatformer():
	baseScene.changeToPlatformer();

func goToCutsceneTwo():
	baseScene.changeToCutSceneTwo();

func goToLogistics():
	baseScene.changeToLogistics();

func goToEnd():
	baseScene.changeToEnd();
