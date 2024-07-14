extends Marker2D

@onready var timer = $Timer
@export var spawn_range=15
@onready var bird = load("res://components/bird.tscn")
@export_enum("WALK","FLY") var bird_state="WALK"
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time=randi_range(spawn_range/3,spawn_range)
	timer.start()
	pass # Replace with function body.

func spawn_bird():
	var tbird = bird.instantiate()
	tbird.global_position = global_position
	tbird.state=bird_state
	if bird_state=="FLY":
		tbird.position.y+=randi_range(-5,5)
		tbird.position.x+=randi_range(-40,40)
		#var rscale = randi_range(0.2,0.5)
		#tbird.scale=Vector2(rscale,rscale)
		Autoload.flying_birds +=1
	else:
		Autoload.ground_birds +=1
	Autoload.world.add_child(tbird)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if Autoload.player.alive:
		if bird_state=="FLY" and Autoload.flying_birds>=2:
			return
		if bird_state=="WALK" and Autoload.ground_birds>=3:
			return
		spawn_bird()
		timer.wait_time=randi_range(2,spawn_range)
	else:
		timer.stop()
	pass # Replace with function body.
