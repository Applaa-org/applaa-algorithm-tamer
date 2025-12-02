extends CharacterBody2D

var algorithm_name: String
var speed: float = 50.0
var direction: Vector2 = Vector2.RIGHT
var change_direction_timer: float = 0.0

func _ready():
	add_to_group("algorithm")
	algorithm_name = name

func _physics_process(delta: float):
	change_direction_timer -= delta
	if change_direction_timer <= 0:
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		change_direction_timer = randf_range(1, 3)

	velocity = direction * speed
	move_and_slide()