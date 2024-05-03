extends Game

@onready var dieResultOne : Label = $DieResultOne;
@onready var dieResultTwo : Label = $DieResultTwo;
@onready var dieGuessNumber : Label = $DieGuessNumber;
@onready var higherButton : Button = $HigherButton;
@onready var lowerButton : Button = $LowerButton;

var numberToGuessAround = 0;
var guessDirection = "empty";

signal entertainment_gained

func _ready():
	disableGame();

func enableGame():
	isGameActive = true;
	visible = true;
	resetGame();

func disableGame():
	isGameActive = false;
	visible = false;

func resetGame():
	numberToGuessAround = 0;
	higherButton.disabled = true;
	lowerButton.disabled = true;
	guessDirection = "empty";
	dieResultOne.text = "?";
	dieResultTwo.text = "?";
	selectNumber();

func selectNumber():
	numberToGuessAround = randi() % 11 + 2;
	dieGuessNumber.text = str(numberToGuessAround);
	higherButton.disabled = false;
	lowerButton.disabled = false;

func _on_exit_button_pressed():
	disableGame();
	if interactable:
		interactable.reenableInteraction();

func _on_lower_button_pressed():
	guessDirection = 'lower';
	rollAndCheck();

func _on_higher_button_pressed():
	guessDirection = 'higher';
	rollAndCheck();

func rollAndCheck():
	lowerButton.disabled = true;
	higherButton.disabled = true;
	var dieOne = randi() % 6 + 1;
	var dieTwo = randi() % 6 + 1;
	dieResultOne.text = str(dieOne);
	dieResultTwo.text = str(dieTwo);
	var dieTotal = dieOne + dieTwo;

	#TODO replace with animation instead
	#add 2 seconds of artificial delay
	await get_tree().create_timer(2.0).timeout;

	if guessDirection == 'higher' && dieTotal > numberToGuessAround:
		print('guessed higher and won');
		entertainment_gained.emit(1);
	elif guessDirection == 'lower' && dieTotal < numberToGuessAround:
		print('guessed lower and won');
		entertainment_gained.emit(1);
	else:
		#TODO: loss indication here
		pass;

	resetGame();
	
