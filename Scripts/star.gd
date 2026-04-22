extends Area2D
@onready var UNDERTALE = $UNDERTALE
@onready var Etoile = $Etoile
@onready var collision = $CollisionShape2D
@onready var taken = false

func _on_body_entered(body):
	if body.is_in_group("Players") and not taken:
		taken = true
		get_parent().stars += 1
		UNDERTALE.play()
		Etoile.visible = false
		collision.disabled = true
		await UNDERTALE.finished
		queue_free()
		
	pass # Replace with function body.

func _ready():
	Etoile.play("IDLE")



