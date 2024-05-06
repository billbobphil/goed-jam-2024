extends Game

@onready var dieResultOne : Label = $DieResultOne;
@onready var dieResultTwo : Label = $DieResultTwo;
@onready var dieGuessNumber : Label = $DieGuessNumber;
@onready var higherButton : Button = $HigherButton;
@onready var lowerButton : Button = $LowerButton;
@onready var scored : Label = $Scored;
var isHighRiskEnabled = false;

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
	scored.visible = false;
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
	SoundEffectAccess.soundEffects.computerOff.play();
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

	var dieTotal = dieOne + dieTwo;

	var timer_duration = 0.1;
	var elapsed_time = 0.0
	while elapsed_time < 1.5:
        # Show random values during the roll
		dieResultOne.text = str(randi() % 6 + 1)
		dieResultTwo.text = str(randi() % 6 + 1)

		await get_tree().create_timer(timer_duration).timeout
		elapsed_time += timer_duration
	
	dieResultOne.text = str(dieOne);
	dieResultTwo.text = str(dieTwo);

	if guessDirection == 'higher' && dieTotal > numberToGuessAround:
		print('guessed higher and won');
		giveReward();
	elif guessDirection == 'lower' && dieTotal < numberToGuessAround:
		print('guessed lower and won');
		giveReward();
	else:
		if isHighRiskEnabled:
			entertainment_gained.emit(-2);

	await get_tree().create_timer(1.5).timeout;
	resetGame();

func giveReward():
	if !isHighRiskEnabled:
		entertainment_gained.emit(1);
	else:
		entertainment_gained.emit(3);
	scored.visible = true;
	SoundEffectAccess.soundEffects.resourceGet.play();
	await get_tree().create_timer(1).timeout;
	scored.visible = false;

	
