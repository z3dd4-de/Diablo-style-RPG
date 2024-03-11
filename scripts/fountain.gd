extends Node2D


func _ready():
	$AnimatedSprite2D.play("default")


func _on_area_2d_body_entered(body):
	#if body.is_in_group("Player"):
	#	play_sound(true)
	print("Player entered")


func _on_area_2d_body_exited(body):
	#if body.is_in_group("Player"):
	#	play_sound(false)
	print("Player left")
