extends RigidBody2D

@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var moving = false

var isLeft = 0

func _process(delta):
	if(moving):
		if(isLeft):
			position.x += delta * 50
		else:
			position.x -= delta * 50
		animated_sprite_2d.flip_h = isLeft

func _on_area_2d_body_entered(body, delta):
	if(body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print(body.position.y)
		print(position.y)
		if(y_delta > 10):
			animated_sprite_2d.play("hit")
			body.display_particle()
			body.jump()
			game_manager.add_point()
		else:
			game_manager.decrease_health()
			body.hit()
			if(x_delta > 0):
				body.jump_back(250)
			else:
				body.jump_back(-250)
	elif(body.name == "border"):
		isLeft = not isLeft

func _on_animated_sprite_2d_animation_finished():
	queue_free()
