extends KinematicBody2D

const ACCELERATION = 200
const FRICTION = 500
const MAX_SPEED = 100
var velocity = Vector2.ZERO


onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree

onready var animationState = animationTree.get("parameters/playback")

	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# input_vector = input_vector.normalized()
	print(input_vector)

	if input_vector.x != 0:
		animationTree.set("parameters/Idle/blend_position",input_vector.x)
		animationTree.set("parameters/Run/blend_position",input_vector.x)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION)
	move_and_slide(velocity)
	
