extends CharacterBody2D

# Variáveis de movimento
var speed = 100
var target_position = Vector2.ZERO
var player_visible = false
var ativo = false
var achou = false
var buffado = false

# Referência ao jogador (atribuído ao detectar o jogador)
var player = null

# Movimentação aleatória
var random_move_timer = 0

func _ready():
	pass

func _process(delta):
	if ativo == true:
		if player_visible and player and achou and buffado == false:
			# Se o jogador estiver visível, foge do jogador
			flee_from_player(delta)
			if candy != null:
				flee_toward_candy(delta)
		else:
			# Caso contrário, movimento aleatório
			random_movement(delta)
	if buffado == true:
		pursue_player(delta)	

# Função de perseguição ao jogador
func pursue_player(delta):
	if player != null:
		target_position = player.global_position
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	
	
# Função de fuga do jogador
func flee_from_player(delta):
	var target_position = player.global_position
	var direction = (global_position - target_position).normalized()
	velocity = direction * speed 
	move_and_slide()
	
var candy  # Referência ao doce

# Função de perseguição ao direção do doce
func flee_toward_candy(delta):
	target_position = candy.global_position
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

# Função de movimento aleatório
func random_movement(delta):
	random_move_timer -= delta
	if random_move_timer <= 0:
		# Define um novo alvo aleatório próximo ao inimigo
		target_position = global_position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
		random_move_timer = randf_range(1, 3)  # Define um novo tempo para mudar de direção

	# Movimenta-se na direção do alvo aleatório
	var direction = (target_position - global_position).normalized()
	velocity = direction * (speed / 2)  # Menor velocidade ao se mover aleatoriamente
	move_and_slide()
	

func receive_signal_from_piso():
	ativo = true
	

func _on_area_2d_body_entered(body):
	var b = body.get_node("colisao2")
	if body.name == "Fantasma":  # Certifique-se que o nome do jogador é "Player"
		player_visible = true
		player = body


func _on_area_2d_body_exited(body):
	if body.name == "Fantasma":
		player_visible = false
		player = null

@onready var detection_area = $Area_Maior
@onready var collision_area = $Area_Menor

func _on_area_menor_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Area_Menor_Fantasma":
		pass

func on_candy_collected():
	buffado = true
	$Sprite2D.texture = load("res://Sprites/pacman_buff.png")
	speed = 120
	var timer = get_tree().create_timer(5)  # Cria um timer de 5 segundos
	timer.timeout.connect(_on_doce_timer_timeout)  # Conecta o timeout

# Função chamada quando o timer termina (depois de 5 segundos)
func _on_doce_timer_timeout():
	buffado = false
	$Sprite2D.texture = load("res://Sprites/pacman.png")
	speed = 100
	pass

func _on_area_maior_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Area_Menor_Fantasma":
		achou = true
	if area.name.begins_with("Doce"): 
		candy = area



func _on_area_maior_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area != null:
		if area.name == "Area_Menor_Fantasma":
			achou = false
			

var chunks = []

func _on_area_menor_area_entered(area):
	if area.name != "Area_Menor_Fantasma" and area.name != "Area2D2" and area.name != "Fantasma" and area.name != "Area_Maior":
		chunks.append(area.name)


func _on_area_menor_area_exited(area):
	chunks.erase(area.name)
