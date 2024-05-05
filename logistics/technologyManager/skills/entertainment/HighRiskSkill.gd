extends Skill

class_name HighRiskSkill

func activate():
	GameReferenceManager.entertainmentGame.isHighRiskEnabled = true;
