extends CharacterBody2D


@export var  SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
#@export var size = "SMALL"
@export_enum("SMALL","MEDIUM","LARGE") var size= "SMALL"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim_players = {
	"SMALL":$SmallPlayer,
	"MEDIUM": $MediumPlayer,
	"LARGE": $LargePlayer
}
@onready var sprites = {
	"SMALL":$small,
	"MEDIUM": $medium,
	"LARGE": $large
}

func switch_size(s):
	match size:
		"SMALL":
			pass
		"MEDIUM":
			pass
		"HIGH":
			pass

func die():
	anim_players["SMALL"].play("die")
	pass

func gain_health():
	match size:
		"SMALL":
			#switch_size("MEDIUM")
			$SmallPlayer.play("turn_up")
		"MEDIUM":
			#switch_size("LARGE")
			$MediumPlayer.play("turn_up")
		"LARGE":
			pass

func take_damage(damage):
	match size:
		"SMALL":
			die()
		"MEDIUM":
			$MediumPlayer.play("turn_down")
			#switch_size("SMALL")
		"LARGE":
			$LargePlayer.play("turn_down")
			#switch_size("MEDIUM")
	pass

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		anim_players[size].play("jump")
	else:
		if velocity.length()>0:
			anim_players[size].play("run")
			sprites[size].scale.x = direction
		else:
			anim_players[size].play("idle")
	#if velocity.length()>0:
		#sprites[size].scale.x = direction
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()


func _on_small_player_animation_finished(anim_name):
	#if anim_name=="turn_up":
		#size="MEDIUM"
	pass # Replace with function body.


func _on_medium_player_animation_finished(anim_name):
	#if anim_name=="turn_up":
		#size="LARGE"
	#if anim_name=="turn_down":
		#size ="SMALL"
	pass
func _on_large_player_animation_finished(anim_name):
	#if anim_name=="turn_down":
		#size ="MEDIUM"
	pass
