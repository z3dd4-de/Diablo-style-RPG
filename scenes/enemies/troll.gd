extends CharacterBody2D
class_name Troll

var action: String
var direction: String
var is_alive: bool

@export var health: HealthComponent


func _init():
	is_alive = true
	direction = "_w"


func _physics_process(delta):
	$HealthBar.value = health.current_health
	if velocity.length() > 0:
		action = "running"
		get_direction()
	else:
		action = "stance"
	
	play_animation()
	move_and_slide()


func get_direction():
	if velocity.x < 0:
		if velocity.y < 0:
			direction = "_nw"
		elif velocity.y == 0:
			direction = "_w"
		elif velocity.y > 0:
			direction = "_sw"
	elif velocity.x == 0:
		if velocity.y < 0:
			direction = "_n"
		elif velocity.y > 0:
			direction = "_s"
	elif velocity.x > 0:
		if velocity.y < 0:
			direction = "_ne"
		elif velocity.y == 0:
			direction = "_e"
		elif velocity.y > 0:
			direction = "_se"


func play_animation():
	var animation = action + direction
	$AnimatedSprite2D.play(animation)
