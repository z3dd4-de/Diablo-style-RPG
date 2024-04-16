extends StaticBody2D

enum orientation { LEFT, RIGHT }

@export var my_orientation: orientation


func _ready() -> void:
	play_animation()


func play_animation() -> void:
	if my_orientation == orientation.LEFT:
		$AnimatedSprite2D.play("left")
		$PointLight2D.position.x = -30
	else:
		$AnimatedSprite2D.play("right")
		$PointLight2D.position.x = 29
