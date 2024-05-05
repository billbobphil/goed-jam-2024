extends Node2D

@onready var label : Label = $Label;

func _ready():
	updateTechnologyPoints(TechnologyManager.techPointsInInventory);

func updateTechnologyPoints(newValue):
	if label != null:
		label.text = str(newValue);
