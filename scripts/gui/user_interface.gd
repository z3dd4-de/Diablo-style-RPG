class_name GUI extends CanvasLayer

@export var hero: Hero
@onready var health_progress_bar = $ProgressbarsPanel/VBoxContainer/HealthProgressBar
@onready var hunger_progress_bar = $ProgressbarsPanel/VBoxContainer/HungerProgressBar
@onready var thirst_progress_bar = $ProgressbarsPanel/VBoxContainer/ThirstProgressBar


func _ready() -> void:
	hero.thirst.ChangeThirst.connect(_change_thirst)
	hero.health.HealthChanged.connect(_change_health)
	hero.hunger.ChangeHunger.connect(_change_hunger)
	Globals.CloseGUI.connect(switch_visibility)


func switch_visibility():
	self.visible = !self.visible


func _process(_delta) -> void:
	_change_health()
	_change_hunger()
	_change_thirst()


func _change_health() -> void:
	health_progress_bar.value = hero.health.current_health


func _change_thirst() -> void:
	thirst_progress_bar.value = hero.thirst.current_water


func _change_hunger() -> void:
	hunger_progress_bar.value = hero.hunger.current_hunger
	

func change_visibility() -> void:
	self.visible = !self.visible
