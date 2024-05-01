extends Game

@export var buildingBlockScene : PackedScene;
@onready var blockSpawnPoint : Node2D = $BlockSpawnPoint;
@onready var blocksContainer : Node = $BlocksContainer;
@onready var achievementLine : Sprite2D = $AchievementLine;
var spawnedBlocks : Array = [];
var blocksWithActiveCollisionsWithLine : Array = [];

signal building_gained

func _ready():
	disableGame();

func _process(_delta):
	if !isGameActive:
		return;
	for block in blocksWithActiveCollisionsWithLine:
		if block.position.y < achievementLine.position.y && !block.isUnderPlayerControl:
			building_gained.emit(1);
			resetGame();

func enableGame():
	isGameActive = true;
	visible = true;
	resetGame();

func disableGame():
	isGameActive = false;
	visible = false;

func resetGame():
	for block in spawnedBlocks:
		block.queue_free();
	spawnedBlocks.clear();
	blocksWithActiveCollisionsWithLine.clear();
	spawnBlock();

func spawnBlock():
	if !isGameActive:
		return;
	var createdBlock = buildingBlockScene.instantiate();
	createdBlock.position = blockSpawnPoint.position;
	createdBlock.rotation_degrees = randf_range(0, 3) * 45;
	spawnedBlocks.append(createdBlock);
	blocksContainer.add_child(createdBlock);
	createdBlock.block_became_inactive.connect(spawnBlock);

func _on_area_2d_body_entered(body:Node2D):
	if body is BuildingBlock:
		blocksWithActiveCollisionsWithLine.append(body);

func _on_area_2d_body_exited(body:Node2D):
	if body is BuildingBlock:
		blocksWithActiveCollisionsWithLine.erase(body);

func _on_exit_button_pressed():
	isGameActive = false;
	visible = false;
	if interactable:
		interactable.reenableInteraction();



