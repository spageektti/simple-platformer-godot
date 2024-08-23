extends Node

var points := 0
var lives := 3.0
var time := 0.0

var full_heart = load("res://assets/objects/hearts/heart.png")
var half_heart = load("res://assets/objects/hearts/half_heart.png")
var no_heart = load("res://assets/objects/hearts/no_heart.png")

@export var hearts : Array[Node]
@export var scene_name : String
@onready var points_label = %pointsLabel
@onready var timer = %timer

func decrease_health():
	lives -= 0.5
	print(lives)
	for heart in 3:
		if(heart + 1 <= lives):
			hearts[heart].texture = full_heart
		elif(heart +1 <= lives + 0.5):
			hearts[heart].texture = half_heart
		else:
			hearts[heart].texture = no_heart
	if(lives == 0):
		get_tree().reload_current_scene()

func add_point():
	points += 1
	print(points)
	points_label.text = "Points: " + str(points)
	
func _process(delta):
	time += delta
	timer.text = str(round(time * 10000) / 10000)
	

func save_stats():
	var save_path = "user://data.ini"
	var config_file = ConfigFile.new()

	config_file.set_value(scene_name, "health", lives)
	config_file.set_value(scene_name, "points", points)
	config_file.set_value(scene_name, "time", time)

	var error = config_file.save(save_path)
	if error:
		print("There was some errors when saving stats to a file: ", error, "Report this err to contact@spageektti.cc")
	else:
		print("Saved data for scene ", scene_name)
