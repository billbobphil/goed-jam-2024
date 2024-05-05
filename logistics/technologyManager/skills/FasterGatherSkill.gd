extends Skill

class_name FasterGatherSkill

@export var gatherType : AutoGatherer.ResourceType;
@export var newNumberOfHoursToGatherAfter : int = 6;

func activate():
    match gatherType:
        AutoGatherer.ResourceType.FOOD:
            AutoGatherer.hoursRequiredForFoodDispensing = newNumberOfHoursToGatherAfter;
        AutoGatherer.ResourceType.ENTERTAINMENT:
            AutoGatherer.hoursRequiredForEntertainmentDispensing = newNumberOfHoursToGatherAfter;
        AutoGatherer.ResourceType.FUEL:
            AutoGatherer.hoursRequiredForFuelDispensing = newNumberOfHoursToGatherAfter;
        AutoGatherer.ResourceType.BUILDING:
            AutoGatherer.hoursRequiredForBuildingDispensing = newNumberOfHoursToGatherAfter;