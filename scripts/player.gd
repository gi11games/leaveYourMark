extends KinematicBody2D

#Preloads
onready var arrow = preload("res://scenes/arrow.tscn")

#Constants
const MAX_SPEED = 200

#Variables
var direction = Vector2()
var speed = 0
var motion = Vector2()
var lastDir = Vector2(0, 1)
var canAttack = true

func _ready():
	pass
	
func _physics_process(delta):
	set_z(get_position().y)
	
	#Movement
	direction = Vector2()
	speed = 0
	
	direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	speed = MAX_SPEED
	motion = speed * direction.normalized()
	
	move_and_slide(motion)
	
	#Temp Animation Control
	if direction.x == 1:
		$sprite.play("walk-right")
		lastDir = direction
	elif direction.x == -1:
		$sprite.play("walk-left")
		lastDir = direction
	elif direction.y == 1:
		$sprite.play("walk-down")
		lastDir = direction
	elif direction.y == -1:
		$sprite.play("walk-up")
		lastDir = direction
	
	#clamp
	var clampx = clamp(get_position().x, 10, get_viewport().get_size().x - 10)
	var clampy = clamp(get_position().y, 10, get_viewport().get_size().y - 10)
	set_position(Vector2(clampx, clampy))
	
	#Shoot Weapons
	if Input.is_action_pressed("shoot"):
		if canAttack:
			canAttack = false
			var new_arrow = arrow.instance()
			new_arrow.set_position(get_position())
			new_arrow.velocity = lastDir
			get_node("/root").add_child(new_arrow)

func _on_arrowTimer_timeout():
	canAttack = true
