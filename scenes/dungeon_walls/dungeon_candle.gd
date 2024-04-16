class_name Candle extends StaticBody2D

var is_burning: bool

var player: Hero


func _ready():
	is_burning = false
	$AnimatedSprite2D.play("candle_off")
	$PointLight2D.visible = false


func _switch_state():
	is_burning = !is_burning
	if is_burning:
		$AnimatedSprite2D.play("candle_on")
		$PointLight2D.visible = true
	else: 
		$AnimatedSprite2D.play("candle_off")
		$PointLight2D.visible = false


func _on_candle_switch_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("Player entered")
		player = body


func _on_candle_switch_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		print("Player left")


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		_switch_state()
