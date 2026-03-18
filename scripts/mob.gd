extends CharacterBody2D

var speed = 50.0
var move_dir = Vector2.ZERO

@onready var anim = $AnimatedSprite2D

func _ready():
	_pick_new_state()

func _physics_process(delta):
	velocity = move_dir * speed
	move_and_slide()
	_update_animation()

func _pick_new_state():
	# Randomly decide to stop or walk
	if randf() < 0.3:
		move_dir = Vector2.ZERO
	else:
		_pick_random_direction()
	
	# Wait between 1 and 3 seconds
	await get_tree().create_timer(randf_range(1.0, 3.0)).timeout
	_pick_new_state()

func _pick_random_direction():
	var angle = randf() * PI * 2
	move_dir = Vector2(cos(angle), sin(angle)).normalized()

func _update_animation():
	if move_dir == Vector2.ZERO:
		# Keep facing same general direction but idle
		if anim.animation.begins_with("walk_"):
			anim.play("idle_" + anim.animation.trim_prefix("walk_"))
	else:
		if abs(move_dir.x) > abs(move_dir.y):
			if move_dir.x > 0:
				anim.play("walk_right")
			else:
				anim.play("walk_left")
		else:
			if move_dir.y > 0:
				anim.play("walk_down")
			else:
				anim.play("walk_up")
