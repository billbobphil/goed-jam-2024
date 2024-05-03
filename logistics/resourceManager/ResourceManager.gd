extends Node

@export var foodAndWater : int = 0;
@export var buildingMaterials : int = 0;
@export var technologyMaterials : int = 0;
@export var entertainmentMaterials : int = 0;
@export var fuelMaterials : int = 0;

func _ready():
	var fuelGameNodes = get_tree().get_nodes_in_group("FuelGame");
	for fuelGameNode in fuelGameNodes:
		fuelGameNode.fuel_gained.connect(gainFuel);

	var buildingGameNodes = get_tree().get_nodes_in_group("BuildingGame");
	for buildingGameNode in buildingGameNodes:
		buildingGameNode.building_gained.connect(gainBuilding);

	var entertainmentGameNodes = get_tree().get_nodes_in_group("EntertainmentGame");
	for entertainmentGameNode in entertainmentGameNodes:
		entertainmentGameNode.entertainment_gained.connect(gainEntertainment);

	var foodGameNodes = get_tree().get_nodes_in_group("FoodGame");
	for foodGameNode in foodGameNodes:
		foodGameNode.food_gained.connect(foodGained);

func extractPopulationMaterials(foodAndWaterAmount, buildingMaterialsAmount, entertainmentMaterialsAmount, fuelMaterialsAmount):
	foodAndWater -= foodAndWaterAmount
	buildingMaterials -= buildingMaterialsAmount
	entertainmentMaterials -= entertainmentMaterialsAmount
	fuelMaterials -= fuelMaterialsAmount

func extractTechnologyMaterials(technologyMaterialsAmount):
	technologyMaterials -= technologyMaterialsAmount

func gainFuel(fuelAmount):
	fuelMaterials += fuelAmount

func gainBuilding(buildingAmount):
	buildingMaterials += buildingAmount

func gainEntertainment(entertainmentAmount):
	entertainmentMaterials += entertainmentAmount

func foodGained(foodAmount):
	foodAndWater += foodAmount;
