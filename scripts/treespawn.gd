extends Node

#Preload
onready var tree = preload("res://scenes/tree.tscn")

#Variables
var treepos = Vector2()
var lastpos = Vector2()
var newpos = Vector2()
var lastdir = Vector2()
var dir

func _ready():
	randomize()
	treepos = Vector2(get_viewport().get_size().x / 2, get_viewport().get_size().y / 2)
	spawntree(treepos)

func _physics_process(delta):
	pass

func spawntree(location):
	#Place Trees
	var spawn_pos = Vector2(location)
	var new_tree = tree.instance()
	new_tree.set_z(spawn_pos.y)
	new_tree.set_position(spawn_pos)
	add_child(new_tree)
	

func _on_Timer_timeout():
	lastdir = dir
	var treeexists = false
	
	if dir == lastdir:
		dir = randi() % 4
	if dir != lastdir:
		if dir == 0: #up
			treepos = Vector2(treepos.x, treepos.y - 32)
		elif dir == 1: #down
			treepos = Vector2(treepos.x, treepos.y + 32)
		elif dir == 2: #left
			treepos = Vector2(treepos.x - 32, treepos.y)
		elif dir == 3: #right
			treepos = Vector2(treepos.x + 32, treepos.y)
	
	
		for node in get_tree().get_nodes_in_group("tree"):
        	if node.get_position() == treepos:
            	treeexists = true
		
		#Checking spawn
		
		if treepos.x < 8 or treepos.x > get_viewport().get_size().x - 8 or treepos.y < 8 or treepos.y > get_viewport().get_size().y - 8:
			treepos = Vector2(get_viewport().get_size().x / 2, get_viewport().get_size().y / 2)
			return
		
		if !treeexists:
			spawntree(treepos)