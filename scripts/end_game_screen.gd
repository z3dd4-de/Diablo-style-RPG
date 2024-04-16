extends Node2D

var done = false


func _ready() -> void:
	update()
	

func update() -> void:
	if !done:
		Globals.end_time = Time.get_unix_time_from_system()
		var time_played = int(Globals.end_time - Globals.start_time)
		var hours = time_played / 3600
		time_played = time_played % 3600
		var minutes = time_played / 60
		time_played = time_played % 60
		var seconds = time_played
		var min_str
		if minutes < 10:
			min_str = "0" + str(minutes)
		else:
			min_str = str(minutes)
		var sec_str
		if seconds < 10:
			sec_str = "0" + str(seconds)
		else:
			sec_str = str(seconds)
		var timestring = str(hours) + ":" + min_str + ":" + sec_str 
		$CanvasLayer/EndGameRichTextLabel.text = "\nYou played the game for \n" + timestring + " hours\nand died on day " + str(Globals.current_day) + "."
		done = true


func _on_main_menu_button_pressed() -> void:
	SceneManager.SwitchScene("Menu")


func _on_exit_game_button_pressed() -> void:
	SceneManager.QuitGame()
