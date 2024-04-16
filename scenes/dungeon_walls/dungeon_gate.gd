class_name DungeonGate extends StaticBody2D

@export var my_gate: StaticBody2D
var my_state: Globals.gate_state
var player: Hero


func _ready():
	my_state = Globals.gate_state.CLOSED
	player = null
	_switch_state()


func _switch_state() -> void:
	if my_state == Globals.gate_state.OPENED:
		$OpenGateCollision/CollisionPolygon2D.disabled = false
		$OpenGateCollision/CollisionPolygon2D2.disabled = false
		$ClosedGateCollision.disabled = true
		$AnimatedSprite2D.play("opened")
		$CandleSwitch.play("opened")
		$PointLight2D.visible = true
	else: 
		$OpenGateCollision/CollisionPolygon2D.disabled = true
		$OpenGateCollision/CollisionPolygon2D2.disabled = true
		$ClosedGateCollision.disabled = false
		$AnimatedSprite2D.play("closed")
		$CandleSwitch.play("closed")
		$PointLight2D.visible = false


func _change_state() -> void:
	if my_state == Globals.gate_state.OPENED:
		my_state = Globals.gate_state.CLOSED
	else: 
		my_state = Globals.gate_state.OPENED


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player = null


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		_change_state()
		_switch_state()
