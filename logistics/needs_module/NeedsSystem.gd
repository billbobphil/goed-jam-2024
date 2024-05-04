extends Node2D

@export_group("Food Needs")
var foodAndWaterRequirement = 0; #linear -> need X food per population and the demand is always population * food per person
@export var foodPerPopulation : int = 2;

@export_group("Building Needs")
var buildingMaterialsRequirement = 0; #constant with slight fluctuation -> always require X +- fluctuation regardless of population
@export var buildingMaterialsNeededMinimum = 2;
@export var buildingMaterialsNeededMaximum = 4;

@export_group("Entertainment Needs")
var entertainmentRequirement = 0; #linear but with set increases -> need X entertainment per population, with X changing at set population thresholds
var entertainmentPerPopulation : int = 0;
@export var entertainmentStageOneIncreaseAtPopulation : int = 8;
@export var entertainmentStageOnePerPopulationRequirement : int = 1;
@export var entertainmentStageTwoIncreaseAtPopulation : int = 16;
@export var entertainmentStageTwoPerPopulationRequirement : int = 3;

@export_group("Fuel Needs")
var fuelRequirement = 0; #exponential increase -> need X fuel per population, with X increasing exponentially with population
var fuelPerPopulation = 1;
var fuelPerPopulationIncrease = 1;
@export var fuelPopulationThresholdForFirstIncrease : int = 11;
@export var fuelPopulationThresholdForSecondIncrease : int = 21;
@export var fuelInitialIncreasePerPopulation : float = 1;
@export var fuelFirstStageIncreasePerPopulation : float = 3;
@export var fuelSecondStageIncreasePerPopulation : float = 5;
#refer to excel sheet if trying to determine how to increase values
#https://docs.google.com/spreadsheets/d/1jgKuXWbAOxXwUr6B0A-PB6lI_6xEaFDrz-zSfUEzaOE/edit#gid=0

@export_group("Interface")
@onready var canvas : CanvasLayer = $CanvasLayer;
@onready var foodAndWaterValue : Label = $CanvasLayer/FoodAndWaterValue;
@onready var fuelValue : Label = $CanvasLayer/FuelValue;
@onready var buildingMaterialsValue : Label = $CanvasLayer/BuildingMaterialsValue;
@onready var entertainmentValue : Label = $CanvasLayer/EntertainmentValue;
@onready var interactable : Interactable = $Interactable;


func _ready():
	canvas.hide();
	generateNewNeeds();

func _on_day_tick(_day : int):
	if hasEnoughToSatisfy():
		ResourceManager.extractPopulationMaterials(foodAndWaterRequirement, buildingMaterialsRequirement, entertainmentRequirement, fuelRequirement);
		generateNewNeeds();
		PopulationManager.increasePopulation(1);

func hasEnoughToSatisfy():
	if ResourceManager.foodAndWater < foodAndWaterRequirement:
		return false;
	if ResourceManager.buildingMaterials < buildingMaterialsRequirement:
		return false;
	if ResourceManager.entertainmentMaterials < entertainmentRequirement:
		return false;
	if ResourceManager.fuelMaterials < fuelRequirement:
		return false;
	return true;

func generateNewNeeds():
	var currentPopulation = PopulationManager.getCurrentPopulation();

	foodAndWaterRequirement = getFoodAndWaterRequirement(currentPopulation);
	buildingMaterialsRequirement = getBuildingMaterialsRequirement();
	entertainmentRequirement = getEntertainmentRequirement(currentPopulation);
	fuelRequirement = getFuelRequirement(currentPopulation);

	foodAndWaterValue.text = str(foodAndWaterRequirement);
	buildingMaterialsValue.text = str(buildingMaterialsRequirement);
	entertainmentValue.text = str(entertainmentRequirement);
	fuelValue.text = str(fuelRequirement);

func getFoodAndWaterRequirement(currentPopulation):
	return foodPerPopulation * currentPopulation;

func getBuildingMaterialsRequirement():
	return buildingMaterialsNeededMinimum + randi() % (buildingMaterialsNeededMaximum - buildingMaterialsNeededMinimum);

func getEntertainmentRequirement(currentPopulation):
	if currentPopulation >= entertainmentStageTwoIncreaseAtPopulation:
		entertainmentPerPopulation = entertainmentStageTwoPerPopulationRequirement;
	elif currentPopulation >= entertainmentStageOneIncreaseAtPopulation:
		entertainmentPerPopulation = entertainmentStageOnePerPopulationRequirement;

	return entertainmentPerPopulation * currentPopulation;

func getFuelRequirement(currentPopulation):
	if currentPopulation >= fuelPopulationThresholdForSecondIncrease:
		fuelPerPopulationIncrease = fuelSecondStageIncreasePerPopulation;
	elif currentPopulation >= fuelPopulationThresholdForFirstIncrease:
		fuelPerPopulationIncrease = fuelFirstStageIncreasePerPopulation;
	else:
		fuelPerPopulationIncrease = fuelInitialIncreasePerPopulation;
	
	var fuelRequiredThisTick = fuelPerPopulation * currentPopulation;
	fuelPerPopulation += fuelPerPopulationIncrease;

	return fuelRequiredThisTick;
	
func _on_interactable_player_interacted():
	canvas.show();

func _on_interactable_player_exited_interactable():
	canvas.hide();

func _on_button_pressed():
	canvas.hide();
	interactable.reenableInteraction();
