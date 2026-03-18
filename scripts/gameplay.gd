extends Node2D

@onready var mob_scene = preload("res://mob.tscn")

func _ready():
	# Start spawning timer
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_spawn_timeout)
	add_child(timer)

func _on_spawn_timeout():
	var mob = mob_scene.instantiate()
	# Spawn within an offset from the center (or character if available)
	var spawn_pos = Vector2(randf_range(-500, 500), randf_range(-500, 500))
	if has_node("mainCharacter"):
		mob.position = $mainCharacter.position + spawn_pos
	else:
		mob.position = spawn_pos
	add_child(mob)
