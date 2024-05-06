extends Node

var currentPopulation = 1;
var populationVictoryThreshold = 25;

func getCurrentPopulation():
	return currentPopulation;

func increasePopulation(amount):
	currentPopulation += amount;
	TechnologyManager.increaseTechPoints(1);
	checkVictory();

func checkVictory():
	if currentPopulation >= populationVictoryThreshold:
		SceneChangeManager.goToEnd();
		SoundEffectAccess.soundEffects.playerWalk.stop();
