extends Area2D
class_name water_bullet
@export_enum("horizontal","vertical") var dir 
var speed=3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match dir:
		"horizontal":
			position.x-=speed
			pass
		"vertical":
			position.y-=speed*0.8
			pass
	pass
