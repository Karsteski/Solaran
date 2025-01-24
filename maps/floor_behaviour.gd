@tool
extends RigidBody3D

@onready var mesh_instance_3D: MeshInstance3D = $MeshInstance3D

@export var grid_colour: Vector3 = Vector3(1.0, 1.0, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	mesh_instance_3D.set_instance_shader_parameter("grid_colour", grid_colour)
