extends Node

var next_track =null
@export_enum("loop","menu","game") var mode = "menu"
@onready var track_player = $AudioStreamPlayer2D
enum song_list{
	main_theme,
	new_guy,
	ambiance,
	boss1,
	copper,
	dream_with_me,
	one_with_the_light,
	follow_my_command,
	heretic_leader,
	i_dont_even_need_guns,
	star_xs,
	tensions_building,
	theme_ybits,
	the_day_we_won_back_freedom,
	this_is_not_over,
	who_are_these_people,
	you_belong_in_the_stars,
	you_dont_know
}
var loaded = {}
var song_path = {
	#song_list.main_theme:"res://main/sound/music/Theme_YBITS.wav",
	#song_list.new_guy:"res://main/sound/music/Are_You_The_New_Guy.alp.wav",
	#song_list.ambiance:"res://main/sound/music/Beautiful_Ambiance.wav",
	#song_list.boss1:"res://main/sound/music/Boss_1.wav",
	#song_list.copper:"res://main/sound/music/Copper.wav",
	#song_list.dream_with_me:"res://main/sound/music/Dream_With_Me.wav",
	#song_list.one_with_the_light:"res://main/sound/music/Druid_Theme_-_One_With_The_Light.wav",
	#song_list.follow_my_command:"res://main/sound/music/Follow_My_Command.wav",
	#song_list.heretic_leader:"res://main/sound/music/Heretic_Leader.wav",
	#song_list.i_dont_even_need_guns:"res://main/sound/music/I_Dont_Even_Need_Guns.wav",
	#song_list.star_xs:"res://main/sound/music/Star_XS-523.wav",
	#song_list.tensions_building:"res://main/sound/music/Tension_Building.wav",
	#song_list.theme_ybits:"res://main/sound/music/Theme_YBITS.wav",
	#song_list.the_day_we_won_back_freedom:"res://main/sound/music/The_Day_We_Won_Back_Freedom.wav",
	#song_list.this_is_not_over:"res://main/sound/music/This_Is_Not_Over.wav",
	#song_list.who_are_these_people:"res://main/sound/music/Who_Are_These_People.wav",
	#song_list.you_belong_in_the_stars:"res://main/sound/music/You_Belong_In_The_Stars.wav",
	#song_list.you_dont_know:"res://main/sound/music/You_Dont_Know_Whats_Out_There.wav"
}

var random_menu_music=[
	"main_theme",
	"ambiance",
	"copper",
	"theme_ybits",
	"you_belong_in_the_stars",
	"you_dont_know",
]

var random_game_music=[
	"ambiance",
	"copper",
	"dream_with_me",
	"one_with_the_light",
	"star_xs",
	"tensions_building",
	"theme_ybits",
	"the_day_we_won_back_freedom",
	"this_is_not_over",
	"who_are_these_people",
	"you_belong_in_the_stars",
	"you_dont_know",
	"follow_my_command",
	"heretic_leader",
	"i_dont_even_need_guns",
	"star_xs",
	"tensions_building",
]

var random_travel_music=[
	"ambiance",
	"copper",
	"dream_with_me",
	"one_with_the_light",
	"star_xs",
	"tensions_building",
	"theme_ybits",
	"the_day_we_won_back_freedom",
	"this_is_not_over",
	"who_are_these_people",
	"you_belong_in_the_stars",
	"you_dont_know",
]

var random_battle_music=[
	"who_are_these_people",
	"i_dont_even_need_guns",
]

var random_boss_music=[
	"boss1",
	"heretic_leader",
	"i_dont_even_need_guns",
	"star_xs",
]

var music_groups={
	"menu": random_menu_music,
	"game":random_game_music,
	"loop":null
}
# Called when the node enters the scene tree for the first time.
func preload_music(song,songlist=song_list):
	loaded[songlist[song]] = load(song_path[songlist[song]])
	pass
	
func _ready():
	Autoload.music_player=self
	#play("main_theme")
	#play_random_track(music_groups[mode])
	pass # Replace with function body.

func play_random_track(tracks=random_game_music):
	var chosen_track=tracks[randi()%tracks.size()]
	print(tracks,"these are the random tracks, this is the chosen track: ",chosen_track)
	play(chosen_track)

func play(track_name):
	#track_player.stream= load(tracks[track_name])
	if track_name not in loaded.keys():
		await preload_music(track_name)
	print(track_name,"this_music_started_playing")
	track_player.stream = loaded[song_list[track_name]]
	track_player.playing=true
	if mode=="loop":
		next_track=track_name
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_2d_finished():
	if next_track:
		play(next_track)
		next_track=null
	elif mode!="loop":
		play_random_track(music_groups[mode])
	pass # Replace with function body.

