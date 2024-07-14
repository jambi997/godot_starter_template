extends Node2D
class_name base_game

@onready var player = load("res://components/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.world=self
	pass # Replace with function body.

func start_game():
	Autoload.score=0
	$Node2D/walk_bird_spawner/Timer.start()
	$Node2D/walk_bird_spawner2/Timer.start()
	$Node2D/walk_bird_spawner3/Timer.start()
	$ScoreTimer.start()
	var tplayer = player.instantiate()
	add_child(tplayer)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	pass # Replace with function body.


func _on_redirceter_body_entered(body):
	pass # Replace with function body.


func _on_score_timer_timeout():
	if is_instance_valid(Autoload.player) and Autoload.player.alive:
		Autoload.score+=1
	
	pass # Replace with function body.
