extends CharacterBody2D

@onready var moving_platform = $"."
var curr_position
var end_position
var offset
var moving_direction = 0 # 0 - moving right, 1 - moving left (back to start)
var start_position
var speed
var move_y

# Called when the node enters the scene tree for the first time.
func _ready():
	var all_meta = moving_platform.get_meta_list()
	print("Available metadata keys: ", all_meta)

	offset = moving_platform.get_meta("move_offset")
	speed = moving_platform.get_meta("speed")
	move_y = moving_platform.get_meta("move_y")
	
	curr_position = moving_platform.position.y if move_y else moving_platform.position.x 
	start_position = curr_position
	end_position = start_position - offset if move_y else start_position + offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print("c: " + str(curr_position))
	# print("s: " + str(start_position))
	# print("e: " + str(end_position))
	# print("d: " + str(moving_direction))
	# print("o: " + str(offset))
	if(move_y):
		if(moving_direction == 0):
			position.y -= delta * speed
			if(int(moving_platform.position.y) <= int(end_position)):
				moving_direction = 1
		else:
			position.y += delta * speed
			if(int(moving_platform.position.y) >= int(start_position)):
				moving_direction = 0
	else:
		if(moving_direction == 0):
			position.x += delta * speed
			if(int(moving_platform.position.x) >= int(end_position)):
				moving_direction = 1
		else:
			position.x -= delta * speed
			if(int(moving_platform.position.x) <= int(start_position)):
				moving_direction = 0
