extends Node2D

enum state { ACTIVE, INACTIVE }

@export var my_name: Globals.teleport_type
@export var my_target: Globals.teleport_type
@export var activator: TeleportActivator

var current_state = state.INACTIVE
var jump: bool = false

var player: CharacterBody2D


func _ready() -> void:
	Globals.TeleportActivated.connect(activate)
	player = null


func change_state() -> void: 
	if current_state == state.ACTIVE:
		current_state = state.INACTIVE
	else:
		current_state = state.ACTIVE
	play_animation()


func play_animation() -> void:
	match current_state:
		state.ACTIVE:
			$AnimatedSprite2D.play("active")
		state.INACTIVE:
			$AnimatedSprite2D.play("inactive")


func _on_timer_timeout() -> void:
	current_state = state.INACTIVE
	play_animation()


func activate(type: Globals.teleport_type) -> void:
	if my_name == type:
		current_state = state.ACTIVE
		play_animation()
		$Timer.start()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		Globals.hero = body
		print("Globals.hero: ", Globals.hero)
		if jump == false:
			if my_target == Globals.teleport_type.GRAVEYARD and player.world_1_teleport_rune == true:
				#Globals.hero = get_parent().get_node("Hero")
				print("Teleport W1: ", Globals.hero.thirst.current_water)
				SceneManager.SwitchScene("Graveyard")
			elif my_target == Globals.teleport_type.WORLD1 and player.graveyard_teleport_rune == true:
				SceneManager.SwitchScene("World 1")
			jump = true
			current_state = state.INACTIVE


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player = null
		jump = false
