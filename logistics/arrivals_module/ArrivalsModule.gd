extends Node2D

@onready var canvas : CanvasLayer = $CanvasLayer;
@onready var interactable : Interactable = $Interactable;
@onready var populationValue : Label = $CanvasLayer/PopulationValue;
@onready var populationGoal : Label = $CanvasLayer/PopulationGoal;
@onready var techPointsValue : Label = $CanvasLayer/TechPointsValue;

func _ready():
	canvas.hide();
	populationGoal.text = str(PopulationManager.populationVictoryThreshold);

func _on_interactable_player_interacted():
	SoundEffectAccess.soundEffects.computerOn.play();
	canvas.show();
	populationValue.text = str(PopulationManager.currentPopulation);
	techPointsValue.text = str(TechnologyManager.techPointsAvailableToCollect);

func _on_interactable_player_exited_interactable():
	if canvas.visible:
		SoundEffectAccess.soundEffects.computerOff.play();
	canvas.hide();

func _on_exit_button_pressed():
	SoundEffectAccess.soundEffects.computerOff.play();
	canvas.hide();
	interactable.reenableInteraction();

func _on_tech_points_collect_button_pressed():
	TechnologyManager.collectAvailableTechPoints();
	techPointsValue.text = str(TechnologyManager.techPointsAvailableToCollect);
