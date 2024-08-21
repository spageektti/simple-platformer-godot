extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450.0

@onready var sprite_2d = $Sprite2D
@export var double_jump_allowed : bool # shouldn't be enabled on all levels and maybe I will add difficulty levels in future
@export var double_jump_offset : float = 125.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

func _physics_process(delta):
	if(velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta
		sprite_2d.animation = "jump"

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
		velocity.y = JUMP_VELOCITY + double_jump_offset

func jump_back(x): # get away from the enemy, I don't know if it's right translation from Polish "odskoczyć"
	jump()
	velocity.x = x
	
func hit():
	sprite_2d.animation = "hit"
