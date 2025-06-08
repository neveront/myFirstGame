extends CharacterBody2D

@export var SPEED = 200

var dir : float
var spawnPos : Vector2
var spawnRot : float
@onready var bullet_effect: AnimatedSprite2D = $bulletEffect

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	if bullet_effect:
		bullet_effect.play("bullet")
	
func _physics_process(delta: float):
	velocity = Vector2(0,-SPEED).rotated(dir)
	move_and_slide()
