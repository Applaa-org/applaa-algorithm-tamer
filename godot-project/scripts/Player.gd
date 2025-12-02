extends CharacterBody2D

const SPEED: float = 150.0
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -300.0  # Jump

	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, mouse_pos)
		var result = space_state.intersect_ray(query)
		if result and result.collider.is_in_group("algorithm"):
			attempt_catch(result.collider)
		elif result and result.collider.is_in_group("training_area"):
			get_tree().change_scene_to_file("res://scenes/Training.tscn")

func attempt_catch(algorithm):
	var algo_name = algorithm.name
	if not Global.algorithms[algo_name]["caught"]:
		Global.catch_algorithm(algo_name)
		algorithm.queue_free()
		print("Caught " + algo_name + "!")