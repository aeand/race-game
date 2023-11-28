extends CharacterBody2D

# resources
# * https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
# * https://docs.godotengine.org/en/4.1/tutorials/inputs/inputevent.html

@export var vroom = 400
@export var rotation_speed = 1.5
@export var woosh = 0
@export var friction = 0

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("left", "right")
	velocity = woosh + transform.x * Input.get_axis("down", "up") * vroom
	
	# if up is pressed. set woosh to slowly increase from 0 to 1
	# if down pressed. set woosh to less slowly increase from 0 to 1

func _physics_process(delta):
	get_input()
	update_vroom()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

func update_vroom():
	if velocity.x > 0 || velocity.y > 0:
		woosh -= friction
