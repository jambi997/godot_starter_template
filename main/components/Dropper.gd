extends Node2D
@onready var drop = load("res://components/rain_drop.tscn")
@export var drop_range = 100
@export_node_path() var parent_path = null
@onready var timer = $Timer
var start_drop_max_time = 1
@onready var drop_max_time = start_drop_max_time
var parent 
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_node(parent_path)
	pass # Replace with function body.

func spawn_drop():
	var tdrop = drop.instantiate()
	tdrop.global_position = global_position
	tdrop.global_position.x += randi_range(-drop_range,drop_range)
	parent.add_child(tdrop)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	if !is_instance_valid(Autoload.player):
		drop_max_time=start_drop_max_time
	spawn_drop()
	timer.wait_time=randi_range(0.2,drop_max_time)
	drop_max_time+=0.1
	pass # Replace with function body.
