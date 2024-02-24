extends Node

var note_streams = {}

# Load all wav streams from the directory
func load_wav_files(directory):
	var dir = DirAccess.open(directory)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if file_name.get_extension() == "wav":
			var stream = load(directory + "/" + file_name)
			note_streams[int(file_name.replace(".wav", ""))] = stream
		file_name = dir.get_next()
	dir.list_dir_end()

func play_note_stream(index, duration):
	if index in note_streams:
		var stream = note_streams[index]
		$Timer.wait_time = duration
		$Timer.start()
		$AudioStreamPlayer.stream = stream
		$AudioStreamPlayer.play()

# Called when the AudioStreamPlayer is done playing
func _on_audio_stream_player_finished():
	# If the timer is still running, repeat the note
	if $Timer.is_stopped() == false:
		$AudioStreamPlayer.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	load_wav_files("res://assets/sounds/midi_sounds")


func _on_timer_timeout():
	$AudioStreamPlayer.stop()
