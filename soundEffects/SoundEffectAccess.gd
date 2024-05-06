extends Node

var soundEffects;

func _ready():
	soundEffects = get_tree().root.get_node("Base/SoundEffects");
