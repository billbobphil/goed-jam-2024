extends Node

var musicPlayer : AudioStreamPlayer;
var menuTrackFile : String = "res://music/Ambient 1.wav";
var cutsceneTrackFile : String = "res://music/Ambient 8.wav";
var platformerTrackFile : String = "res://music/Ambient 9.wav";
var logisticsTrackFile : String = "res://music/Ambient 4.wav";

func _ready():
	musicPlayer = get_tree().root.get_node("Base/MusicPlayer");
	if musicPlayer != null:
		musicPlayer.stream = load(menuTrackFile);
		musicPlayer.play();

func playMenuMusic():
	if musicPlayer != null:
		musicPlayer.stream = load(menuTrackFile);
		musicPlayer.play();

func playCutsceneMusic():
	if musicPlayer != null:
		musicPlayer.stream = load(cutsceneTrackFile);
		musicPlayer.play();

func playPlatformerMusic():
	if musicPlayer != null:
		musicPlayer.stream = load(platformerTrackFile);
		musicPlayer.play();

func playLogisticsMusic():
	if musicPlayer != null:
		musicPlayer.stream = load(logisticsTrackFile);
		musicPlayer.play();

