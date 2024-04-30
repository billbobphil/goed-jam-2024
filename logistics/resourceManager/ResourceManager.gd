extends Node

@export var foodAndWater : int = 0;
@export var buildingMaterials : int = 0;
@export var technologyMaterials : int = 0;
@export var entertainmentMaterials : int = 0;
@export var fuelMaterials : int = 0;

func extractPopulationMaterials(foodAndWaterAmount, buildingMaterialsAmount, entertainmentMaterialsAmount, fuelMaterialsAmount):
	foodAndWater -= foodAndWaterAmount
	buildingMaterials -= buildingMaterialsAmount
	entertainmentMaterials -= entertainmentMaterialsAmount
	fuelMaterials -= fuelMaterialsAmount

func extractTechnologyMaterials(technologyMaterialsAmount):
	technologyMaterials -= technologyMaterialsAmount
