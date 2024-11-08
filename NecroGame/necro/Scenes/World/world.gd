extends Node2D

var cash: int = 0

@onready var heartsContainer = $CanvasLayer/heartsContainer
#Mudar quando mudar Tilemaps e Câmera
@onready var player = $Player

var bossFight = load("res://Scenes/Boss/bossMap.tscn")
var onAreaStayPortal: bool = false
# Called when the node enters the scene tree for the first time.

func _ready():
	heartsContainer.setMaxHearts(player.maxHealth)
	print("heartsContainer.setMaxHearts(player.maxHealth) ", heartsContainer.setMaxHearts(player.maxHealth))
	heartsContainer.updateHearts(player.currentHealth)
	print("(player.currentHealth) ",(player.currentHealth))
	player.healthChanged.connect(heartsContainer.updateHearts)
	print("player.healthChanged.connect(heartsContainer.updateHearts ",player.healthChanged.connect(heartsContainer.updateHearts))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_cash()
	exit()

func show_cash():
	$HUD.get_node("cashLabel").text = "$ " + str(GLOBAL.cash)

var focused_object: CharacterBody2D

func switch_focus(object: CharacterBody2D):
	focused_object = object

func _on_portal_body_entered(body):
	onAreaStayPortal = true
	
func _on_portal_body_exited(body):
	onAreaStayPortal = false

func exit():
	if Input.is_action_pressed("interact"):
		if onAreaStayPortal == false:
			pass
		if onAreaStayPortal == true:
			get_tree().change_scene_to_packed(bossFight)
