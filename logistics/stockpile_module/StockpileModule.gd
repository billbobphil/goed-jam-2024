extends Node2D

@onready var canvas : CanvasLayer = $CanvasLayer;
@onready var foodAndWaterLabel : Label = $CanvasLayer/FoodAndWaterValue;
@onready var fuelLabel : Label = $CanvasLayer/FuelValue;
@onready var buildingMaterialsLabel : Label = $CanvasLayer/BuildingMaterialsValue;
@onready var entertainmentLabel : Label = $CanvasLayer/EntertainmentValue;
@onready var technologyLabel : Label = $CanvasLayer/TechnologyValue;
@onready var interactable : Interactable = $Interactable;

func _ready():
	canvas.hide();
	assignValuesToInterface();

func assignValuesToInterface():
	foodAndWaterLabel.text = str(ResourceManager.foodAndWater);
	fuelLabel.text = str(ResourceManager.fuelMaterials);
	buildingMaterialsLabel.text = str(ResourceManager.buildingMaterials);
	entertainmentLabel.text = str(ResourceManager.entertainmentMaterials);
	technologyLabel.text = str(TechnologyManager.techPointsInInventory);

func _on_button_pressed():
	canvas.hide();
	interactable.reenableInteraction();

func _on_interactable_player_exited_interactable():
	canvas.hide();

func _on_interactable_player_interacted():
	assignValuesToInterface();
	canvas.show();
