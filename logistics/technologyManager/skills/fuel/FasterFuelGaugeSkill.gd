extends Skill

class_name FasterFuelGaugeSkill

@export var newFuelGaugeSpeed : int = 50;

func activate():
	GameReferenceManager.fuelGame.speed = newFuelGaugeSpeed;