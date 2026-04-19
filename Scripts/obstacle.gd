extends Area2D
#Les asteroids seront destructibles 
#Au contacte du joueur ils explosent et tuent le joueur
# il se deplaseront au hasard 
# leurs vitesses sera generé au hasard
#il y'aura 3 types d'asteroides en terme de forme 
# leurs tailleurs sera aussi generé au hasard

func _on_body_entered(body):
	if body.is_in_group("Players"):
		print("touché")
	pass # Replace with function body.
