extends Node2D
class_name Questlog

var title: String
var entry: String
var page: int
var is_open: bool = false
var content: Dictionary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("front")
	page = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
