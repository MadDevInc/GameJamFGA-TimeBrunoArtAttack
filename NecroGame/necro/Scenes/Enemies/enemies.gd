extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position

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
		$AnimatedSprite2D.play("walk")
		

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(area):
	if area == $hitBox:
		return
	print("slime hit")
