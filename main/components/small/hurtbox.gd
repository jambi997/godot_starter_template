extends Area2D
class_name hurtbox
@export_node_path("CharacterBody2D") var parent_path = null
#@onready var blood = load("res://Yambi Folder/blood.tscn")
#@onready var parent = get_node(parent_path)
var parent=null
# Called when the node enters the scene tree for the first time.
func _ready():
	if parent_path!=null:
		parent = get_node(parent_path)
	pass # Replace with function body.

func pushed_back(from, area:damage_box):
	parent = get_node(parent_path)
	
	if parent as CharacterBody2D:
		parent.velocity = (parent.global_position-from.global_position).normalized()*area.push_force*parent.push_multiplyer
	else:
		parent.global_position += (parent.global_position-from.global_position).normalized()*area.push_force

#func bleed(pos,damage):
	#var temp_blood:GPUParticles2D = blood.instantiate()
	#temp_blood.amount=damage*2
	#temp_blood.emitting=true
	#parent.add_child(temp_blood)
	#temp_blood.global_position=pos

func take_damage(damage):
	#print(damage ," damage taken")
	#parent.health-=damage
	parent.take_damage(damage)
	if parent.health<=0:
		parent.die()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("damage_box"):
		if area.parent==null:
			take_damage(area.damage)
		if !is_instance_valid(area.parent) or area.parent.is_in_group("enemy") and parent.is_in_group("enemy"):
			return
		if parent!=area.parent:
			print(parent, 'hurted by', area.parent, 'in groups', area.get_groups())
			take_damage(area.damage)
			#bleed(area.global_position,area.damage)
			pushed_back(area.parent, area)
	pass # Replace with function body.
