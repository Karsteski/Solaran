@tool
extends Camera3D

@export var SPEED := 20.0
@export var MOUSE_SPEED := 20.0
@export var VIEWPORT_EDGE_THRESHOLD := 2;


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_SPACE:
			position = Vector3(0, position.y, 0)

		var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction: Vector3 = (transform.basis * Vector3(input_direction.x, 0.0, input_direction.y)).normalized()


		if direction:
			position.x += direction.x * SPEED
			position.z += direction.y * SPEED

	if event is InputEventMouseMotion:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		var viewport_size: Vector2 = get_viewport().size


		print("mouse_position = ", mouse_position)
		print("viewport_size = ", viewport_size)
		print("event_velocity = ", event.velocity)

		
		if (abs(mouse_position.x - 0.0) < VIEWPORT_EDGE_THRESHOLD or abs(mouse_position.x - viewport_size.x) < VIEWPORT_EDGE_THRESHOLD
			or abs(mouse_position.y - 0.0) < VIEWPORT_EDGE_THRESHOLD or abs(mouse_position.y - viewport_size.y) < VIEWPORT_EDGE_THRESHOLD):

			var mouse_direction: Vector3 = (transform.basis * Vector3(event.velocity.x, 0.0, event.velocity.y)).normalized()
			position.x += mouse_direction.x 
			position.z += mouse_direction.y
			
			


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# look_at(position)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
