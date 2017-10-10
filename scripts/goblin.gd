extends KinematicBody2D

#Constants
const MAX_SPEED = 100


#Finding Object
var min_distance = 9999999.0
var closest_obj = null
var dir = Vector2()
var move

#Attack Stuff
var canAttack = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _physics_process(delta):
	
	#Find the Cloest Tree
	for node in get_tree().get_nodes_in_group("tree"):
		var dist = get_position().distance_to(node.get_position())
		if get_tree().get_root().has_node(node.get_path()):
			if dist < min_distance:
				min_distance = dist
				closest_obj = node
				
				dir = (closest_obj.get_position() - get_position()).normalized()
		else:
			closest_obj = null
	
	#Move to that tree
	move = move_and_collide(dir * MAX_SPEED * delta)
	
	if (move != null): 
		if (move.get_collider().is_in_group("tree")):
			if closest_obj != null:
				if canAttack:
					canAttack = false
					if closest_obj != null and get_tree().get_root().has_node(closest_obj.get_path()):
						if closest_obj.damage_tree(1):
							canAttack = true
							closest_obj == null
							min_distance = 9999999.0
	
	
	var pos = get_position()
	
	if pos.x < 0 or pos.x > get_viewport().get_size().x or pos.y < 0 or pos.y > get_viewport().get_size().y:
		queue_free()

func _on_attack_timer_timeout():
	canAttack = true