class_name Experience extends Node

var expierence: int = 0
var level: int = 1

signal LevelUp

func gain_exp(_exp: int) -> void:
	expierence += _exp
	test_level()


func test_level() -> void:
	pass
