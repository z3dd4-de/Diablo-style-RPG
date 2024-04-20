class_name Hero extends CharacterBody2D

const SPEED = 200.0
var move_direction = Vector2(0, 0)

var _outfit = Globals.Outfit.CLOTHES
var _weapon = Globals.Weapon.NONE
var _head = Globals.Head.MALE1
var _shield = Globals.Shield.NONE
var _bow = Globals.Bow.NONE

@onready var clothes = $Clothes
@onready var leather_armor = $LeatherArmor
@onready var dagger = $Dagger
@onready var male_head_1 = $MaleHead1
@onready var buckler = $Buckler
@onready var shortbow = $Shortbow
@onready var thirst = $Thirst
@onready var health = $Health
@onready var hunger = $Hunger

var is_alive: bool
var death_animation_played: bool
var has_axe: bool
var action: String
var direction: String

#TODO - inventory missing, but I want to test the teleport
var world_1_teleport_rune: bool = false
var graveyard_teleport_rune: bool = false


func _ready() -> void:
	is_alive = true
	death_animation_played = false
	has_axe = false
	action = "stance"
	direction = "_w"
	_change_outfit()
	_change_head()
	_change_shield()
	_change_weapon()
	_change_bow()

	# connect to component signals
	health.HasDied.connect(_hero_died)
	health.HealthChanged.connect(_update_health)


func _hero_died() -> void:
	is_alive = false


func _update_health(addhealth: int) -> void:
	pass


func update_thirst(addwater: int) -> void:
	thirst.add_water(addwater)


func _change_outfit() -> void:
	match _outfit:
		Globals.Outfit.CLOTHES:
			clothes.visible = true
			leather_armor.visible = false
		Globals.Outfit.LEATHER:
			clothes.visible = false
			leather_armor.visible = true


func _change_head() -> void:
	match _head:
		Globals.Head.MALE1:
			male_head_1.visible = true


func _change_shield() -> void:
	match _shield:
		Globals.Shield.NONE:
			buckler.visible = false
		Globals.Shield.BUCKLER:
			buckler.visible = true


func _change_weapon() -> void:
	match _weapon:
		Globals.Weapon.NONE:
			dagger.visible = false
		Globals.Weapon.DAGGER:
			dagger.visible = true


func _change_bow() -> void:
	match _bow:
		Globals.Bow.NONE:
			shortbow.visible = false
		Globals.Bow.SHORTBOW:
			shortbow.visible = true


func _physics_process(_delta) -> void:
	if is_alive:
		_switch_items()
		_animation()
		_movement()
	else:
		if !death_animation_played:
			dying()


func _movement() -> void:
	if !Globals.lock_shown:
		move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		move_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
		velocity = move_direction.normalized() * SPEED
		move_and_slide()


func _switch_items() -> void:
	if Input.is_action_just_pressed("change_weapon"):
		dagger.visible = !dagger.visible
	if Input.is_action_just_pressed("change_shield"):
		buckler.visible = !buckler.visible
	if Input.is_action_just_pressed("change_bow"):
		shortbow.visible = !shortbow.visible
	if Input.is_action_just_pressed("inventory"):
		$Inventory.visible = !$Inventory.visible


func _animation() -> void:
	if is_alive:
		if Input.is_action_pressed("left_mouse"):
			action = "melee"
		elif Input.is_action_pressed("right_mouse"):
			action = "block"
		elif move_direction.x == 0 and move_direction.y == 0:
			action = "stance"
			
		if move_direction.x == -1 and move_direction.y == 0:
			direction = "_w"
			action = "running"
		elif move_direction.x == -1 and move_direction.y == 0.5:
			direction = "_sw"
			action = "running"
		elif move_direction.x == -1 and move_direction.y == -0.5:
			direction = "_nw"
			action = "running"
		elif move_direction.x == 0 and move_direction.y == -0.5:
			direction = "_n"
			action = "running"
		elif move_direction.x == 1 and move_direction.y == -0.5:
			direction = "_ne"
			action = "running"
		elif move_direction.x == 1 and move_direction.y == 0:
			direction = "_e"
			action = "running"
		elif move_direction.x == 1 and move_direction.y == 0.5:
			direction = "_se"
			action = "running"
		elif move_direction.x == 0 and move_direction.y == 0.5:
			direction = "_s"
			action = "running"
		
		var animation = action + direction
		show_item_animation(animation)


func show_item_animation(animation: String) -> void:
	if clothes.visible:
		clothes.play(animation)
	if dagger.visible:
		dagger.play(animation)
	if male_head_1.visible:
		male_head_1.play(animation)
	if leather_armor.visible:
		leather_armor.play(animation)
	if buckler.visible:
		buckler.play(animation)
	if shortbow.visible:
		shortbow.play(animation)


func dying() -> void:
	death_animation_played = true
	action = "die"
	var animation = action + direction
	show_item_animation(animation)
	$AudioDying.play()
	$EndGameTimer.start()


func _on_end_game_timer_timeout():
	SceneManager.SwitchScene("EndGame")
