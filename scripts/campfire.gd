class_name Campfire extends Node2D

enum potion { BLUE, YELLOW }
@onready var my_state: int = 0
@export var my_type: int
var is_burning: bool
var player: CharacterBody2D


func _ready() -> void:
	is_burning = false
	$FireTimer.stop()
	$MenuButton.visible = false
	$MenuButton.get_popup().id_pressed.connect(check_menu_id)
	switch_state()


func switch_state() -> void:
	$Type_1.visible = false
	$Type_2.visible = false
	#$Cauldron_1.visible = false
	#$Cauldron_2.visible = false
	$Fire.visible = false
	$FireTimer.stop()
	#$MenuButton.visible = false
	is_burning = false
	match my_state:
		0:
			if my_type == 1:
				$Type_1.visible = true
				$Type_1.play("default")
			else:
				$Type_2.visible = true
				$Type_2.play("default")
		1:
			if my_type == 1:
				$Type_1.visible = true
				$Type_1.play("wood")
			else:
				$Type_2.visible = true
				$Type_2.play("wood")
		2:
			is_burning = true
			if my_type == 1:
				$Type_1.visible = true
				$Type_1.play("wood")
			else:
				$Type_2.visible = true
				$Type_2.play("wood")
		3:
			if my_type == 1:
				$Type_1.visible = true
				$Type_1.play("burned_down")
			else:
				$Type_2.visible = true
				$Type_2.play("burned_down")
	if is_burning:
		$Fire.visible = true
		$FireTimer.start()


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		change_state()


func change_state() -> void:
	my_state += 1
	if my_state > 3:
		my_state = 0
	switch_state()


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body
		$MenuButton.visible = true


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null
		$MenuButton.visible = false


func _on_fire_timer_timeout() -> void:
	$Fire.visible = false
	change_state()


func check_menu_id(id: int):
	$Cauldron_1.visible = false
	$Cauldron_2.visible = false
	match id:
		0:
			$Cauldron_1.visible = true
		1:
			$Cauldron_2.visible = true
