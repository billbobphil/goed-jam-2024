extends Skill

class_name IncreaseMoveSpeedSkill

@export var percentageToIncreaseMoveSpeedBy : float = 0.2;

func activate():
	EfficiencySkillMediator.playerReference.movementSpeed += EfficiencySkillMediator.playerReference.movementSpeed * percentageToIncreaseMoveSpeedBy;
