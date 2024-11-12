extends CharacterBody2D


var input: Vector2 = Vector2.ZERO
var velocidade: float = 200.0
@onready var camera = get_node("Camera2D")

var chunks = []


func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input = input.normalized()
	
	if Input.is_key_pressed(KEY_Q):
		if camera.zoom == Vector2(5.5, 5.5):
			camera.zoom = Vector2(1, 1)
			camera.enabled = false
		else:
			camera.zoom = Vector2(5.5, 5.5)
			camera.enabled = true

func character_moviment():
	velocity = input * velocidade

func _ready():
	pass 

func _process(_delta):
	get_input()
	character_moviment()
	move_and_slide()
	pass


func _on_area_2d_2_area_entered(area):
	if area.name != "Area_Menor" and area.name != "Area_Maior" and area.name != "Pacman" and area.name != "Area_Menor_Fantasma":
		#print("ADD: ",area.name)
		chunks.append(area.name)

func _on_area_2d_2_area_exited(area):
	#print("REMOVE: ",area.name)
	chunks.erase(area.name)
