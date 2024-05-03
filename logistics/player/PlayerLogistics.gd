extends CharacterBody2D

class_name PlayerLogistics

@export var movementSpeed : int = 100;
var isMovementEnabled : bool = true;

func _physics_process(_delta):
	if !isMovementEnabled:
		return;

	var direction = Input.get_vector("logistics-left", "logistics-right", "logistics-up", "logistics-down");
	velocity = direction * movementSpeed;
	move_and_slide();
