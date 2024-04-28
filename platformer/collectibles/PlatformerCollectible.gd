extends Node2D

signal platformer_collectible_gathered

func _on_area_2d_body_entered(body:Node2D):
	if(body is PlayerPlatformer):
		platformer_collectible_gathered.emit();
		body.numberOfCollectibles += 1;
		#TODO: sound effects etc here
		queue_free();

