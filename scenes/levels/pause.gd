extends Node

@onready var pause_panel = %Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pressed = Input.is_action_just_pressed("pause")
	if(pressed):
		get_tree().paused = true
		pause_panel.show()


func _on_resume_pressed():
	get_tree().paused = false
	pause_panel.hide()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
