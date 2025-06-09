extends CharacterBody2D

@export var SPEED = 600
var dir: float
var spawnPos: Vector2
var spawnRot: float
var animation_type: String = "white_bullet"  # Default animation

@onready var bullet_effect: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	
	if bullet_effect:
		if bullet_effect.has_animation(animation_type):
			bullet_effect.play(animation_type)
		else:
			bullet_effect.play("white_bullet")  # fallback if animation not found
	print(animation_type)
func _physics_process(delta):
	velocity = Vector2(SPEED, 0).rotated(dir)
	move_and_slide()
