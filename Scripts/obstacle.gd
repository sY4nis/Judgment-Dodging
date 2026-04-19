extends Area2D
#Les asteroids seront destructibles 
#Au contacte du joueur ils explosent et tuent le joueur
# il se deplaseront au hasard 
# leurs vitesses sera generé au hasard 
# leurs tailleurs sera aussi generé au hasard
@onready var Supernova = $SUPERNOVA
@export var speed : int = 300
@export var velocity = Vector2(1,1)



func shake():
	var tween = create_tween()
	var original_pos = position
	for i in 5:
		tween.tween_property(self, "position", original_pos + Vector2(randf_range(-60,60), randf_range(-60, 60)), 0.05)
		tween.tween_property(self, "position", original_pos, 0.05)

func _on_body_entered(body):
	if body.is_in_group("Players"):
		print("touché")
		Supernova.play()
		shake()
	pass # Replace with function body.
	
func _process(delta):
	position += velocity * speed * delta

func _ready() -> void :
	velocity = Vector2(randf_range(-1,1), randf_range(-1, 1)).normalized()
