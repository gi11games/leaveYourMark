extends Area2D

var velocity = Vector2()
const SPEED = 200

func _ready():
	pass
	
func _physics_process(delta):
	if velocity == Vector2(1, 0):
		set_rotation_in_degrees(0)
	if velocity == Vector2(-1, 0):
		set_rotation_in_degrees(180)
	if velocity == Vector2(0, 1):
		set_rotation_in_degrees(90)
	if velocity == Vector2(0, -1):
		set_rotation_in_degrees(270)
	
	translate(velocity * SPEED * delta)
	
	var pos = get_position()
	
	if pos.x < 0 or pos.x > get_viewport().get_size().x or pos.y < 0 or pos.y > get_viewport().get_size().y:
		print("dedarrow")
		queue_free()
	

func _on_arrow_body_entered( body ):
	if body in get_tree().get_nodes_in_group("enemy"):
			body.queue_free()
			queue_free()
