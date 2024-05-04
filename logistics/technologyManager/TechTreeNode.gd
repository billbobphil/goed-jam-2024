extends Node2D

class_name TechTreeNode

@onready var sprite : Sprite2D = $Sprite2D
@onready var costLabel : Label = $CostLabel
var isAvailable : bool = false;
var isUnlocked : bool = false;
@export var cost : int = 0;
@export var skill : Skill;
@export var prevNode : TechTreeNode = null;
@export var nextNodes : Array[TechTreeNode] = [];
@export var description : String = "";

func _ready():
	if prevNode == null:
		isAvailable = true;
	else:
		sprite.modulate.a = 0.5;
		costLabel.text = "LOCKED";

func makeAvailable():
	isAvailable = true;
	sprite.modulate.a = 1.0;
	costLabel.text = str(cost);

func _on_area_2d_input_event(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
		if isAvailable && !isUnlocked && TechnologyManager.techPointsInInventory >= cost:
			unlock();

func unlock():
	TechnologyManager.decreaseTechPoints(cost);
	isUnlocked = true;
	skill.activate();
	costLabel.text = "UNLOCKED";
	for node in nextNodes:
		node.makeAvailable();
