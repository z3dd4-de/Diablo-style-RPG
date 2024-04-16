class_name Plant extends Node2D

var plant_type = [ "PLANT1", "PLANT2", "PLANT3", "PLANT4", "PLANT5", "PLANT6", "PLANT7", "PLANT8" ] 
enum state { READY, NOT_READY }
@export var my_id: int

var my_type: String
@export var random: bool

var growth_time = [ 15, 30, 60, 120, 360, 420, 480, 600 ]
var my_growth_time


var my_state
var harvestable: bool = false
var player: Hero


func _ready() -> void:
	my_state = state.NOT_READY
	$Label.visible = false
	randomize()
	if random:
		my_id = randf_range(0, 7)
	else:
		if my_id >= 0 && my_id < 8:
			my_type = plant_type[my_id]
			my_growth_time = growth_time[my_id]
			
		else:
			my_type = plant_type[0]
			my_growth_time = growth_time[0]
		_start_timer(my_growth_time)
		_animation()
			


func _start_timer(wait: int) -> void:
	#print("Timer: " + my_type + " id: " + str(my_id) + " (" + str(wait) + " secs)")
	$Timer.start(wait)


func _animation() -> void: 
	$Plant1.visible = false
	$Plant2.visible = false
	$Plant3.visible = false
	$Plant4.visible = false
	$Plant5.visible = false
	$Plant6.visible = false
	$Plant7.visible = false
	$Plant8.visible = false
	match my_id:
		0:
			if my_state == state.READY:
				$Plant1.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
				harvestable = true
			else:
				$Plant1.play("not_ready")
			$Plant1.visible = true
		1:
			if my_state == state.READY:
				$Plant2.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant2.play("not_ready")
			$Plant2.visible = true
		2:
			if my_state == state.READY:
				$Plant3.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant3.play("not_ready")
			$Plant3.visible = true
		3:
			if my_state == state.READY:
				$Plant4.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant4.play("not_ready")
			$Plant4.visible = true
		4:
			if my_state == state.READY:
				$Plant5.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant5.play("not_ready")
			$Plant5.visible = true
		5:
			if my_state == state.READY:
				$Plant6.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant6.play("not_ready")
			$Plant6.visible = true
		6:
			if my_state == state.READY:
				$Plant7.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant7.play("not_ready")
			$Plant7.visible = true
		7:
			if my_state == state.READY:
				$Plant8.play("ready")
				if !my_type.contains("ready"):
					my_type += " (ready)"
			else:
				$Plant8.play("not_ready")
			$Plant8.visible = true
	$Label.text = my_type


func _on_timer_timeout() -> void:
	my_state = state.READY
	_animation()


func _harvest() -> void:
	if player != null and my_state == state.READY:
		self.queue_free()
		Globals.send_message(my_type + " harvested")


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		_harvest()


func _on_harvest_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body
		$Label.visible = true


func _on_harvest_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null
		$Label.visible = false
