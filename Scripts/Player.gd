extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

@onready var sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")  # Play jump animation

	# Handle movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")  # Play walk animation
		sprite.flip_h = direction < 0  # Flip sprite based on movement direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			sprite.play("idle")  # Play idle animation when not moving

	# If in air and not jumping, switch to jump animation
	if not is_on_floor() and velocity.y > 0:
		sprite.play("jump")

	move_and_slide()
