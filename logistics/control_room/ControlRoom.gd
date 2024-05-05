extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceManager.initialize();
	TechnologyManager.initialize();
	AutoGatherer.initialize();
	GameReferenceManager.initialize();
	EfficiencySkillMediator.initialize();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
