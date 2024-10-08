extends RigidBody2D

@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D

var spikes_on := false
var loop_count := 0
var curr_action := 0 # 0 - spikes in | 1 - spikes out | 2 - death

var pineapple = load("res://scenes/objects/items/collectables/pineapple.tscn")
var apple = load("res://scenes/objects/items/collectables/apple.tscn")
var bananas = load("res://scenes/objects/items/collectables/bananas.tscn")
var cherries = load("res://scenes/objects/items/collectables/cherries.tscn")
var kiwi = load("res://scenes/objects/items/collectables/kiwi.tscn")
var melon = load("res://scenes/objects/items/collectables/melon.tscn")
var orange = load("res://scenes/objects/items/collectables/orange.tscn")
var strawberry = load("res://scenes/objects/items/collectables/strawberry.tscn")

var fruits = [pineapple, apple, bananas, cherries, kiwi, melon, orange, strawberry]

func _on_area_2d_body_entered(body):
	if(body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print(body.position.y)
		print(position.y)
		if(y_delta > 10 and not spikes_on):
			animated_sprite_2d.play("hit")
			body.display_particle()
			body.jump()
			curr_action = 2
			body.play_enemy_kill_sound()
		else:
			game_manager.decrease_health()
			if(spikes_on): #damage more when spikes on
				game_manager.decrease_health()
			body.hit()
			body.play_hurt_sound()
			if(x_delta > 0):
				body.jump_back(250)
			else:
				body.jump_back(-250)

func _on_animated_sprite_2d_animation_finished():
	print("finished animation, curr action:")
	print(curr_action)
	if(curr_action == 2):
		display_random_fruit()
		queue_free()
	elif(curr_action == 0):
		spikes_on = true
		animated_sprite_2d.play("spikes")
	elif(curr_action == 1):
		spikes_on = false
		animated_sprite_2d.play("default")

func _on_animated_sprite_2d_animation_looped():
	loop_count += 1
	print(loop_count)
	if(animated_sprite_2d.animation == "default" and loop_count == 3):
		curr_action = 0
		loop_count = 0
		animated_sprite_2d.play("spikes_in")
		
	elif(animated_sprite_2d.animation == "spikes" and loop_count == 2):
		curr_action = 1
		loop_count = 0
		animated_sprite_2d.play("spikes_out")
		
func display_random_fruit():
	var random_fruit = fruits[randi() % fruits.size()]
	var fruit_node = random_fruit.instantiate()
	fruit_node.position = position
	get_parent().add_child(fruit_node)
