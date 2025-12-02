extends Node2D

@onready var score_label = $ScoreLabel

func _process(delta: float):
	score_label.text = "Score: %d" % Global.score
	
	# Check for victory or defeat
	if Global.check_victory():
		get_tree().change_scene_to_file("res://scenes/VictoryScreen.tscn")
	elif Global.check_defeat():
		get_tree().change_scene_to_file("res://scenes/DefeatScreen.tscn")