extends RigidBody2D

@onready var game_manager = %GameManager
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var moving = false

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
	
	if(moving):
		if(isLeft):
			position.x += delta * 50
		else:
			position.x -= delta * 50
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
		if(y_delta > 10):
			animated_sprite_2d.play("hit")
			body.display_particle()
			body.jump()
		else:
			game_manager.decrease_health()
			body.hit()
			if(x_delta > 0):
				body.jump_back(250)
			else:
				body.jump_back(-250)
	print(body.get_name())

func _on_animated_sprite_2d_animation_finished():
	display_random_fruit()
	queue_free()

func _on_area_2d_area_entered(area):
	if area.get_name().begins_with("border"):
		isLeft = not isLeft
	print(area.get_name())
	
func display_random_fruit():
	var random_fruit = fruits[randi() % fruits.size()]
	var fruit_node = random_fruit.instantiate()
	fruit_node.position = position
	get_parent().add_child(fruit_node)
