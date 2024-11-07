extends Node2D

var cenaMundo = load("res://Scenes/World/world.tscn")
var podeRalar: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	exit()

func _on_portal_body_entered(body):
	podeRalar = true

func _on_portal_body_exited(body):
	podeRalar = false
	
func exit():
	if Input.is_action_pressed("interact"):
		if podeRalar == false:
			pass
		if podeRalar == true:
			get_tree().change_scene_to_packed(cenaMundo)
