class_name HungerComponent extends Node

signal ChangeHunger
signal ReduceHealth

var _max_hunger: int = 100
var current_hunger: int
@export var _reduce_over_time: int = 10


func _ready() -> void:
	current_hunger = _max_hunger
	ChangeHunger.emit()


func reduce_hunger(reduction: int) -> void:
	current_hunger -= reduction
	if current_hunger < 0:
		current_hunger = 0
		ReduceHealth.emit(reduction)
	ChangeHunger.emit()


func add_food(hunger: int) -> void:
	current_hunger += hunger
	if current_hunger > _max_hunger:
		current_hunger = _max_hunger
	ChangeHunger.emit()


func _on_timer_timeout() -> void:
	reduce_hunger(_reduce_over_time)
	$Timer.start()
