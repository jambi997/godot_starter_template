extends Area2D

var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y +=speed
	rotation_degrees+=1
	pass


func _on_area_entered(area):
	if area.is_in_group("player"):
		area.parent.take_damage(1)
		queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("static"):
		queue_free()
	pass # Replace with function body.
