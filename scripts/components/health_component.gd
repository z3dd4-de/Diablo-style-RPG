class_name HealthComponent extends Node

@export var max_health: int = 100
@export var thirst: ThirstComponent
@export var hunger: HungerComponent

var current_health: int

signal HasDied
signal HealthChanged


func _ready() -> void:
	current_health = max_health
	thirst.ReduceHealth.connect(receive_damage)
	hunger.ReduceHealth.connect(receive_damage)


func receive_damage(damage: int) -> void:
	current_health -= damage
	HealthChanged.emit()
	check_death()


func restore_health(health: int) -> void:
	current_health += health
	HealthChanged.emit()
	if current_health > max_health:
		current_health = max_health


func check_death() -> void:
	if current_health <= 0:
		current_health = 0
		HasDied.emit()


func change_max_health(health: int) -> void:
	max_health += health
	HealthChanged.emit()
