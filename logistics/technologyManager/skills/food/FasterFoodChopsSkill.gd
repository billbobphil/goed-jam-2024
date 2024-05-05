extends Skill

class_name FasterFoodChopsSkill

@export var numberOfChopsRequired : int = 5;

func activate():
    GameReferenceManager.foodGame.numberOfNotesBeforeScore = numberOfChopsRequired;

    