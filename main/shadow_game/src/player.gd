extends CharacterBody2D

var alive = true
@export var start_health = 5
@onready var health = start_health
@export var start_speed = 100
@export var start_accel = 500
@onready var accel = start_accel
@onready var speed = start_speed
@onready var particles = $GPUParticles2D
@export var animation_player : AnimationPlayer
@onready var flamewalk_timer = $flamewalk_timer
@onready var flamespawn_timer= $flamespawn_timer
@onready var hide_timer = $hide_timer
@export var player_texture : Sprite2D
@onready var start_scale =player_texture.scale.x
@onready var firebolt = load("res://shadow_game/src/fireball.tscn")
@onready var firewalk = load("res://shadow_game/src/fire_trail.tscn")
@onready var waterpush = load("res://shadow_game/src/waterpush.tscn")
@onready var freezeezone = load("res://shadow_game/src/freezee.tscn")
var next_spell = []
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state = rest
var detectable = true

func rest():
	pass

func _ready():
	start_scale=player_texture.scale.x
	Autoload.player=self

func check_animations():
	if ["attack","conjure","cast"].find(animation_player.current_animation)!=-1:
		return true
	else:
		return false

func die():
	Autoload.root_scene.game_over()

func take_damage(damage):
	health-=damage
	if health<=0:
		alive=false
		die()

func _physics_process(delta):
	state.call()
	if speed<start_speed:
		speed+=1
	if speed>start_speed:
		speed*=0.999
	# Add the gravity.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up","down")
	var target = Vector2(
		direction.x*speed*1.5,
		direction.y*speed,
	)
	velocity = velocity.move_toward(target, delta*3000)
	if direction.x>0 and !check_animations():
		player_texture.scale.x=start_scale
	elif direction.x<0 and !check_animations():
		player_texture.scale.x=-start_scale	
	move_and_slide()

func cook_spell(spell):
	speed*=0.2
	match spell:
		"fire":
			particles.set_modulate(Color(1, 0, 0))
		"water":
			particles.set_modulate(Color(0, 0, 1))
		"wind":
			particles.set_modulate(Color(1 ,1, 1))
	particles.emitting=true
	if len(next_spell)<2:
		next_spell.append(spell)
	else:
		next_spell[1]=spell
	print(spell," | " ,next_spell)
	pass

func fireball():
	print("fireball")
	var t_fireball = firebolt.instantiate()
	t_fireball.global_position =global_position
	t_fireball.look_at(get_global_mouse_position())
	Autoload.world.add_child(t_fireball)

func fire_spell():
	if len(next_spell)<2:
		return
	print("spell_fired")
	match next_spell:
		["fire","fire"]:
			fireball()
		["wind","wind"]:
			speed*=5
		["fire","wind"]:
			flamewalk_on()
		["wind","fire"]:
			flamewalk_on()
		["water","water"]:
			shoot_water()
		["water","wind"]:
			freezee()
		["wind","water"]:
			freezee()
		["fire","water"]:
			smoke_hide()
		["water","fire"]:
			smoke_hide()
	next_spell=[]
	

func smoke_hide():
	detectable=false
	hide_timer.start()
	player_texture.visible=false
	pass

func smoke_hide_end():
	detectable=true
	player_texture.visible=true

func freezee():
	var tfreezee = freezeezone.instantiate()
	tfreezee.position = global_position
	tfreezee.look_at(get_global_mouse_position())
	Autoload.world.add_child(tfreezee)
	pass

func shoot_water():
	var tpush = waterpush.instantiate()
	add_child(tpush)
	tpush.look_at(get_global_mouse_position())
	pass

func flamewalk():
	var ftrail = firewalk.instantiate()
	ftrail.global_position = global_position
	Autoload.world.add_child(ftrail)
	pass

func flamewalk_on():
	flamewalk_timer.stop()
	flamewalk_timer.start()
	flamespawn_timer.start()
	pass
	
func flamewalk_off():
	state=rest
	flamespawn_timer.stop()
	pass

func _input(event):
	if Input.is_action_just_pressed("fire"):
		cook_spell("fire")
	if Input.is_action_just_pressed("water"):
		cook_spell("water")
	if Input.is_action_just_pressed("wind"):
		cook_spell("wind")
	if Input.is_action_just_pressed("primary_attack"):
		fire_spell()


func _on_area_2d_area_entered(area):
	if area.is_in_group("shadow"):
		take_damage(area.damage)
		area.shadow.die()
	pass # Replace with function body.


func _on_flamewalk_timer_timeout():
	flamewalk_off()
	pass # Replace with function body.


func _on_flamespawn_timer_timeout():
	flamewalk()
	pass # Replace with function body.


func _on_hide_timer_timeout():
	smoke_hide_end()
	pass # Replace with function body.
