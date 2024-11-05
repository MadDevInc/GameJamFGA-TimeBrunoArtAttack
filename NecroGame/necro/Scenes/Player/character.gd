extends CharacterBody2D

const SPEED = 50

var move = Vector2()

func _physics_process(delta):
	if Input.is_action_pressed("key_w"):
		move.y = -SPEED
		print("andou")
	if Input.is_action_pressed("key_s"):
		move.y = SPEED
	if Input.is_action_pressed("key_a"):
		move.x = -SPEED
	if Input.is_action_pressed("key_d"):
		move.x = SPEED
