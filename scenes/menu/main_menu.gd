extends Node

@onready var level_4_label = %level4Label

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level3.tscn")

func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level4.tscn")

func _ready():
	load_stats()
	
func load_stats():
	var save_path = "user://data.ini"
	var config_file = ConfigFile.new()
	var error = config_file.load(save_path)

	if error == OK:
		var health = config_file.get_value("level4", "health", "N/A")
		var points = config_file.get_value("level4", "points", "N/A")
		var time = config_file.get_value("level4", "time", "N/A")

		level_4_label.text = str(points) + "$ | " + str(time) + "s | " + str(health) + "HP"
	else:
		print("There was an error loading stats from the file: ", error)
