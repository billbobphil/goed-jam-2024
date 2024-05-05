extends Skill

class_name FoodAutoGatherSkill

@export var amountToSetAutoGatherTo : int = 0;

func activate():
    AutoGatherer.isAutoFoodDispensingEnabled = true;
    AutoGatherer.amountOfFoodToDispense = amountToSetAutoGatherTo;