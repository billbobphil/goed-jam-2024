extends CanvasLayer

@onready var towerPiecesValue : Label = $TowerPiecesValue;
var collectiblesGathered = 0;


# Called when the node enters the scene tree for the first time.
func _ready():
	towerPiecesValue.text = "0"
	var collectibles = get_tree().get_nodes_in_group("PlatformerCollectible");
	for collectible in collectibles:
		collectible.platformer_collectible_gathered.connect(collectibleGathered);


func collectibleGathered():
	collectiblesGathered += 1;
	towerPiecesValue.text = str(collectiblesGathered);

