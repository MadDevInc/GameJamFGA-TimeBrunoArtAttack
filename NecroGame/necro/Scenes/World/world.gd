extends Node2D

@onready var heartsContainer = $CanvasLayer/heartsContainer
#Mudar quando mudar Tilemaps e Câmera
@onready var player = $Player
# Called when the node enters the scene tree for the first time.
#func _ready():
	#heartsContainer.setMaxHearts(player.maxHealth)
	#heartsContainer.updateHearts(player.currentHealth)
	#player.healthChanged.connect(heartsContainer.updateHearts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


var focused_object: CharacterBody2D

func switch_focus(object: CharacterBody2D):
	focused_object = object
