extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("bird") and body.state=="FLY":
		body.state="WALK"
		Autoload.flying_birds-=1
		Autoload.ground_birds+=1
	pass # Replace with function body.
