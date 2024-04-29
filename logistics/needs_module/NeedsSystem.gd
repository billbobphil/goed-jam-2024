extends Node2D


var numberOfDaysBeforeNeedsMustbeMet = 1;
var numberOfDaysPassedSinceNeedsChange = 0;

var foodAndWaterRequirement = 0; #linear -> need X food per population and the demand is always population * food per person
var buildingMaterialsRequirement = 0; #constant with slight fluctuation -> always require X +- fluctuation regardless of population
var technologyRequirement = 0; #never a requirement, but can be used to increase efficiency of other needs
var entertainmentRequirement = 0; #linear but with set increases -> need X entertainment per population, with X changing at set population thresholds
var fuelRequirement = 0; #exponential increase -> need X fuel per population, with X increasing exponentially with population
#refer to excel sheet if trying to determine how to increase values
#https://docs.google.com/spreadsheets/d/1jgKuXWbAOxXwUr6B0A-PB6lI_6xEaFDrz-zSfUEzaOE/edit#gid=0

func _on_day_tick(_day : int):
	numberOfDaysPassedSinceNeedsChange += 1;

	if numberOfDaysPassedSinceNeedsChange >= numberOfDaysBeforeNeedsMustbeMet:
		print('need handling required');


func generateNewNeeds():
	pass;