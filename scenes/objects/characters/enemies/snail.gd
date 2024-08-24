extends RigidBody2D

@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var moving = false

var is_shell = false
var is_moving_shell = false
var hit_from_up = false

var pineapple = load("res://scenes/objects/items/collectables/pineapple.tscn")
var apple = load("res://scenes/objects/items/collectables/apple.tscn")
var bananas = load("res://scenes/objects/items/collectables/bananas.tscn")
var cherries = load("res://scenes/objects/items/collectables/cherries.tscn")
var kiwi = load("res://scenes/objects/items/collectables/kiwi.tscn")
var melon = load("res://scenes/objects/items/collectables/melon.tscn")
var orange = load("res://scenes/objects/items/collectables/orange.tscn")
var strawberry = load("res://scenes/objects/items/collectables/strawberry.tscn")

var fruits = [pineapple, apple, bananas, cherries, kiwi, melon, orange, strawberry]

@export var reversedDirection : bool = false
var isLeft = 0

@export var lockPositionY : bool = false
@export var lockPositionX : bool = false
var lock_position_y = 0
var lock_position_x = 0

func _ready():
	if(moving):
		animated_sprite_2d.play("run")
	lock_position_x = position.x
	lock_position_y = position.y

func _process(delta):
	if(lockPositionX):
		position.x = lock_position_x
	if(lockPositionY):
		position.y = lock_position_y
	
	if((moving and not is_shell) or is_moving_shell):
		if(isLeft):
			position.x += delta * (500 if is_shell else 50)
		else:
			position.x -= delta * (500 if is_shell else 50)
		if(reversedDirection):
			animated_sprite_2d.flip_h = not isLeft
		else:
			animated_sprite_2d.flip_h = isLeft

func _on_area_2d_body_entered(body):
	if(body.get_name() == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print(body.position.y)
		print(position.y)
		if(y_delta > 3):
			if(is_shell):
				animated_sprite_2d.play("shell_hit_top")
				hit_from_up = true
				
			else:
				animated_sprite_2d.play("hit")
			body.display_particle()
			body.jump()
			body.play_enemy_kill_sound()
		else:
			if(is_shell and not is_moving_shell):
				is_moving_shell = true
				animated_sprite_2d.play("shell_hit_side")
			else:
				game_manager.decrease_health()
				body.play_hurt_sound()
				body.hit()
			if(x_delta > 0):
				body.jump_back(250)
				isLeft = false
			else:
				body.jump_back(-250)
				isLeft = true
	print(body.get_name())

func _on_animated_sprite_2d_animation_finished():
	display_random_fruit()
	if(is_shell and hit_from_up):
		if(is_moving_shell):
			queue_free()
		else:
			hit_from_up = false
			animated_sprite_2d.play("shell_idle")
			is_moving_shell = true
	else:
		is_shell = true
		animated_sprite_2d.play("shell_idle")

func _on_area_2d_area_entered(area):
	if area.get_name().begins_with("border") and (not is_shell or not area.get_meta("destroy_shell")):
		isLeft = not isLeft
	elif (area.get_meta("destroy_shell") and is_shell):
		hit_from_up = true
		animated_sprite_2d.play("shell_hit_side")
	print(area.get_name())
	
func display_random_fruit():
	var random_fruit = fruits[randi() % fruits.size()]
	var fruit_node = random_fruit.instantiate()
	fruit_node.position = position
	get_parent().add_child(fruit_node)
