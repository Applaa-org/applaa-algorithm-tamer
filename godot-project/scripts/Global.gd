extends Node

var score: int = 0
var algorithms = {
	"Engagio": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
	"Reacho": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false},
	"Viralo": {"mood": 50, "reach": 0, "max_reach": 100, "caught": false}
}

func add_score(points: int):
	score += points

func reset_score():
	score = 0

func catch_algorithm(name: String):
	if algorithms.has(name):
		algorithms[name]["caught"] = true
		add_score(50)

func train_algorithm(name: String, action: String):
	if algorithms.has(name) and algorithms[name]["caught"]:
		if action == "feed":
			algorithms[name]["mood"] += 10
		elif action == "play":
			algorithms[name]["reach"] += 5
			add_score(20)
		algorithms[name]["mood"] = clamp(algorithms[name]["mood"], 0, 100)
		algorithms[name]["reach"] = clamp(algorithms[name]["reach"], 0, algorithms[name]["max_reach"])

func check_victory():
	for algo in algorithms.values():
		if not algo["caught"] or algo["reach"] < algo["max_reach"]:
			return false
	return true

func check_defeat():
	for algo in algorithms.values():
		if algo["caught"] and algo["mood"] <= 0:
			return true
	return false