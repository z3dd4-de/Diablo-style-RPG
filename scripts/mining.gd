extends StaticBody2D

var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _mining():
	if $Inventory.visible == true:
		$Inventory.visible = false
	else:
		$Inventory.visible = true


func _input(event):
	if event.is_action_pressed("pick_item") and player != null:
		_mining()


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		player = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		player = null
