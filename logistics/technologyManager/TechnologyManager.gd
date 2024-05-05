extends Node

var techPointsAvailableToCollect = 0;
var techPointsInInventory = 4;

func increaseTechPoints(amount):
	techPointsAvailableToCollect += amount;
	if EfficiencySkillMediator.isAutoCollectTechPointsEnabled:
		collectAvailableTechPoints();

func decreaseTechPoints(amount):
	techPointsAvailableToCollect -= amount;

func collectAvailableTechPoints():
	techPointsInInventory += techPointsAvailableToCollect;
	techPointsAvailableToCollect = 0;

func spendTechPoints(amount):
	techPointsInInventory -= amount;
	print("Tech points in inventory: ", techPointsInInventory);