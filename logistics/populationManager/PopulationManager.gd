extends Node

var currentPopulation = 1;
var populationVictoryThreshold = 25;

func getCurrentPopulation():
	return currentPopulation;

func increasePopulation(amount):
	currentPopulation += amount;
	#TODO: communicate with relevant interface elements
