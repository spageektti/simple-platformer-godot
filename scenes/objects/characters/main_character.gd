extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var sprite_2d = $Sprite2D
@export var double_jump_allowed : bool # shouldn't be enabled on all levels and maybe I will add difficulty levels in future
@export var double_jump_offset : float = 125.0
@export var game_manager : Node
var particle = load("res://scenes/objects/particles.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

func _physics_process(delta):
	
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
		
		if(sprite_2d.animation == "hit"):
			pass
		elif(velocity.x > 1 || velocity.x < -1):
			if(sprite_2d.animation != "run"):
				sprite_2d.play("run")
		else:
			sprite_2d.animation = "default"
	else:
		velocity.y += gravity * delta
		if(sprite_2d.animation != "hit"):
			if(velocity.y > 0):
				sprite_2d.animation = "fall"
			elif(jump_count == 1):
				sprite_2d.animation = "jump"
			elif(jump_count == 2):
				sprite_2d.play("double_jump")
					

	# Handle jump.
	if Input.is_action_just_pressed("up") and (jump_count < 1 or (jump_count < 2 and double_jump_allowed)):
		jump()
		jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 13)

	move_and_slide()
	
	if(velocity.x != 0): #stay in the curr direction when player not moving
		var isLeft = velocity.x < 0
		sprite_2d.flip_h = isLeft

func jump():
	if(jump_count < 1):
		velocity.y = JUMP_VELOCITY
	else:
		display_particle()
		velocity.y = JUMP_VELOCITY + double_jump_offset

func jump_back(x): # get away from the enemy, I don't know if it's right translation from Polish "odskoczyć"
	jump()
	velocity.x = x
	
func hit():
	sprite_2d.play("hit")
	
func _on_sprite_2d_animation_finished():
	print(sprite_2d.animation)
	if(sprite_2d.animation == "hit"):
		sprite_2d.animation = "default"

func display_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(1).timeout
	particle_node.queue_free()
	
func add_point():
	game_manager.add_point()
