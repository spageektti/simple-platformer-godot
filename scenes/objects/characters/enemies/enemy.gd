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

@export var isInitiallyLeft : int = 0
var isLeft = isInitiallyLeft

func _ready():
	if(moving):
		animated_sprite_2d.play("run")

func _process(delta):
	if(moving):
		if(isLeft):
			position.x += delta * 50
		else:
			position.x -= delta * 50
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
