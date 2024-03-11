extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 0.0

var move_direction: Vector2
var idle_time: float

func randomize_idle():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	idle_time = randf_range(1, 3)


func enter():
	randomize_idle()


func update(delta: float):
	if idle_time > 0:
		idle_time -= delta
	else:
		randomize_idle()


func physics_update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
