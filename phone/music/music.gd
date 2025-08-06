extends Node3D

@export var music: Array[Resource] = []
var song_idx = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	select_next()



func _on_skip_forward_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			song_idx += 1
			if song_idx > music.size() - 1:
				song_idx = 0
			select_next()
			$AudioStreamPlayer.play()


func _on_skip_back_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			song_idx -= 1
			if song_idx < 0:
				song_idx = music.size() - 1
			select_next()
			$AudioStreamPlayer.play()


func _on_play_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			print("playing music")
			if $AudioStreamPlayer.playing:
				$AudioStreamPlayer.stop()
				$playing.hide()
				$paused.show()
			else: 
				$AudioStreamPlayer.play()
				$playing.show()
				$paused.hide()


func _on_finished():
	$playing.hide()
	$paused.show()
	await get_tree().create_timer(5).timeout
	$playing.show()
	$paused.hide()
	select_next()
	$AudioStreamPlayer.play()

func select_next():
	$AudioStreamPlayer.stream = music[song_idx]
	$Label3D.text = music[song_idx].resource_path.get_file()
