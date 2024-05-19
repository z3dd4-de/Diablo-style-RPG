class_name Arrow extends Area2D

var speed = 300
enum type { WOOD, IRON }
var my_type: type


func _ready():
	if my_type == null:
		my_type = type.WOOD
	set_as_top_level(true)


func _process(delta):
	position *= (Vector2.RIGHT * speed).rotated(rotation) * delta


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
