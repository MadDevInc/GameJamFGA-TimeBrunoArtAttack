extends CharacterBody2D

const SPEED = 50.0

func _physics_process(delta):

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x == 0 and direction_y == 0:
		$AnimatedSprite2D.play("idle")


	if direction_x:
		velocity.x = direction_x * SPEED
		print(velocity)
		#if direction_x == "left":
			#$AnimatedSprite2D.play("moving_sides")
		#else:
			#$AnimatedSprite2D.play("moving_sides")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	
	if direction_y:
		velocity.y = direction_y * SPEED
		$AnimatedSprite2D.play("moving_up_down")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		

	move_and_slide()
