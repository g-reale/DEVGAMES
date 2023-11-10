extends Control

@onready var AudioPlayer = $AudioStreamPlayer2D
var booted = true

#user pressed a key
func _unhandled_input(event):
	if event is InputEventKey and booted:
		AudioPlayer.play()
		booted = false 

#finshed playng boot audi. Start game 
func _on_audio_stream_player_2d_finished():
	get_tree().change_scene_to_file("res://scenes/editor/editor.tscn")
