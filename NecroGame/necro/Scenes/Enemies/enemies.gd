extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

var startPosition
var endPosition

var isDead: bool = false
var maxHealth: int = 1
func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	$AnimatedSprite2D.play("walk_right")


func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.y > 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	else:
		$AnimatedSprite2D.play("walk_left")

func _physics_process(delta):
	if isDead: return
	updateVelocity()
	move_and_slide()
	updateAnimation()	


func _on_hurt_box_area_entered(area):
	print(area.name)
	print(area.get_parent().is_attacking)
	if area.name == "swordHit" && area.get_parent().is_attacking:
		maxHealth -= int(GLOBAL.dano)
		if maxHealth <= 0:
			if area == $hurtBoxEnemy: return
			isDead = true
			$AnimatedSprite2D.play("dead")
	#if area.name == "hurtBoxPlayer"
	
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "dead":
		GLOBAL.cash += 50
		queue_free()
		return
