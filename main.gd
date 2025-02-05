@tool
extends Node3D

@export var test_map := preload("res://maps/test_map.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: Make mouse unconfined to game window when the actual menu is showing (With ESC probs)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

	add_child(test_map.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
