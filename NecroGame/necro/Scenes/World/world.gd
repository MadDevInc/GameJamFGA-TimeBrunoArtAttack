extends Node2D

var cash: int = 0

@onready var heartsContainer = $CanvasLayer/heartsContainer
#Mudar quando mudar Tilemaps e Câmera
@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_cash()
	pass

func show_cash():
	$HUD.get_node("cashLabel").text = "$ " + str(GLOBAL.cash)

var focused_object: CharacterBody2D

func switch_focus(object: CharacterBody2D):
	focused_object = object
