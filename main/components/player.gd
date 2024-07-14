extends CharacterBody2D


@export var  SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
#@export var size = "SMALL"
@export_enum("SMALL","MEDIUM","LARGE") var size= "SMALL"
@onready var size_chooser = $SizeChooser
@onready var last_size = size
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var bullet = load("res://components/water_bullet.tscn")
var alive = true

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

func _ready():
	size_chooser.play("SMALL")
	Autoload.player=self

func check_animations():
	if ["turn_up","turn_down","die","shoot_vertical","shoot_horizontal"].find(anim_players[size].current_animation)!=-1:
		return false
	else:
		return true

func switch_size(s):
	size_chooser.play(s)
	match size:
		"SMALL":
			JUMP_VELOCITY=-400
			SPEED=150
		"MEDIUM":
			JUMP_VELOCITY=-250
			SPEED=100
		"LARGE":
			SPEED=50
			JUMP_VELOCITY=-100
	sprites[size].scale = sprites[last_size].scale
	last_size=size

func die():
	anim_players["SMALL"].play("die")
	alive=false
	pass

func shoot(dir):
	var anim_player:AnimationPlayer = anim_players[size] 
	var tbullet:water_bullet = bullet.instantiate()
	match dir:
		"horizontal":
			pass
			anim_player.play("shoot_horizontal")
			tbullet.dir="horizontal"
			tbullet.speed *= -sprites[size].scale.x
		"vertical":
			anim_player.play("shoot_vertical")
			tbullet.dir = "vertical"
	tbullet.global_position=global_position
	tbullet.position.y-=10
	Autoload.world.add_child(tbullet)
	pass

func gain_health():
	print(size)
	if !alive:
		return
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
	if !alive:
		return
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
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !alive or !check_animations():
		return
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Add the gravity.
	if not is_on_floor() and check_animations():
		anim_players[size].play("jump")
	elif check_animations():
		if velocity.length()>0:
			anim_players[size].play("run")
			sprites[size].scale.x = direction
		else:
			anim_players[size].play("idle")
	if last_size!=size:
		switch_size(size)
	#if velocity.length()>0:
		#sprites[size].scale.x = direction
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("primary_attack") and check_animations() and size!="SMALL":
		shoot("horizontal")
	if Input.is_action_just_pressed("secondary_attack") and check_animations() and size!="SMALL":
		shoot("vertical")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()


func _on_small_player_animation_finished(anim_name):
	#if anim_name=="turn_up":
		#size="MEDIUM"
	pass # Replace with function body.


func _on_medium_player_animation_finished(anim_name):
	if anim_name == "shoot_horizontal" or anim_name == "shoot_vertical":
			size_chooser.play("SMALL")
	#if anim_name=="turn_up":
		#size="LARGE"
	#if anim_name=="turn_down":
		#size ="SMALL"
	pass
func _on_large_player_animation_finished(anim_name):
	if anim_name == "shoot_horizontal" or anim_name == "shoot_vertical":
			size_chooser.play("MEDIUM")
		#size ="MEDIUM"
	pass
