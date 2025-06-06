extends CharacterBody2D

const SPEED = 300.0
@onready var animated_sprite: AnimatedSprite2D = $movements
@onready var smoke_effect: AnimatedSprite2D = $attackEffect
@onready var crosshair_line: Line2D = $crosshairLine

var last_direction: String = "down"

func _ready() -> void:
	smoke_effect.hide()  # Hide by default
	smoke_effect.connect("animation_finished", Callable(self, "_on_smoke_effect_animation_finished"))

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	velocity = direction * SPEED
	move_and_slide()

	if direction != Vector2.ZERO:
		last_direction = get_direction_string(direction)
		animated_sprite.play("walk_" + last_direction)
	else:
		animated_sprite.play("idle_" + last_direction)

	# Update crosshair line with fixed length
	var mouse_global_pos = get_global_mouse_position()
	var to_mouse_local = to_local(mouse_global_pos)
	
	var max_length = 150.0  # max length of the crosshair line
	
	# Clamp vector length to max_length
	if to_mouse_local.length() > max_length:
		to_mouse_local = to_mouse_local.normalized() * max_length
	
	crosshair_line.clear_points()
	crosshair_line.add_point(Vector2.ZERO)  # Player's center (local position)
	crosshair_line.add_point(to_mouse_local)
	
	# Rotate the gun to point at the mouse
	#var mouse_global_pos1 = get_global_mouse_position()
	var gun_direction = (mouse_global_pos - global_position).normalized()
	$Gun.rotation = gun_direction.angle()



	# Optional: attack animation
	if Input.is_action_just_pressed("white_attack"):
		#white Attack
		attack()
		$Gun/gunAttack.play("white_attack")  # Play white gun firing animation
		$Gun/whiteEffect.play("white_effect")  # Play white gun firing animation
		
	elif Input.is_action_just_pressed("black_attack"):
		#black Attack
		attack()
		$Gun/gunAttack.play("black_attack") # Play black gun firing animation
		$Gun/blackEffect.play("black_effect")  # Play white gun firing animation


func get_direction_string(direction: Vector2) -> String:
	if direction.x > 0.5:
		if direction.y < -0.5:
			return "upright"
		elif direction.y > 0.5:
			return "downright"
		else:
			return "right"
	elif direction.x < -0.5:
		if direction.y < -0.5:
			return "upleft"
		elif direction.y > 0.5:
			return "downleft"
		else:
			return "left"
	else:
		if direction.y < 0:
			return "up"
		else:
			return "down"

func attack() -> void:
	smoke_effect.frame = 0
	smoke_effect.show()
	smoke_effect.play("attackSmoke")
	$Gun/gunAttack.stop()
	$Gun/gunAttack.frame = 0
	$Gun/blackEffect.stop()
	$Gun/blackEffect.frame = 0
	$Gun/whiteEffect.stop()
	$Gun/whiteEffect.frame = 0
	

func _on_smoke_effect_animation_finished() -> void:
	smoke_effect.hide()
