extends CharacterBody2D
class_name base_shadow

var alive = true
@export var start_health = 10
@onready var health = start_health
@export var start_speed = 60
@export var start_accel = 300
@onready var accel = start_accel
@onready var speed = start_speed
@onready var target = Autoload.player
@onready var dir = $Direction
@onready var start_scale = $Direction.scale.x
@export var animation_player : AnimationPlayer

func check_animations():
	if ["attack","conjure","cast"].find(animation_player.current_animation)!=-1:
		return true
	else:
		return false

func _physics_process(delta):
	if !alive or !is_instance_valid(target):
		return
	#print("helo")
	if speed<start_speed:
		speed+=0.1
	var distance = global_position.distance_to(target.global_position)
	#var direction = global_position.direction_to(target.global_position)
	var direction = global_position.direction_to(Vector2(target.global_position.x,target.global_position.y))
	if direction.x>0:
		dir.scale.x=start_scale
	elif direction.x<0:
		dir.scale.x=-start_scale
	if velocity.length()>0 and !check_animations():
		animation_player.play("run")
	elif !check_animations():
		animation_player.play("idle")
	#if !check_animations():
	if target.detectable==true:
		velocity = velocity.move_toward(direction * speed, delta * accel)
	move_and_slide()
	dir.scale.x = sign(direction.x)


func die():
	queue_free()


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
#
#
func _on_area_2d_area_entered(area):
	#if area.is_in_group("ligth"):
		#die()
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.


func _on_timer_2_timeout():
	speed+=10
	pass # Replace with function body.
