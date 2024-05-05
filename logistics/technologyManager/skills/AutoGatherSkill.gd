extends Skill

class_name AutoGatherSkill

@export var gatherType : AutoGatherer.ResourceType;
@export var amountToSetAutoGatherTo : int = 0;

func activate():
    match gatherType:
        AutoGatherer.ResourceType.FOOD:
            AutoGatherer.isAutoFoodDispensingEnabled = true;
            AutoGatherer.amountOfFoodToDispense = amountToSetAutoGatherTo;
        AutoGatherer.ResourceType.ENTERTAINMENT:
            AutoGatherer.isAutoEntertainmentDispensingEnabled = true;
            AutoGatherer.amountOfEntertainmentToDispense = amountToSetAutoGatherTo;
        AutoGatherer.ResourceType.FUEL:
            AutoGatherer.isAutoFuelDispensingEnabled = true;
            AutoGatherer.amountOfFuelToDispense = amountToSetAutoGatherTo;
        AutoGatherer.ResourceType.BUILDING:
            AutoGatherer.isAutoBuildingDispensingEnabled = true;
            AutoGatherer.amountOfBuildingToDispense = amountToSetAutoGatherTo;