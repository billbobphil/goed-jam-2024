extends Node

var foodGame;
var entertainmentGame;
var buildingGame;
var fuelGame;

func initialize():
	var foodGameNodes = get_tree().get_nodes_in_group("FoodGame");
	if foodGameNodes.size() > 0:
		foodGame = foodGameNodes[0];

	var entertainmentGameNodes = get_tree().get_nodes_in_group("EntertainmentGame");
	if entertainmentGameNodes.size() > 0:
		entertainmentGame = entertainmentGameNodes[0];

	var buildingGameNodes = get_tree().get_nodes_in_group("BuildingGame");
	if buildingGameNodes.size() > 0:
		buildingGame = buildingGameNodes[0];

	var fuelGameNodes = get_tree().get_nodes_in_group("FuelGame");
	if fuelGameNodes.size() > 0:
		fuelGame = fuelGameNodes[0];