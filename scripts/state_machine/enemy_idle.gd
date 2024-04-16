extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed := 0.0

var move_direction: Vector2
var idle_time: float
var player: CharacterBody2D


func randomize_idle() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	idle_time = randf_range(1, 3)


func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	randomize_idle()


func update(delta: float) -> void:
	if idle_time > 0:
		idle_time -= delta
	else:
		randomize_idle()


func physics_update(delta: float) -> void:
	if enemy:
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	if direction.length() < 25:
		Transitioned.emit(self, "followplayer")
