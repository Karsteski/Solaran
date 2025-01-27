@tool
extends Camera3D

@export var SPEED := 20.0
@export var MOUSE_SPEED := 20.0
@export var VIEWPORT_EDGE_THRESHOLD := 20;

@onready var window: Window = get_viewport().get_window()

var is_mouse_inside_viewport = true
var mouse_direction: Vector3 = Vector3.ZERO

		
func handle_camera_movement(direction: Vector3, delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var viewport_size: Vector2 = get_viewport().size

	# Camera positions are only updated if the mouse is moving in the direction of the relevant quadrant
	# Taking care of diagonal camera movement in a clockwise order
	if mouse_position.x < VIEWPORT_EDGE_THRESHOLD and mouse_position.y < VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x < 0.0 else position.x
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y < 0.0 else position.z
	elif mouse_position.x > viewport_size.x - VIEWPORT_EDGE_THRESHOLD and mouse_position.y < VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x > 0.0 else position.x
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y < 0.0 else position.z
	elif mouse_position.x > viewport_size.x - VIEWPORT_EDGE_THRESHOLD and mouse_position.y > viewport_size.y - VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x > 0.0 else position.x
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y > 0.0 else position.z
	elif mouse_position.x < VIEWPORT_EDGE_THRESHOLD and mouse_position.y > viewport_size.y - VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x < 0.0 else position.x
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y > 0.0 else position.z
	# Horizontal or vertical camera movement
	elif mouse_position.x < VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x < 0.0 else position.x
	elif mouse_position.x > viewport_size.x - VIEWPORT_EDGE_THRESHOLD:
		position.x = lerp(position.x, position.x + mouse_direction.x * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.x > 0.0 else position.x
	elif mouse_position.y < VIEWPORT_EDGE_THRESHOLD:
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y < 0.0 else position.z
	elif mouse_position.y > viewport_size.y - VIEWPORT_EDGE_THRESHOLD:
		position.z = lerp(position.z, position.z + mouse_direction.y * MOUSE_SPEED, MOUSE_SPEED * delta) if mouse_direction.y > 0.0 else position.z

func _ready() -> void:
	# Note: This is bugged on the COSMIC DE on Linux, and possibly other tiling WMs
	# The cursor is able to leave the window despite having set "Input.mouse_mode = Input.MOUSE_MODE_CONFINED"
	# Is this better behaved on other DEs/OSes?
	window.mouse_entered.connect(func(): is_mouse_inside_viewport = true)
	window.mouse_exited.connect(func(): is_mouse_inside_viewport = false)

func _unhandled_input(event: InputEvent) -> void:
	# TODO: hardcoded keybind 🤮
	if event is InputEventKey and event.keycode == KEY_SPACE and event.is_pressed():
		# Reset camera
		position = Vector3(0.0, position.y, 0.0)
	if event is InputEventMouseMotion:
		# TODO: I still don't fully understand why to use the transform basis
		mouse_direction = (transform.basis * Vector3(event.velocity.x, 0.0, event.velocity.y)).normalized()

func _process(delta: float) -> void:
	handle_camera_movement(mouse_direction, delta)
