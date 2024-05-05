extends Node

var playerReference;
var dayNightCycleReference;
var isAutoCollectTechPointsEnabled : bool = false;

func _ready():
	var playerNodes = get_tree().get_nodes_in_group("Player");
	if playerNodes.size() > 0:
		playerReference = playerNodes[0];

	var dayNightCycleNodes = get_tree().get_nodes_in_group("DayNightCycle");
	if dayNightCycleNodes.size() > 0:
		dayNightCycleReference = dayNightCycleNodes[0];
