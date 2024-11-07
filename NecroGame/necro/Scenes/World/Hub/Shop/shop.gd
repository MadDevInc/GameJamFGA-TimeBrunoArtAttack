extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_menu():
	$".".visible = false


func _on_btn_fechar_pressed():
	close_menu()


func _on_dano_buy():
	print("dano inicial: ",GLOBAL.dano)
	if GLOBAL.cash >= 100:
		GLOBAL.cash -= 100
		GLOBAL.dano += 1
		print("dano final: ",GLOBAL.dano)


func _on_vida_buy():
	print("vida inicial: ",GLOBAL.maxHealth)
	if GLOBAL.cash >= 100:
		GLOBAL.cash -= 100
		GLOBAL.maxHealth += 1
		print("vida final: ",GLOBAL.maxHealth)
