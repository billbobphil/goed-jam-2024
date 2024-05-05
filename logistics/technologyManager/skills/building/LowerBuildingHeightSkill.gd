extends Skill

class_name LowerBuildingHeightSkill

@export var newBuildingLineHeightPercentageDecrease : float = .25;

func activate():
	var currentHeight = GameReferenceManager.buildingGame.achievementLineY;
	var amountToDecrease = currentHeight * newBuildingLineHeightPercentageDecrease;
	# appears like the wrong direction of math, but the y axis goes down as the value increases
	GameReferenceManager.buildingGame.achievementLineY += amountToDecrease;
