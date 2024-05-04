extends Node

var time : float = 0;

const MINUTES_PER_DAY = 1440;
const MINUTES_PER_HOUR = 60;
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY;
var pastMinute = -1.0;
var pastDay = 1;
@onready var dayValue : Label = $CanvasLayer/DayValue;
@onready var hourValue : Label = $CanvasLayer/HourValue;
@onready var minuteValue : Label = $CanvasLayer/MinuteValue;

@export var ingameMinutesPerRealSeconds = 8;
@export var initialHour = 0:
	set(h):
		initialHour = h;
		time = INGAME_TO_REAL_MINUTE_DURATION * initialHour * MINUTES_PER_HOUR;

signal time_tick(day : int, hour : int, minute : int);
signal day_tick(day : int);

func _ready():
	time = INGAME_TO_REAL_MINUTE_DURATION * initialHour * MINUTES_PER_HOUR;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * ingameMinutesPerRealSeconds;
	recalculate_time();


func recalculate_time():
	var totalMinutesElapsed = int(time / INGAME_TO_REAL_MINUTE_DURATION);
	var day = int(totalMinutesElapsed / MINUTES_PER_DAY) + 1; #Start day at 0
	var currentDayMinutes = totalMinutesElapsed % MINUTES_PER_DAY;
	var hour = int(currentDayMinutes / MINUTES_PER_HOUR);
	var minute = int(currentDayMinutes % MINUTES_PER_HOUR);

	if pastMinute != minute:
		# print("Day: " + str(day) + " Hour: " + str(hour) + " Minute: " + str(minute));
		pastMinute = minute;
		time_tick.emit(day, hour, minute);
		dayValue.text = str(day);
		hourValue.text = "%02d" % hour;
		minuteValue.text = "%02d" % minute;

	if pastDay != day:
		print('day ticked');
		pastDay = day;
		day_tick.emit(day);
