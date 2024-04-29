extends CharacterBody2D

class_name PlayerLogistics

@export var movementSpeed : int = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	var direction = Input.get_vector("logistics-left", "logistics-right", "logistics-up", "logistics-down");
	velocity = direction * movementSpeed;
	move_and_slide();
