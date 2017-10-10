extends StaticBody2D

var health = 3

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _physics_process(delta):
	if health <= 0:
		queue_free()

func damage_tree(damage):
	health -= damage
	if health <= 0:
		return true