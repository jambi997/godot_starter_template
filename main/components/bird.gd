extends CharacterBody2D


@export var SPEED = 20.0
@export var FLYING_SPEED = 25
var JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_enum("WALK","FLY")var state= "WALK"
@onready var player = Autoload.player
@onready var anim_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var direction_timer = $DirectionTimer
var alive = true
var direction = 1
func _ready():
	pass

func check_animations():
	if ["fall","death","attack"].find(anim_player.current_animation)!=-1:
		return false
	else:
		return true

func _physics_process(delta):
	# Add the gravity.
	if !check_animations():
		return
	match state:
		"WALK":
			if global_position<player.global_position:
				direction=1
			else:
				direction=-1
			if direction and player.alive:
				velocity.x = (direction * SPEED)
				anim_player.play("run")
			if not is_on_floor():
				velocity.y += gravity * delta
		"FLY":
			if direction_timer.is_stopped():
				direction_timer.start()
			if direction:
				velocity.x = (direction * FLYING_SPEED)
				anim_player.play("fly")
	if velocity.length()>0:
		sprite.scale.x = direction
	move_and_slide()

func die():
	anim_player.play("death")
	alive = false
	pass

func _on_area_2d_area_entered(area):
	if area.is_in_group("bullet"):
		die()
		area.queue_free()
	pass # Replace with function body.


func _on_sense_area_entered(area):
	if area.is_in_group("player") and alive:
		anim_player.play("attack")
	pass # Replace with function body.


func _on_damage_area_entered(area):
	if area.is_in_group("player") and alive:
		area.parent.take_damage(1)
	pass # Replace with function body.


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="death" or anim_name=="fall":
		queue_free()
	pass # Replace with function body.


func _on_direction_timer_timeout():
	direction*=-1
	direction_timer.wait_time=randi_range(1,10)
	pass # Replace with function body.


func _on_health_body_entered(body):
	if body.is_in_group("bird") and body!=self:
		direction*=-1
	pass # Replace with function body.