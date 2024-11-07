extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

var startPosition
var endPosition

var isDead: bool = false

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	$AnimatedSprite2D.play("enemy_walk_right")


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
	if area == $hitBox:
		return
	isDead = true
	$AnimatedSprite2D.play("dead")
	
	
func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "dead":
		GLOBAL.cash += 50
		print(GLOBAL.cash)
		queue_free()
