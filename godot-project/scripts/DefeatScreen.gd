extends Control

func _ready():
	$VBoxContainer/ScoreLabel.text = "Final Score: " + str(Global.score)
	$VBoxContainer/RestartButton.pressed.connect(_on_restart_pressed)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu_pressed)
	$VBoxContainer/CloseButton.pressed.connect(_on_close_pressed)

func _on_restart_pressed():
	Global.reset_score()
	Global.algorithms = {
		"Engagio": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
		"Reacho": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
		"Viralo": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false}
	}
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_main_menu_pressed():
	Global.reset_score()
	Global.algorithms = {
		"Engagio": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
		"Reacho": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
		"Viralo": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false}
	}
	get_tree().change_scene_to_file("res://scenes/StartScreen.tscn")

func _on_close_pressed():
	get_tree().quit()