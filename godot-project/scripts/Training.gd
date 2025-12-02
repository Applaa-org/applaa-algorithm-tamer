extends Control

var current_algorithm: String = "Engagio"
var algorithm_options = ["Engagio", "Reacho", "Viralo"]
var current_index: int = 0

func _ready():
	update_ui()
	$VBoxContainer/FeedButton.pressed.connect(_on_feed_pressed)
	$VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/BackButton.pressed.connect(_on_back_pressed)
	$VBoxContainer/PrevButton.pressed.connect(_on_prev_pressed)
	$VBoxContainer/NextButton.pressed.connect(_on_next_pressed)

func update_ui():
	current_algorithm = algorithm_options[current_index]
	var algo = Global.algorithms[current_algorithm]
	$VBoxContainer/AlgorithmLabel.text = current_algorithm
	$VBoxContainer/MoodLabel.text = "Mood: " + str(algo["mood"])
	$VBoxContainer/ReachLabel.text = "Reach: " + str(algo["reach"]) + "/" + str(algo["max_reach"])
	$VBoxContainer/ScoreLabel.text = "Score: " + str(Global.score)

func _on_feed_pressed():
	if Global.algorithms[current_algorithm]["caught"]:
		Global.train_algorithm(current_algorithm, "feed")
		update_ui()
		check_conditions()

func _on_play_pressed():
	if Global.algorithms[current_algorithm]["caught"]:
		Global.train_algorithm(current_algorithm, "play")
		update_ui()
		check_conditions()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_prev_pressed():
	current_index = (current_index - 1 + algorithm_options.size()) % algorithm_options.size()
	update_ui()

func _on_next_pressed():
	current_index = (current_index + 1) % algorithm_options.size()
	update_ui()

func check_conditions():
	if Global.check_victory():
		get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
	elif Global.check_defeat():
		get_tree().change_scene_to_file("res://scenes/DefeatScreen.tscn")