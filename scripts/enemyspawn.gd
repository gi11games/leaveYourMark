extends Node

onready var goblin = preload("res://scenes/goblin.tscn")

var spawnpos = Vector2()

func _ready():
	randomize()

func _physics_process(delta):
	pass

func spawnenemy(location):
	var new_enemy = goblin.instance()
	new_enemy.set_z(location.y)
	new_enemy.set_position(location)
	add_child(new_enemy)

func _on_enemyTimer_timeout():
	var location = randi() % 4
	
	if location == 0: #Top Left
		spawnpos = Vector2(16, 16)
	elif location == 1: #Top Right
		spawnpos = Vector2(get_viewport().get_size().x - 16, 16)
	elif location == 2: #Bottom Left
		spawnpos = Vector2(16, get_viewport().get_size().y - 16)
	elif location == 3: #Bottom Right
		spawnpos = Vector2(get_viewport().get_size().x - 16, get_viewport().get_size().y - 16)
		
	spawnenemy(spawnpos)