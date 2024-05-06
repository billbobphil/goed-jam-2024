extends Node2D

func _ready():
	MusicPlayer.playMenuMusic();

func _on_menu_button_pressed():
	SceneChangeManager.goToMenuScene();
