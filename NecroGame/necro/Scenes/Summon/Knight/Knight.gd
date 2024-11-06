extends CharacterBody2D

@export var attack: int = 1

var movement_speed: float = 50.0

enum STATES {MOVING_TO_TARGET, ATTACKING}

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var health_bar: TextureProgressBar = $HealthComponent
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state = STATES.MOVING_TO_TARGET

var current_target : CharacterBody2D

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	$Label.text = STATES.keys()[state]
	if current_target != null:
			set_movement_target(current_target.global_position)

	if state == STATES.MOVING_TO_TARGET:
		if navigation_agent.is_navigation_finished():
			return

		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position) * movement_speed
		move_and_slide()
	if state == STATES.ATTACKING:
		if !animation_player.is_playing():
			animation_player.play("attack")

func _on_range_body_entered(body):
	if body == current_target:
		state = STATES.ATTACKING

func _on_range_body_exited(body):
	if body == current_target:
		animation_player.stop()
		state = STATES.MOVING_TO_TARGET

func deal_damage_to_current_target():
	if current_target != null:
		current_target.take_hit(attack)

func take_hit(damage: int):
	health_bar.damage(damage)

func die():
	self.queue_free()
