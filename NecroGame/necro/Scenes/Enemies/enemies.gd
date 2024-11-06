extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	$AnimatedSprite2D.play("enemy_walk_rl")


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
	print(velocity.x)

	# Primeiro, checamos o movimento horizontal
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.play("enemy_walk_rl")

	# Se não houver movimento horizontal, verificamos o vertical
	elif velocity.y > 0:
		$AnimatedSprite2D.play("enemy_walk_bottom")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("enemy_walk_top")


		

func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()


func _on_hurt_box_area_entered(area):
	if area == $hitBox:
		return
	print("slime hit")
