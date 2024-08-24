extends Area2D

var particle = load("res://scenes/objects/particles.tscn")

func _on_body_entered(body):
	if(body.name == "CharacterBody2D"):
		display_particle()
		queue_free()
		body.add_point()
		body.play_collectable_sound()

func display_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
