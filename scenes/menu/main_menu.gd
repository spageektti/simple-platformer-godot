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
		var best_points_health = config_file.get_value("level4_best_points", "health", "0")
		var best_points_points = config_file.get_value("level4_best_points", "points", "0")
		var best_points_time = config_file.get_value("level4_best_points", "time", "0")
		var best_time_health = config_file.get_value("level4_best_time", "health", "0")
		var best_time_points = config_file.get_value("level4_best_time", "points", "0")
		var best_time_time = config_file.get_value("level4_best_time", "time", "0")


		level_4_label.text = "Best points:\n" + str(best_points_points) + "$ | " + str(best_points_time) + "s | " + str(best_points_health) + "HP\n"
		level_4_label.text += "Best time:\n" + str(best_time_points) + "$ | " + str(best_time_time) + "s | " + str(best_time_health) + "HP\n"
	else:
		print("There was some errors getting stats from a file: ", error, "Report this err to contact@spageektti.cc")
