extends Node

enum ResourceType {
	FOOD,
	ENTERTAINMENT,
	FUEL,
	BUILDING
}

var hoursSinceFoodLastDispensed = 0;
var isAutoFoodDispensingEnabled = false;
var hoursRequiredForFoodDispensing = 12;
var amountOfFoodToDispense = 0;

var hoursSinceEntertainmentLastDispensed = 0;
var isAutoEntertainmentDispensingEnabled = false;
var hoursRequiredForEntertainmentDispensing = 12;
var amountOfEntertainmentToDispense = 0;

var hoursSinceFuelLastDispensed = 0;
var isAutoFuelDispensingEnabled = false;
var hoursRequiredForFuelDispensing = 12;
var amountOfFuelToDispense = 0;

var hoursSinceBuildingLastDispensed = 0;
var isAutoBuildingDispensingEnabled = false;
var hoursRequiredForBuildingDispensing = 12;
var amountOfBuildingToDispense = 0;

func initialize():
	var dayNightCycleNodes = get_tree().get_nodes_in_group("DayNightCycle");
	if dayNightCycleNodes.size() > 0:
		var dayNightCycle = dayNightCycleNodes[0];
		dayNightCycle.hour_tick.connect(hour_passed);

func hour_passed(_hour):
	checkFood();
	checkEntertainment();
	checkFuel();
	checkBuilding();

func checkFood():
	if isAutoFoodDispensingEnabled:
		hoursSinceFoodLastDispensed += 1;
		if hoursSinceFoodLastDispensed >= hoursRequiredForFoodDispensing:
			hoursSinceFoodLastDispensed = 0;
			ResourceManager.foodGained(amountOfFoodToDispense);

func checkEntertainment():
	if isAutoEntertainmentDispensingEnabled:
		hoursSinceEntertainmentLastDispensed += 1;
		if hoursSinceEntertainmentLastDispensed >= hoursRequiredForEntertainmentDispensing:
			hoursSinceEntertainmentLastDispensed = 0;
			ResourceManager.gainEntertainment(amountOfEntertainmentToDispense);

func checkFuel():
	if isAutoFuelDispensingEnabled:
		hoursSinceFuelLastDispensed += 1;
		if hoursSinceFuelLastDispensed >= hoursRequiredForFuelDispensing:
			hoursSinceFuelLastDispensed = 0;
			ResourceManager.gainFuel(amountOfFuelToDispense);

func checkBuilding():
	if isAutoBuildingDispensingEnabled:
		hoursSinceBuildingLastDispensed += 1;
		if hoursSinceBuildingLastDispensed >= hoursRequiredForBuildingDispensing:
			hoursSinceBuildingLastDispensed = 0;
			ResourceManager.gainBuilding(amountOfBuildingToDispense);
