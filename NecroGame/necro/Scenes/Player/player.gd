extends CharacterBody2D

const SPEED = 50.0

signal healthChanged

@export var maxHealth = 3
@onready var currentHealth: int = maxHealth
@onready var hurtTimer = $hurtTimer

@export var knockbackPower: int = 500

var isHurt: bool = false
var enemyCollisions = []

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
	if !isHurt:
		for enemyArea in enemyCollisions:
			hurtByEnemy(enemyArea)
	
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
