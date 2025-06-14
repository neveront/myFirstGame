extends CharacterBody2D

@export var SPEED = 1000
var dir: float
var spawnPos: Vector2
var spawnRot: float
var animation_type: String = "black_bullet"  # Default animation

@onready var bullet_effect: AnimatedSprite2D = $bulletEffect

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	print(animation_type)
	if bullet_effect:
		bullet_effect.play(animation_type)
	else:
		bullet_effect.play("white_bullet")  # fallback if animation not found

func _physics_process(delta):
	velocity = Vector2(SPEED, 0).rotated(dir)
	move_and_slide()
