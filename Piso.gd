extends Area2D

var piso_ativo = preload("res://Sprites/piso_ativo.png")
var piso_inativo = preload("res://Sprites/piso_inativo.png")
@onready var pacman = get_node("/root/Campo/Pacman")
@onready var fantasma = get_node("/root/Campo/Fantasma")
var ativo = true
var fantasma_in = false
var pacman_in = false

#var no_original = null
@onready var no_original = get_node("/root/Campo/Doce")

func _ready():
	#no_original = $Doce
	pass


var tempo_acumulado = 0.0
var no_piso = false

func _process(delta):
	if no_piso:
		tempo_acumulado += delta

		if tempo_acumulado >= 5.0:
			gera_copia_na_area()
			tempo_acumulado = 0

func _on_body_entered(body):
	if body.name == "Area_Menor":
		print("PACMAN")
	if body.name == "Fantasma":
		var piso = get_node("Sprite2D")
		piso.texture = piso_ativo
		pacman.ativo = tem_interseccao(fantasma.chunks, pacman.chunks)
		
		no_piso = true
		if tempo_acumulado >= 5.0:
			print("Oi")
			tempo_acumulado -= 5.0

		
	if body != null:
		if body.name == "Pacman":
			pacman_in = true
		if body.name == "Fantasma":
			fantasma_in = true
		#check_if_both_inside()

func _on_body_exited(body):
	if body.name == "Fantasma":
		var piso = get_node("Sprite2D")
		piso.texture = piso_inativo
		pacman.ativo = tem_interseccao(fantasma.chunks, pacman.chunks)
		no_piso = false
		
	if body != null:
		if body.name == "Pacman":
			pacman_in = false
		if body.name == "Fantasma":
			fantasma_in = false
		#check_if_both_inside()

func check_if_both_inside():
	#print(pacman_in ," ", fantasma_in)
	if pacman_in and fantasma_in:
		pacman.ativo = true
	else:
		pacman.ativo = false

func tem_interseccao(lista1, lista2):
	if lista1 != null and lista2 != null:
		for item in lista1:
			if item in lista2:
				return true # Retorna true na primeira interseção encontrada
		return false # Retorna false se não encontrar nenhuma interseção
	else:
		return false

func gera_copia_na_area():
	for i in range(randi_range(1, 2)):
		var copia = no_original.duplicate()
		copia.name = no_original.name + "_copia" 
		var posicao_x = int(randf_range(self.position.x-150, self.position.x + 150))
		var posicao_y = int(randf_range(self.position.y-150, self.position.y + 150))
		copia.position = Vector2(posicao_x, posicao_y)
		get_parent().add_child(copia)
