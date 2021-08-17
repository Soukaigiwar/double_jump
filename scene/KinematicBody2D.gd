extends KinematicBody2D

# to make a variable range within min and max value
# export(type, min, max, step) var NAME = Default value
export(int, 125, 300, 25) var SPEED = 125
export(int, 10, 40, 5) var GRAVITY = 20
export(int, -1000, -300, 50) var JUMP_POWER = -500
const FLOOR = Vector2(0, -1)

# start on_ground state as false
# and double_jump count as 0
var on_ground = false
var double_jump = 0
var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and \
	not Input.is_action_pressed("ui_left"):
		velocity.x = SPEED
		$Anim.flip_h = false
		
	elif Input.is_action_pressed("ui_left") and \
	not Input.is_action_pressed("ui_right"):
		velocity.x = -SPEED
		$Anim.flip_h = true
	else:
		velocity.x = 0

	# check if input button Jump (in this case, spacebar) is just pressed
	# I use is_action_just_pressed rather than is_action_pressed to prevent
	# hold Jump button and repeat input. just_pressed will count only one time
	if Input.is_action_just_pressed("ui_jump"):
		# check if double_jump counter is < 2
		# if yes, increment double_jump by 1
		# do jump movement and set on_ground as false
		# as double is < 2, it allow perform a second jump, but in the next
		# jump, the double_jump will set to 2 and it is no more < 2, then
		# the above if statement will be false, 
		# no allowing jump any more, unless the player touch ground again
		# change on_gound back to true value.
		if double_jump < 2:
			double_jump += 1
			velocity.y = JUMP_POWER
			on_ground = false
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

	# if player is falling from a plataform without perform a jump, 
	# just falling from the edge, it il set double_jump counter to 2
	# disallowing to perform a jump.
	if is_on_floor():
		if on_ground == false:
			on_ground = true
			double_jump = 0
	else:
		if on_ground == true:
			on_ground = false
			double_jump = 2
