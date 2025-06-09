extends Node2D
var projectile: PackedScene = preload("res://scenes/projectile.tscn")



func shoot():
	var instance = projectile.instantiate()
	var direction = global_rotation
	var forward_vector = Vector2.RIGHT.rotated(direction)  # Direction the gun is pointing
	var offset = forward_vector * 125  # 25 pixels in front of the gun

	instance.dir = direction
	instance.spawnPos = global_position + offset
	instance.spawnRot = direction

	get_tree().current_scene.add_child(instance)
	



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
