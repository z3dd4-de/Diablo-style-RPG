class_name Book extends StaticBody2D

@export var book_type: Globals.BookType
@export var level: int
var book: Resource
var player: CharacterBody2D


func _ready() -> void:
	player = null
	all_invisible()
	match book_type:
		Globals.BookType.ALCHEMY:
			$Book7.visible = true
		Globals.BookType.ARROWS:
			$Book10.visible = true
		Globals.BookType.BLACKSMITH:
			$Book6.visible = true
		Globals.BookType.CASTING:
			$Book1.visible = true
		Globals.BookType.COOKING:
			$Book13.visible = true
		Globals.BookType.CRAFTING:
			$Book14.visible = true
		Globals.BookType.HEALING:
			$Book15.visible = true
		Globals.BookType.PERSONALITY:
			$Book17.visible = true
		Globals.BookType.REPAIR:
			$Book4.visible = true
		Globals.BookType.VENDOR:
			$Book5.visible = true
	#$BookLabel.text = book_name


func all_invisible() -> void:
	$Book1.visible = false
	$Book2.visible = false
	$Book3.visible = false
	$Book4.visible = false
	$Book5.visible = false
	$Book6.visible = false
	$Book7.visible = false
	$Book8.visible = false
	$Book9.visible = false
	$Book10.visible = false
	$Book11.visible = false
	$Book12.visible = false
	$Book13.visible = false
	$Book14.visible = false
	$Book15.visible = false
	$Book16.visible = false
	$Book17.visible = false
	$Book18.visible = false
	

func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player"):
		player = body
		$BookLabel.visible = true


func _on_area_2d_body_exited(body) -> void:
	if body.is_in_group("Player"):
		player = null
		$BookLabel.visible = false


func _input(event) -> void:
	if event.is_action_pressed("pick_item") and player != null:
		self.queue_free()
