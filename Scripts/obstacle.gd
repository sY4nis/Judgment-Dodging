extends Area2D
#Les asteroids seront destructibles 
#Au contacte du joueur ils explosent et tuent le joueur
# il se deplaseront au hasard 
@onready var Supernova = $SUPERNOVA
@export var velocity = Vector2(1,1)

@onready var speed : int = 200
@onready var collision = $CollisionShape2D
@onready var random_size = Vector2(1,1)
@onready var size = randf_range(0.5, 2.0)
@onready var Rock = $Sprite
@onready var Hitbox = $CollisionShape2D


func shake():
	var tween = create_tween()
	var original_pos = position
	for i in 5:
		tween.tween_property(self, "position", original_pos + Vector2(randf_range(-60,60), randf_range(-60, 60)), 0.05)
		tween.tween_property(self, "position", original_pos, 0.05)
	return tween

func _on_body_entered(body):
	
	if body.is_in_group("Players"):
		var t = shake()
		
		collision.disabled = true
		Supernova.play()
		await t.finished
		Rock.visible = false
		await Supernova.finished
		queue_free()

func _process(delta):
	position += velocity * speed * delta

func _ready() -> void :
	velocity = Vector2(randf_range(-1,1), randf_range(-1, 1)).normalized()
	speed = randf_range(100, 600)
	random_size = Vector2(size, size)
	Rock.scale = random_size
	Hitbox.scale = random_size
