extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.world=self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	pass # Replace with function body.


func _on_redirceter_body_entered(body):
	pass # Replace with function body.


func _on_score_timer_timeout():
	if Autoload.player.alive:
		Autoload.score+=1
	
	pass # Replace with function body.
