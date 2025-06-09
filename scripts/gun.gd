extends Node2D
var projectile: PackedScene = preload("res://scenes/projectile.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot(false)  # left click -> front
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			shoot(true)   # right click -> behind


func shoot(is_right_click: bool = false):
	var instance = projectile.instantiate()

	var direction = global_rotation
	var forward_vector = Vector2.RIGHT.rotated(direction)

	var offset: Vector2
	var bullet_dir: float
	var animation_type: String

	if is_right_click:
		offset = forward_vector * -125
		bullet_dir = direction + PI
		animation_type = "black_bullet"  # ← Name of rear animation
	else:
		offset = forward_vector * 125
		bullet_dir = direction
		animation_type = "white_bullet"  # ← Name of front animation
	print(animation_type)
	instance.dir = bullet_dir
	instance.spawnPos = global_position + offset
	instance.spawnRot = bullet_dir
	instance.animation_type = animation_type  # Pass animation type

	get_tree().current_scene.add_child(instance)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
