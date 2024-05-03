extends Node2D

class_name FoodNote

@export var minimumSpeed : float = 100;
@export var maximumSpeed : float = 200;
var speed : float = 100;
var hasAppeared : bool = false;

func _ready():
	speed = randf() * (maximumSpeed - minimumSpeed) + minimumSpeed;

func _process(delta):
	position.x += -1 * speed * delta;


func _on_visible_on_screen_notifier_2d_screen_exited():
	if !hasAppeared:
		return;
	queue_free();

func _on_visible_on_screen_notifier_2d_screen_entered():
	hasAppeared = true;
