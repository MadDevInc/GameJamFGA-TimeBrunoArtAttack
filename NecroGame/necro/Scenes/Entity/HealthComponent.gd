extends TextureProgressBar

@export var health: int = 0
@export var bar_color: Color = Color.WHITE

@onready var progress_bar : TextureProgressBar = self

func _ready():
	progress_bar.modulate = bar_color
	progress_bar.max_value = health
	progress_bar.value = progress_bar.max_value
	$Label.text = str(health)

func damage(attack: int):
	health -= attack
	if health <= 0:
		get_parent().die()
	progress_bar.value = health
	$Label.text = str(health)
