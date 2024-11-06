extends CharacterBody2D

const SPEED = 50.0

func _physics_process(delta):

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x == 0 and direction_y == 0:
		$AnimatedSprite2D.play("necro_idle")


	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("necro_walk_rl")
		else:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("necro_walk_rl")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	
	if direction_y:
		velocity.y = direction_y * SPEED
		if direction_y > 0:
			$AnimatedSprite2D.play("necro_walk_bottom")
		else:
			$AnimatedSprite2D.play("necro_walk_top")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		

	move_and_slide()


func _on_hurt_box_area_entered(area):
	pass # Replace with function body.
