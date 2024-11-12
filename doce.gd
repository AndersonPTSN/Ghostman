extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Sinal para notificar quando o doce for coletado
signal collected

# Função que é chamada ao entrar em contato com outro corpo
func _on_body_entered(body):
	#print(body.name)
	pass


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.name == "Area_Menor":  # Verifica se o corpo é o inimigo
		area.get_parent().on_candy_collected()
		emit_signal("collected")  # Emite o sinal de coleta
		queue_free()  # Remove o doce da cena
