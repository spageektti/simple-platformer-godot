extends Node

@onready var level_1_label = %level1Label
@onready var level_2_label = %level2Label
@onready var level_3_label = %level3Label
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
		# Level 4
		var best_points_health_4 = config_file.get_value("level4_best_points", "health", "0")
		var best_points_points_4 = config_file.get_value("level4_best_points", "points", "0")
		var best_points_time_4 = config_file.get_value("level4_best_points", "time", "0")
		var best_time_health_4 = config_file.get_value("level4_best_time", "health", "0")
		var best_time_points_4 = config_file.get_value("level4_best_time", "points", "0")
		var best_time_time_4 = config_file.get_value("level4_best_time", "time", "0")

		level_4_label.text = "Best points:\n" + str(best_points_points_4) + "$ | " + str(best_points_time_4) + "s | " + str(best_points_health_4) + "HP\n"
		level_4_label.text += "Best time:\n" + str(best_time_points_4) + "$ | " + str(best_time_time_4) + "s | " + str(best_time_health_4) + "HP\n"

		# Level 3
		var best_points_health_3 = config_file.get_value("level3_best_points", "health", "0")
		var best_points_points_3 = config_file.get_value("level3_best_points", "points", "0")
		var best_points_time_3 = config_file.get_value("level3_best_points", "time", "0")
		var best_time_health_3 = config_file.get_value("level3_best_time", "health", "0")
		var best_time_points_3 = config_file.get_value("level3_best_time", "points", "0")
		var best_time_time_3 = config_file.get_value("level3_best_time", "time", "0")

		level_3_label.text = "Best points:\n" + str(best_points_points_3) + "$ | " + str(best_points_time_3) + "s | " + str(best_points_health_3) + "HP\n"
		level_3_label.text += "Best time:\n" + str(best_time_points_3) + "$ | " + str(best_time_time_3) + "s | " + str(best_time_health_3) + "HP\n"

		# Level 2
		var best_points_health_2 = config_file.get_value("level2_best_points", "health", "0")
		var best_points_points_2 = config_file.get_value("level2_best_points", "points", "0")
		var best_points_time_2 = config_file.get_value("level2_best_points", "time", "0")
		var best_time_health_2 = config_file.get_value("level2_best_time", "health", "0")
		var best_time_points_2 = config_file.get_value("level2_best_time", "points", "0")
		var best_time_time_2 = config_file.get_value("level2_best_time", "time", "0")

		level_2_label.text = "Best points:\n" + str(best_points_points_2) + "$ | " + str(best_points_time_2) + "s | " + str(best_points_health_2) + "HP\n"
		level_2_label.text += "Best time:\n" + str(best_time_points_2) + "$ | " + str(best_time_time_2) + "s | " + str(best_time_health_2) + "HP\n"

		# Level 1
		var best_points_health_1 = config_file.get_value("level1_best_points", "health", "0")
		var best_points_points_1 = config_file.get_value("level1_best_points", "points", "0")
		var best_points_time_1 = config_file.get_value("level1_best_points", "time", "0")
		var best_time_health_1 = config_file.get_value("level1_best_time", "health", "0")
		var best_time_points_1 = config_file.get_value("level1_best_time", "points", "0")
		var best_time_time_1 = config_file.get_value("level1_best_time", "time", "0")

		level_1_label.text = "Best points:\n" + str(best_points_points_1) + "$ | " + str(best_points_time_1) + "s | " + str(best_points_health_1) + "HP\n"
		level_1_label.text += "Best time:\n" + str(best_time_points_1) + "$ | " + str(best_time_time_1) + "s | " + str(best_time_health_1) + "HP\n"

	else:
		print("There was some errors getting stats from a file: ", error, "Report this err to contact@spageektti.cc")
