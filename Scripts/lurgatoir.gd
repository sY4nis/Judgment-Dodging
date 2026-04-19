extends CharacterBody2D

@onready var Lur = $Sprite
@onready var Starwinkle = $STARWINKLE
@onready var Heartattack = $HEART
@onready var Hitbox = $CollisionShape2D
@export var speed : int = 800
@export var slowspeed : int = 250

@onready var viewport_size = get_viewport().get_visible_rect().size
@onready var screen_width = viewport_size.x
@onready var screen_height = viewport_size.y
var islow = false

func get_input() :
	#Mouvements de base
	var input_direction = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	if Input.is_action_pressed("Slowmode") :
		velocity = input_direction * slowspeed
		islow = true
	else : 
		velocity = input_direction * speed
		islow= false
	var move_threshold = 0.1
	if velocity.length() < move_threshold:
		velocity = Vector2.ZERO  
	
	#Effet etoile quand on se deplace 
	if velocity.length() > 0: 
		if islow :
			if Starwinkle.playing :
				Starwinkle.stop()
			if not Heartattack.playing :
				Heartattack.play()
				Heartattack.stream.loop = true
		else :
			if Heartattack.playing :
				Heartattack.stop()
			if not Starwinkle.playing :
				Starwinkle.play()
				Starwinkle.stream.loop = true
	else :
		if Starwinkle.playing : 
			Starwinkle.stop()
		if Heartattack.playing :
			Heartattack.stop()



func update_anim() :
	if islow :
		Lur.play("LUR_FOCUS")
		Lur.scale = Vector2(0.35,0.35)
		Hitbox.scale = Vector2(1,1)
	else : 
		Lur.play("LUR_IDLE")
		Lur.scale = Vector2(0.5,0.5)
		Hitbox.scale = Vector2(1.21,1.21)

func _physics_process(delta):
	
	get_input()
	update_anim()
	position.x = clamp(position.x, 0, screen_width)
	position.y = clamp(position.y, 0, screen_height)
	move_and_slide()

func _ready() -> void : 
	Lur.play("LUR_IDLE")
	pass
	



