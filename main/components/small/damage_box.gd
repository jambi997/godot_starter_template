extends Area2D
class_name damage_box

@export var push_force = 1500
@export_node_path("CharacterBody2D") var parent_path = null
@export var start_damage = 10
var parent 
@onready var damage = start_damage
# Called when the node enters the scene tree for the first time.
func _ready():
	if parent_path!=null:
		parent=get_node(parent_path)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
