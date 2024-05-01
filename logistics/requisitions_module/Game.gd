extends Node2D

class_name Game

@export var interactable : Interactable;
var isGameActive : bool = false;

func enableGame():
	push_error("enableGame Method must be overridden in subclass");

func disableGame():
	push_error("disableGame Method must be overridden in subclass");