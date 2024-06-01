extends CharacterBody2D

# TODO
# fix speed backwards not going to 0
# fix rotation speed barely moving forwards

var speed = 0
var max_speed_forwards = 40000
var max_speed_backwards = -40000
var acceleration_speed = 10000

var rotations = 0
var rotation_speed = 1000
var max_rotation_speed = 10
var min_rotation_speed = -10

func _physics_process(delta):
	handle_speed(delta)
	handle_rotation(delta)
	move_and_slide()

func handle_speed(delta):
	print(speed)

	if Input.get_axis("down", "up") > 0 and speed < max_speed_forwards:
		speed += clamp(delta * acceleration_speed, 0, max_speed_forwards)
		
	elif Input.get_axis("down", "up") < 0 and speed > max_speed_backwards:
		speed += clamp(delta * -acceleration_speed, max_speed_backwards, 0)
		
	else:
		if speed > 0:
			speed -= clamp(delta * acceleration_speed, 0, max_speed_forwards)
			
		elif speed < 0:
			speed += clamp(delta * acceleration_speed, max_speed_backwards, 0)
			
	velocity = transform.x * speed * delta
	
func handle_rotation(delta):
	#print(speed)
	if Input.get_axis("left", "right") != 0 and (speed > 1000 or speed < -1000):
		rotation += 1.5 * Input.get_axis("left", "right") * delta
	# make a rotation stick. just like a real car turning the wheel
	#if Input.get_axis("left", "right") > 0 and rotations < max_rotation_speed:
		#rotations += clamp(delta * rotation_speed, 0, max_rotation_speed)
		#rotation += rotations * delta
		
	#elif Input.get_axis("left", "right") < 0 and rotations > -min_rotation_speed:
		#rotations += clamp(delta * -rotation_speed, -min_rotation_speed, 0)
		

# resources
# https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
# https://docs.godotengine.org/en/4.1/tutorials/inputs/inputevent.html
