extends KinematicBody2D

var motion = Vector2()
var vel_x = 1.5
var gravity = 5

func _physics_process(delta):
	motion.y += gravity
	if Input.is_action_pressed("ui_right"):
		motion.x = 100 * vel_x
	elif Input.is_action_pressed("ui_left"):
		motion.x = -100 * vel_x
	else:
		motion.x = 0
	move_and_slide(motion)
	pass
