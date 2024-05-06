extends CharacterBody2D

class_name PlayerLogistics

@export var movementSpeed : int = 100;
var isMovementEnabled : bool = true;
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D;

func _physics_process(_delta):
	if !isMovementEnabled:
		return;

	var direction = Input.get_vector("logistics-left", "logistics-right", "logistics-up", "logistics-down");
	velocity = direction * movementSpeed;


	move_and_slide();

	if direction != Vector2.ZERO:
		updateWalkAnimation(direction);
	else:
		updateIdleAnimation();

func updateWalkAnimation(direction):
	if !SoundEffectAccess.soundEffects.playerWalk.is_playing():
		SoundEffectAccess.soundEffects.playerWalk.play();
	
	if direction.y < 0:
		animatedSprite.play("walking-up");
	elif direction.y > 0:
		animatedSprite.play("walking-down");
	elif direction.x > 0:
		animatedSprite.play("walking-right");
	elif direction.x < 0:
		animatedSprite.play("walking-left");

func updateIdleAnimation():
	SoundEffectAccess.soundEffects.playerWalk.stop();
	var currentAnimation = animatedSprite.animation;
	 
	if currentAnimation == "walking-up":
		animatedSprite.play("idle-up");
	elif currentAnimation == "walking-down":
		animatedSprite.play("idle-down");
	elif currentAnimation == "walking-right":
		animatedSprite.play("idle-right");
	elif currentAnimation == "walking-left":
		animatedSprite.play("idle-left");

