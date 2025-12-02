extends Control

var current_algorithm: String = "Engagio"

func _ready():
	update_ui()
	$VBoxContainer/FeedButton.pressed.connect(_on_feed_pressed)
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)

func update_ui():
	var algo = Global.algorithms[current_algorithm]
	$VBoxContainer/AlgorithmLabel.text = current_algorithm
	$VBoxContainer/MoodLabel.text = "Mood: " + str(algo["mood"])
	$VBoxContainer/ReachLabel.text = "Reach: " + str(algo["reach"]) + "/" + str(algo["max_reach"])
	$VBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)

func _on_feed_pressed():
	Global.train_algorithm(current_algorithm, "feed")
	update_ui()
	if Global.check_victory():
		get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
	elif Global.check_defeat():
		get_tree().change_scene_to_file("res://scenes/DefeatScreen.tscn")

func _on_play_pressed():
	Global.train_algorithm(current_algorithm, "play")
	update_ui()
	if Global.check_victory():
		get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
	elif Global.check_defeat():
		get_tree().change_scene_to_file("res://scenes/DefeatScreen.tscn")

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")