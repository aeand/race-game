extends CharacterBody2D

# TODO
# change direction of backwards rotation

enum Direction {UP = 1, DOWN = -1, RIGHT = 1, LEFT = -1}
var driving_direction = Direction.UP

var speed = 0
var max_speed_forwards = 40000
var max_speed_backwards = -40000
var acceleration_speed = 10000

var rotation_speed = 0
var max_rotation_speed = 1.5
var min_rotation_speed = -1.5
var turning_speed = 5
var turning_adjustment_speed = 1

func _physics_process(delta):
	handle_direction()
	handle_speed(delta)
	handle_rotation(delta)
	move_and_slide()

func handle_speed(delta):
	if Input.get_axis("down", "up") == Direction.UP and speed < max_speed_forwards:
		if speed < 0:
			speed += clampf(delta * acceleration_speed, 0, max_speed_forwards)
		speed += clampf(delta * acceleration_speed, 0, max_speed_forwards)
		
	elif Input.get_axis("down", "up") == Direction.DOWN and speed > max_speed_backwards:
		if speed > 0:
			speed += clampf(delta * -acceleration_speed, max_speed_backwards, 0)
		speed += clampf(delta * -acceleration_speed, max_speed_backwards, 0)
		
	else:
		if speed > 0:
			speed -= clampf(delta * acceleration_speed, 0, max_speed_forwards)
		
		elif speed < 0:
			speed -= clampf(delta * -acceleration_speed, max_speed_backwards, 1000)
	
	velocity = transform.x * speed * delta
	
func handle_rotation(delta):
	if Input.get_axis("left", "right") == Direction.RIGHT and rotation_speed < max_rotation_speed:
		rotation_speed += clampf(delta * turning_speed, min_rotation_speed, max_rotation_speed)
		
	elif Input.get_axis("left", "right") == Direction.LEFT and rotation_speed > min_rotation_speed:
		rotation_speed += clampf(delta * -turning_speed, min_rotation_speed, max_rotation_speed)
		
	else:
		if rotation_speed > 0:
			rotation_speed -= clampf(delta * turning_adjustment_speed, min_rotation_speed, max_rotation_speed)
			
		if rotation_speed < 0:
			rotation_speed += clampf(delta * turning_adjustment_speed, min_rotation_speed, max_rotation_speed)
	
	if speed > 1000 or speed < -1000:
		rotation += rotation_speed * delta

func handle_direction():
	if driving_direction == Direction.DOWN and speed < 0 and Input.get_axis("up", "down") > 0:
		driving_direction = Direction.UP
		print("flipped1 ", rotation_speed, driving_direction)
	
	if driving_direction == Direction.UP and speed > 0 and Input.get_axis("up", "down") < 0:
		driving_direction = Direction.DOWN
		print("flipped2 ", rotation_speed, driving_direction)

# resources
# https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
# https://docs.godotengine.org/en/4.1/tutorials/inputs/inputevent.html
