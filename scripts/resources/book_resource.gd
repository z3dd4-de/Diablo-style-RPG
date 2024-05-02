class_name BookResource extends Resource

@export var type: Globals.BookType
@export var book_name: String
@export var level: int
@export var points: int
@export var description: String
@export var image: Texture


func get_type() -> Globals.BookType:
	return type


func get_title() -> String:
	return book_name


func get_menu_button() -> String:
	return "Level " + str(level)


func get_points_label() -> String:
	return str(level * 5)


func get_description() -> String:
	return description


func get_image() -> Texture:
	return image
