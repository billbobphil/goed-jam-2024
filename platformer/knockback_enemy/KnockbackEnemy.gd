extends CharacterBody2D

class_name KnockbackEnemy

@export var knockbackForce = 500;
@export var speed = 100;
@export var startingDirection : Vector2 = Vector2(1, 0);
var currentDirection : Vector2;
@onready var leftRayCast : RayCast2D = $LeftRayCast;
@onready var rightRayCast : RayCast2D = $RightRayCast;
var gravity;
var directionChangeTimer : float = 0;
var canChangeDirection : bool = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	currentDirection = startingDirection
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

func _physics_process(delta):

	if !canChangeDirection:
		directionChangeTimer += delta;
		if directionChangeTimer >= .25:
			canChangeDirection = true;
			directionChangeTimer = 0;

	velocity.x = currentDirection.x * speed;
	velocity.y = 0;
	
	var collision = move_and_collide(velocity * delta);

	if canChangeDirection && !(leftRayCast.is_colliding() && rightRayCast.is_colliding()):
		currentDirection *= -1;
		canChangeDirection = false;

	if collision && collision is KinematicCollision2D:
		var collider = collision.get_collider();
		if(collider is TileMap || collider is KnockbackEnemy):
			currentDirection *= -1;
		
		if(collider is PlayerPlatformer):
			collider.knockback(currentDirection.x, knockbackForce);
			currentDirection *= -1;

func _on_area_2d_body_entered(body:Node2D):
	if body is PlayerPlatformer:
		body.enemyBounceJump();
