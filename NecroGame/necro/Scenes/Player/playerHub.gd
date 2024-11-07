extends CharacterBody2D

const SPEED = 50.0

func _physics_process(delta):
	#$Label.text = ("animation: " + $AnimatedSprite2D.animation + "\n is attacking: "+ str(is_attacking) + "\nvelocity: " + str(velocity))

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")

	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction_x > 0:
		$AnimatedSprite2D.play("necro_walk_right")
	elif direction_x < 0:
		$AnimatedSprite2D.play("necro_walk_left")
	elif direction_y > 0:
		$AnimatedSprite2D.play("necro_walk_bottom")
	elif direction_y < 0:
		$AnimatedSprite2D.play("necro_walk_top")
	
	if direction_x == 0 and direction_y == 0:
		if $AnimatedSprite2D.animation == "necro_walk_right":
			$AnimatedSprite2D.play("idle_right")
		elif $AnimatedSprite2D.animation == "necro_walk_left":
			$AnimatedSprite2D.play("idle_left")
		elif $AnimatedSprite2D.animation == "necro_walk_bottom":
			$AnimatedSprite2D.play("necro_idle")
		elif $AnimatedSprite2D.animation == "necro_walk_top":
			$AnimatedSprite2D.play("idle_top")

	move_and_slide()
