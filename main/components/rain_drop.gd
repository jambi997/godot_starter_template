extends Area2D

@export var falling = false
@onready var anim_player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling:
		position.y +=2
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="drop":
		falling=true
		anim_player.play("fall")
	if anim_name=="splash":
		queue_free()
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("static"):
		falling=false
		anim_player.play("splash")
	pass # Replace with function body.


func _on_area_entered(area):
	if area.is_in_group("player") and Autoload.player.size!="LARGE":
		area.parent.gain_health()
		queue_free()
		Autoload.score+=5
		pass
		#player.
	pass # Replace with function body.
