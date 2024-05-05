extends Node

var techPointsAvailableToCollect = 0;
var techPointsInInventory = 4;
var techPointsDisplays = [];

func _ready():
	techPointsDisplays = get_tree().get_nodes_in_group("TechnologyPointsDisplay");
	updateTechPointsDisplays();

func increaseTechPoints(amount):
	techPointsAvailableToCollect += amount;
	if EfficiencySkillMediator.isAutoCollectTechPointsEnabled:
		collectAvailableTechPoints();

func decreaseTechPoints(amount):
	techPointsAvailableToCollect -= amount;

func collectAvailableTechPoints():
	techPointsInInventory += techPointsAvailableToCollect;
	techPointsAvailableToCollect = 0;
	updateTechPointsDisplays();

func spendTechPoints(amount):
	techPointsInInventory -= amount;
	updateTechPointsDisplays();
	print("Tech points in inventory: ", techPointsInInventory);

func updateTechPointsDisplays():
	for display in techPointsDisplays:
		display.updateTechnologyPoints(techPointsInInventory);