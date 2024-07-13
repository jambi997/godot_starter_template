extends Control

var current_scene:Node=null
var current_menu_scene:Node=null
@onready var map_space: SubViewport = $SubViewportContainer/SubViewport
@onready var ui_space = $UiLayer/Control
var current_ui_element = null
var current_ui_scene_name = null
# Called when the node enters the scene tree for the first time.
func _ready():
	Autoload.root_scene=self
	pass # Replace with function body.

var scenes={
	#"main_map":starter_scene,
	#"main_menu":starter_menu_scene,
	#"origin_chooser":"res://main/src/menus/origin_chooser.tscn",
	##"system_map":"res://main/src/ui/system_map.tscn",
	#"ship_chooser":"res://main/src/ui/ship_chooser.tscn",
	#"settings": "res://main/src/menus/settings.tscn"
}
@onready var ui_elements = {
	#"system_map": system_map  
}

func pause_game():
	if current_scene != null and current_scene.get_tree()!=null:
		current_scene.get_tree().paused = true


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



func change_window_size(temp_size):
	var wsize =temp_size #Vector2i(width,height)
	map_space.size = wsize
	get_window().size = wsize
	#map_space.size_2d_override = wsize 
	pass

func switch_window_type(type):
	DisplayServer.window_set_mode(type)

func Show_ui(ui_name,show):
	remove_scene("ui")
	var ui_element = ui_elements[ui_name]
	ui_element.activate(show)
	#ui_element.set_process(show)
	current_ui_element=ui_name

func remove_scene(type="ui"):
	if type=="ui":
		current_ui_scene_name=""
		if current_menu_scene:
			current_menu_scene.queue_free()
			current_menu_scene=null
			if current_ui_element:
				Show_ui(current_ui_element,false)
			return null
	if type=="map":
		if current_scene:
			current_scene.queue_free()
			current_scene=null
			return null
func Switch_scene(scene,type):
	var scene_name = scene
	scene = scenes[scene]
	if type=="map":
		if current_scene:
			current_scene.queue_free()
			current_scene=null
		if scene == null:
			return
		current_scene=load(scene).instantiate()
		map_space.add_child(current_scene)
		return current_scene
	if type=="ui":
		current_ui_scene_name=scene_name
		if current_menu_scene:
			current_menu_scene.queue_free()
			current_menu_scene=null
		if scene == null:
			return
		current_menu_scene=load(scene).instantiate()
		ui_space.add_child(current_menu_scene)
		return current_menu_scene
	pass

func _input(event):
	if Input.is_action_just_pressed("esc") and ["origin_chooser"].find(current_ui_scene_name)==-1:
		#print(["origin_chooser"].find(current_ui_scene_name),current_ui_scene_name)
		if current_menu_scene:
			remove_scene("ui")
		else:
			Switch_scene("main_menu","ui")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
