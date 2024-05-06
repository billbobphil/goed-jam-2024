extends Game

@export var buildingBlockScene : PackedScene;
@onready var blockSpawnPoint : Node2D = $BlockSpawnPoint;
@onready var blocksContainer : Node = $BlocksContainer;
@onready var achievementLine : Sprite2D = $AchievementLine;
var spawnedBlocks : Array = [];
var blocksWithActiveCollisionsWithLine : Array = [];
var playerReference;
var achievementLineY : float = 143;

signal building_gained

func _ready():
	disableGame();
	var playerNodes = get_tree().get_nodes_in_group("Player");
	if playerNodes.size() > 0:
		playerReference = playerNodes[0];

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
	if playerReference:
		playerReference.isMovementEnabled = false;
	achievementLine.position.y = achievementLineY;
	resetGame();

func disableGame():
	cleanupBlocks();
	isGameActive = false;
	visible = false;
	if playerReference:
		playerReference.isMovementEnabled = true;

func resetGame():
	cleanupBlocks();
	spawnBlock();

func cleanupBlocks():
	for block in spawnedBlocks:
		block.queue_free();
	spawnedBlocks.clear();
	blocksWithActiveCollisionsWithLine.clear();

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
	SoundEffectAccess.soundEffects.computerOff.play();
	disableGame();
	if interactable:
		interactable.reenableInteraction();



