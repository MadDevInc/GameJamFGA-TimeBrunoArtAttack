extends Node2D

var cenaMundo = load("res://Scenes/World/world.tscn")
var onAreaStayPortal: bool = false
var onAreaStayLivro: bool = false
@onready var loja = $Shop
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	exit()
	open_store()

func _on_portal_body_entered(body):
	onAreaStayPortal = true

func _on_portal_body_exited(body):
	onAreaStayPortal = false
	
func _on_book_body_entered(body):
	onAreaStayLivro = true
	print(onAreaStayLivro)

func _on_book_body_exited(body):
	onAreaStayLivro = false
	print(onAreaStayLivro)
	
func exit():
	if Input.is_action_pressed("interact"):
		get_tree().change_scene_to_packed(cenaMundo)

func open_store():
	if Input.is_action_pressed("interact"):
		if onAreaStayLivro == false:
			pass
		if onAreaStayLivro == true:
			$Shop.visible = true
