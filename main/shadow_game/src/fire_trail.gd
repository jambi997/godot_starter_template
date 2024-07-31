extends Area2D

var lighted = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area.is_in_group("shadow"):
		area.shadow.die()
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
