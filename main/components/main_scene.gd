extends Node2D
class_name base_game

@onready var player = load("res://shadow_game/src/player.tscn")
@onready var shadow = load("res://shadow_game/src/shadow.tscn")
@onready var torch = load("res://shadow_game/src/torch.tscn")
var entities=[]
var spawningscount=1
# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.world=self
	pass # Replace with function body.

func spawner(spawnable,count,range=500):
	#var range = 500
	for i in count:
		var t_spawn = spawnable.instantiate()
		t_spawn.global_position = Vector2(Autoload.player.global_position.x+ randf_range(-range,range),Autoload.player.global_position.y+ randf_range(-range,range))
		add_child(t_spawn)
		entities.append(t_spawn)

func remove_spawned():
	for entity in entities:
		if is_instance_valid(entity):
			entity.queue_free()

func start_game():
	var t_player = player.instantiate()
	add_child(t_player)
	entities.append(t_player)
	spawner(shadow,1)
	spawner(torch,500,10000)
	pass # Replace with function body.


func _on_timer_timeout():
	spawner(shadow,randf_range(1,spawningscount))
	spawner(torch,1,1000)
	spawningscount+=1
	pass # Replace with function body.
