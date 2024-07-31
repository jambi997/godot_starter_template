extends Node2D

@onready var area = $Area2D
@onready var light = $PointLight2D
@onready var col_shape = $Area2D/CollisionShape2D
var life = 3
var lighted = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lights_out():
	#area.monitoring=false
	#area.monitorable=false
	#col_shape.disabled=true
	light.enabled=false
	lighted=false
	
func lights_on():
	light.enabled=true
	lighted=true
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("shadow"):
		life-=1
		if lighted:
			area.shadow.die()
		if life<0:
			lights_out()
		if life<-3:
			queue_free()
	if area.is_in_group("light"):
		lights_on()
	pass # Replace with function body.
