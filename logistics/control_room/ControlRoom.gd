extends Node2D

func _ready():
	ResourceManager.initialize();
	TechnologyManager.initialize();
	AutoGatherer.initialize();
	GameReferenceManager.initialize();
	EfficiencySkillMediator.initialize();
	MusicPlayer.playLogisticsMusic();

