extends KinematicBody2D

const SPEED = 200
const GRAVITY = 30
const JUMP_POWER = -700
const FLOOR = Vector2(0, -1)

var on_ground = false
var double_jump = 0
var velocity = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		velocity.x = SPEED
		
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		velocity.x = -SPEED
	else:
		velocity.x = 0

	if Input.is_action_pressed("ui_jump") and double_jump < 5:
		velocity.y = JUMP_POWER
		double_jump += 1
		print("jump")
		
	apply_gravity()
	velocity = move_and_slide(velocity, FLOOR)
	velocity.y += GRAVITY
	
func apply_gravity():
	if is_on_floor():
		on_ground = true
		double_jump = 0
	else:
		on_ground = false
		
	
