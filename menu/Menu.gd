extends Node2D

func _ready():
	MusicPlayer.playMenuMusic();

func _on_play_button_pressed():
	SceneChangeManager.goToCutsceneOne();
