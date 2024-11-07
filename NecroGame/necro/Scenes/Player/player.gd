extends CharacterBody2D

const SPEED = 50.0

signal healthChanged

@export var maxHealth = 3
@onready var currentHealth: int = maxHealth
@onready var hurtTimer = $hurtTimer

@export var knockbackPower: int = 500

var isHurt: bool = false
var enemyCollisions = []
var direction: String
var attack : bool = false

var is_attacking : bool = false

func _physics_process(delta):
	#$Label.text = ("animation: " + $AnimatedSprite2D.animation + "\n is attacking: "+ str(is_attacking) + "\nvelocity: " + str(velocity))

	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x == 0 and direction_y == 0:
		$AnimatedSprite2D.play("necro_idle")


	if direction_x:
		velocity.x = direction_x * SPEED
		if direction_x > 0:
			$AnimatedSprite2D.play("necro_walk_right")
		else:
			$AnimatedSprite2D.play("necro_walk_left")
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
	
	if !isHurt:
		for enemyArea in enemyCollisions:
			hurtByEnemy(enemyArea)

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack_bottom":
		$swordHit.position = Vector2(1, 5)
		$swordHit.monitoring = true
		$AnimatedSprite2D.play("necro_idle")
		is_attacking = false
	elif $AnimatedSprite2D.animation == "attack_right":
		$swordHit.position = Vector2(11, -5)
		$swordHit.monitoring = true
		$AnimatedSprite2D.play("idle_right")
		is_attacking = false
	elif $AnimatedSprite2D.animation == "attack_left":
		$swordHit.position = Vector2(-10, -3)
		$swordHit.monitoring = true
		$AnimatedSprite2D.play("idle_left")
		is_attacking = false
	elif $AnimatedSprite2D.animation == "attack_top":
		$swordHit.position = Vector2(0, -4)
		$swordHit.monitoring = true
		$AnimatedSprite2D.play("idle_top")
		is_attacking = false

func hurtByEnemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
			
	healthChanged.emit(currentHealth)
	isHurt = true
	knockback(area.get_parent().velocity)
	hurtTimer.start()
	await hurtTimer.timeout
	isHurt = false


func _on_hurt_box_area_entered(area):
	if area.name == 'hitBox':
		enemyCollisions.append(area)
		
		
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func _on_hurt_box_area_exited(area):
	enemyCollisions.erase(area)
