extends Skill

class_name AutoCollectTechPointsSkill

func activate():
	EfficiencySkillMediator.isAutoCollectTechPointsEnabled = true;