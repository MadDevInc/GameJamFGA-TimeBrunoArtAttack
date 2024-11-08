extends CharacterBody2D

@export var attack: int = 1

const priority = ["summon","player"]

enum STATES {ACQUIRING_TARGET, CHANGING_TARGET, MOVING_TO_TARGET, ATTACKING}

var movement_speed: float = 25.0
var attack_speed : float = 0.75

var current_target : CharacterBody2D

var is_current_target_in_range : bool = false

var is_current_player_target : bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: TextureProgressBar = $HealthComponent
@onready var vision_cone : Area2D = $VisionCone
@onready var state = STATES.ACQUIRING_TARGET
@onready var TargetUI: AnimatedSprite2D = $TargetUI

func _ready():
	#TargetUI.hide()
	animation_player.speed_scale = attack_speed

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	$Label.text = STATES.keys()[state]

	if state == STATES.MOVING_TO_TARGET and current_target != null:
		animation_player.stop()
		animated_sprite.animation = "walk"
		set_movement_target(current_target.global_position)

		if navigation_agent.is_navigation_finished():
			return

		var current_agent_position: Vector2 = self.global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * movement_speed
		move_and_slide()
	elif state == STATES.ATTACKING:
		if !animation_player.is_playing():
			animation_player.play("attack")
	else:
		animation_player.stop()
		state = STATES.ACQUIRING_TARGET

func _on_vision_cone_body_entered(body):
	if !body.is_in_group("enemy"):
		print(body)
		state = STATES.ACQUIRING_TARGET
		if current_target != null:
			var priority_check = check_target_priority(body.get_groups())
			if priority_check:
				current_target = body
		else:
			current_target = body
		state = STATES.MOVING_TO_TARGET

func _on_vision_cone_body_exited(body):
	if body == current_target:
		state = STATES.CHANGING_TARGET
		var bodies_in_sight = vision_cone.get_overlapping_bodies()
		if bodies_in_sight.size() > 0:
			var current_biggest_priority = 0
			var current_new_target : CharacterBody2D
			for element in vision_cone.get_overlapping_bodies():
				if !element.is_in_group("enemy"):
					var check_priority = get_priority_value(element.get_groups())
					if  check_priority > current_biggest_priority:
						current_biggest_priority = check_priority
						current_new_target = element
			current_target = current_new_target
			state = STATES.MOVING_TO_TARGET

func check_target_priority(target_group : Array) -> bool:
	var current_priority = get_priority_value(current_target.get_groups())
	var tested_priority = get_priority_value(target_group)
	if tested_priority < current_priority:
		return true
	return false

func get_priority_value(groups : Array):
	for element in groups:
		if element in priority:
			return priority.find(element)

func _on_range_body_entered(body):
	if body == current_target:
		is_current_target_in_range = true
		state = STATES.ATTACKING

func _on_range_body_exited(body):
	if body == current_target:
		animation_player.stop()
		is_current_target_in_range = false
	if current_target != null:
		state = STATES.MOVING_TO_TARGET

func deal_damage_to_current_target():
	if current_target != null:
		current_target.take_hit(attack)

func take_hit(damage: int):
	health_bar.damage(damage)

func die():
	self.queue_free()

func _on_mouse_hook_mouse_entered():
	TargetUI.show()
	TargetUI.animation = "unlocked"
	get_parent().switch_focus(self)

func _on_mouse_hook_mouse_exited():
	#TargetUI.hide()
	get_parent().switch_focus(null)
