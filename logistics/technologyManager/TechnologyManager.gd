extends Node

var techPointsAvailableToCollect = 0;
var techPointsInInventory = 0;

func increaseTechPoints(amount):
	techPointsAvailableToCollect += amount;

func decreaseTechPoints(amount):
	techPointsAvailableToCollect -= amount;

func collectAvailableTechPoints():
	techPointsInInventory += techPointsAvailableToCollect;
	techPointsAvailableToCollect = 0;