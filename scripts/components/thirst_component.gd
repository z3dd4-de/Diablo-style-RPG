class_name ThirstComponent extends Node

signal ChangeThirst
signal ReduceHealth

var _max_water: int = 100
var current_water: int
@export var _reduce_over_time: int = 10


func _ready() -> void:
	current_water = _max_water
	ChangeThirst.emit()


func reduce_water(reduction: int) -> void:
	current_water -= reduction
	if current_water < 0:
		current_water = 0
		ReduceHealth.emit(reduction)
	ChangeThirst.emit()


func add_water(water: int) -> void:
	current_water += water
	if current_water > _max_water:
		current_water = _max_water
	ChangeThirst.emit()


func _on_timer_timeout() -> void:
	reduce_water(_reduce_over_time)
	$Timer.start()
