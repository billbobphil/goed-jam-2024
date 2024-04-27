extends CharacterBody2D

@export_group("Debug")
@export var isDebugEnabled = false;
@onready var DebugCanvas = $DebugCanvas;
@export var timeScaleModifcation = 1.0;

@export_group("Movement")
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
var jumpTimer = 0;
var isJumping = false;
var coyoteTimer = 0;
var coyoteTimeWindow : float = .15;
var shouldFall = false;
var inputBufferTimeWindow : float = .1;
var inputBufferTimer : float = 0;
var isInputBuffered : bool = false;

var gravity;
var baseGravity = ProjectSettings.get_setting("physics/2d/default_gravity");

func _ready():
	gravity = baseGravity;

	if !isDebugEnabled:
		DebugCanvas.hide();

	if isDebugEnabled:
		Engine.set_time_scale(timeScaleModifcation);

func _physics_process(delta):

	handleInputBufferTimer(delta);

	if is_on_floor():
		coyoteTimer = 0;
		shouldFall = false;
		isJumping = false;
		jumpTimer = 0;
		gravity = baseGravity;
		if(isInputBuffered):
			jump();
			isInputBuffered = false;
			inputBufferTimer = 0;

	#mid jump hover
	if isJumping && !is_on_floor() && velocity.y > -69:
		jumpTimer += delta;
		gravity = baseGravity * .75;
		if(jumpTimer > .275):
			gravity = baseGravity * 1.35;
	
	#apply gravity, should fall rather than is_on_floor to allow for coyote time
	if shouldFall:
		velocity.y += gravity * delta

	#record jumps for input buffering
	if Input.is_action_just_pressed("platformer-jump") && shouldFall:
		isInputBuffered = true;
		inputBufferTimer = 0;

	if !isJumping && Input.is_action_just_pressed("platformer-jump") and (is_on_floor() || isCoyoteTimeValid()):
		jump();

	var direction = Input.get_axis("platformer-left", "platformer-right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if(isDebugEnabled):
		DebugCanvas.get_node("VelocityYLabel").text = str(velocity.y);

	coyoteTimeHandler(delta);
	move_and_slide()

func coyoteTimeHandler(delta):
	if !is_on_floor() && !isJumping:
		coyoteTimer += delta
	elif isJumping:
		shouldFall = true;
	
	if coyoteTimer > coyoteTimeWindow:
		shouldFall = true;

func isCoyoteTimeValid():
	return coyoteTimer < coyoteTimeWindow;

func handleInputBufferTimer(delta):
	if isInputBuffered:
		inputBufferTimer += delta;
		if(inputBufferTimer > inputBufferTimeWindow):
			isInputBuffered = false;
			inputBufferTimer = 0;

func jump():
	gravity = baseGravity * 2;
	velocity.y = JUMP_VELOCITY;
	isJumping = true;
	shouldFall = true;