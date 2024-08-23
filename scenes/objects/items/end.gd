extends Area2D

@export var target_level : PackedScene
@onready var game_manager = %GameManager

func _on_body_entered(body):
	if(body.name == "CharacterBody2D"):
		game_manager.save_stats()
		get_tree().change_scene_to_packed(target_level)
