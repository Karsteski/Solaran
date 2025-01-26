@tool
extends Node3D


@onready var spawn_point: Node3D = $world/spawn_point

@export var character: PackedScene = preload("res://characters/test_subject.tscn")


func spawn_character() -> void:
	# TODO: Add player as a child of the map
	spawn_point.add_child(character.instantiate())


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_character()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
