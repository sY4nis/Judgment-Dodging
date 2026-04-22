extends Node
@onready var stars = 0
@onready var can_use = true
@onready var cam = $Lurgatoir/Camera2D
@onready var sorry = $SORRY
@onready var star_counter = $UI/HBoxContainer/Star_counter
@onready var staricon =$UI/HBoxContainer/TextureRect
@onready var flash = $UI/ColorRect

func update_ui():
	star_counter.text = str(stars)

func boom():
	for obstacles in get_tree().get_nodes_in_group("obstacles"):
		obstacles.explosion()
		print(obstacles.name)
		
func cam_shake():
	var tween = create_tween()
	var original_pos = cam.offset
	for i in 7:
		tween.tween_property(cam, "offset", original_pos + Vector2(randf_range(-100,100), randf_range(-100, 100)), 0.04)
		tween.tween_property(cam, "offset", original_pos, 0.04)

func use_spell():
	if Input.is_key_pressed(KEY_J) and stars > 0 and can_use:
		can_use = false
		stars -= 1
		update_ui()
		boom()
		var tween = create_tween()
		sorry.stop()
		sorry.volume_db = 0
		sorry.play()
		flash.modulate.a = 1.0
		tween.tween_property(flash, "modulate:a", 0.0, 0.3)
		#tween.tween_property(sorry, "volume_db", -80, 10.0)
		cam_shake()
		await get_tree().create_timer(2.0).timeout
		can_use = true


func _process(delta):
	use_spell()
	if not can_use:
		staricon.texture = load("res://Sprites/Objects/Stariconcant.png")
	else:
		staricon.texture = load("res://Sprites/Objects/Staricon.png")
	#debug = 
	if Input.is_key_pressed(KEY_C):
		stars = 1000

func _ready():
	flash.modulate.a = 0


