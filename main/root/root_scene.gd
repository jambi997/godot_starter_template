extends Control

var current_scene:Node=null
var current_menu_scene:Node=null
@onready var map_space: SubViewport = $SubViewportContainer/SubViewport
@onready var ui_space = $UiLayer/Control
var current_ui_element = null
var current_ui_scene_name = null
@onready var game:base_game = $SubViewportContainer/SubViewport/MainScene
@onready var menu:Control = $UiLayer/Control/Menu
@onready var death = $UiLayer/Control/Death
# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.root_scene=self
	pass # Replace with function body.

func pause_game():
	if current_scene != null and current_scene.get_tree()!=null:
		current_scene.get_tree().paused = true

func show_menu():
	$UiLayer/Control/Menu.visible=true

func hide_menu():
	$UiLayer/Control/Menu.visible=false

func turn_resolution_into_vector(resolution):
	var res = resolution.split("x")
	return Vector2i(int(res[0]),int(res[1]))
	pass

func change_resolution(resolution):
	# var size = scene_size[resolution]
	var res = turn_resolution_into_vector(resolution)
	change_window_size(res)
	pass

func continue_game():
	if current_scene != null and current_scene.get_tree()!=null:
		current_scene.get_tree().paused = false

func game_over():
	death.show()

func change_window_size(temp_size):
	var wsize =temp_size #Vector2i(width,height)
	map_space.size = wsize
	get_window().size = wsize
	#map_space.size_2d_override = wsize 
	pass

func switch_window_type(type):
	DisplayServer.window_set_mode(type)


func _input(event):
	if Input.is_action_just_pressed("esc"):
		pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	game.start_game()
	menu.hide()
	pass # Replace with function body.


func _on_retry_pressed():
	game.start_game()
	death.hide()
	pass # Replace with function body.
