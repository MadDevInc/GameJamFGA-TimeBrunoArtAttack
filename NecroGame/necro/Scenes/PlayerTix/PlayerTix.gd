extends CharacterBody2D

const SPEED = 150
const DASH_SPEED = 5

var dash_fuel = 10

var move = Vector2()

@onready var health_bar : TextureProgressBar = $HealthComponent
@onready var skeleton : PackedScene = load("res://Scenes/Summon/Knight/Knight.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		if get_parent().focused_object != null:
			var spawn_position = self.global_position + (get_parent().focused_object.global_position - global_position).normalized() * 10
			var skeleton_instance = skeleton.instantiate()
			skeleton_instance.current_target = get_parent().focused_object
			skeleton_instance.global_position = spawn_position
			get_parent().add_child(skeleton_instance)

	var move = Vector2()

	if Input.is_action_pressed("key_w"):
		move.y = -SPEED
	if Input.is_action_pressed("key_s"):
		move.y = SPEED
	if Input.is_action_pressed("key_a"):
		move.x = -SPEED
	if Input.is_action_pressed("key_d"):
		move.x = SPEED

	if Input.is_action_pressed("key_shift"):
		if dash_fuel >= 0:
			move *= DASH_SPEED
			dash_fuel -= 1
	else:
		if dash_fuel < 10:
			dash_fuel += 1

	if move.x != 0 and move.y != 0:
		move = move/1.75

	#if move != Vector2():
		#$AnimatedSprite2D.animation = "walk"
	#else:
		#$AnimatedSprite2D.animation = "idle"

	move_and_collide(move * delta)

func take_hit(damage: int):
	health_bar.damage(damage)

func die():
	get_tree().change_scene_to_file("res://Scenes/World/Hub/Hub.tscn")
	print("Player dead")

func camera_zoom(zoom : float):
	$Camera2D.zoom = Vector2(zoom, zoom)

func show_time():
	$Time.show()
