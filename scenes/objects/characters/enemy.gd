extends RigidBody2D

func _on_area_2d_body_entered(body):
	if(body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		print(body.position.y)
		print(position.y)
		if(y_delta > 10):
			queue_free()
			body.jump()
		else:
			body.queue_free()
