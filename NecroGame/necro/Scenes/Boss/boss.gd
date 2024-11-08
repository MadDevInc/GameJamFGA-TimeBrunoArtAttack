extends CharacterBody2D

@export var speed = 15
@export var limit = 0.5
@export var endPoint: Marker2D

var startPosition
var endPosition

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
		$AnimatedSprite2D.play("walk_top")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	else:
		$AnimatedSprite2D.play("walk_left")
		
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()	
