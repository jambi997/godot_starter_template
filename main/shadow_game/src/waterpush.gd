extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("shadow"):
		body.velocity=(body.global_position-global_position).normalized()*500
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
