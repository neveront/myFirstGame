extends CharacterBody2D

const SPEED = 300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_direction: String = "down"

func _physics_process(delta: float) -> void:
	# Get the input direction
	var direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	# Set the velocity based on the input direction
	velocity = direction * SPEED

	# Move the character
	move_and_slide()

	# Update animation based on movement
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("walk_right")
				last_direction = "right"
			else:
				animated_sprite.play("walk_left")
				last_direction = "left"
		else:
			if direction.y > 0:
				animated_sprite.play("walk_down")
				last_direction = "down"
			else:
				animated_sprite.play("walk_up")
				last_direction = "up"
	else:
		animated_sprite.play("idle_" + last_direction)
