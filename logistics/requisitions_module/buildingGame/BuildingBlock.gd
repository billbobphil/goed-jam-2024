extends RigidBody2D

class_name BuildingBlock

var isUnderPlayerControl : bool = true;
@export var horizontalSpeed : float = 10;
@export var verticalSpeed : float = 10;

signal block_became_inactive

func _integrate_forces(_state):
	if !isUnderPlayerControl:
		return;

	var direction = Input.get_axis("logistics-left", "logistics-right");
	position.x += direction * horizontalSpeed * get_physics_process_delta_time();
	

func _on_body_entered(_body:Node):
	if isUnderPlayerControl:
		isUnderPlayerControl = false;
		block_became_inactive.emit();
