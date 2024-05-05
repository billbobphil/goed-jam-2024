extends Skill

class_name SlowPassageOfTimeSkill

@export var newInGameMinutesPerRealSeconds : int = 12;

func activate():
	EfficiencySkillMediator.dayNightCycleReference.ingameMinutesPerRealSeconds = newInGameMinutesPerRealSeconds;



