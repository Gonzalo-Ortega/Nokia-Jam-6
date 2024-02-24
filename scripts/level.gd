extends Node

var Note = preload("res://scenes/Note.tscn")
var notes = []
var global_time_step = 0
var step_time = 43


@export var tempo_time = 1.0/256 # In seconds

@export var delay = 1 # In seconds

func read_midi():
	var file = FileAccess.open("res://midi_files/basic_test.json", FileAccess.READ)
	var json = JSON.new()
	var error = json.parse(file.get_as_text())
	if error != OK:
		print("Error parsing JSON")
		return
	var config = json.get_data()
	file.close()

	for instrument in config:
		if instrument.name == "bass":
			for note in instrument["notes"]:
				notes.append(note)

func _ready():

	read_midi()


	$Tempo.wait_time = 0
	$Tempo.start()

var index = 0
func _on_tempo_timeout():

	# Get the first note in the list
	var note = notes[index]

	# Play the note
	$SoundPlayer.play_note_stream(int(note[0]), int(note[2])*tempo_time)

	# Increment the index
	index += 1

	# If there are more notes, schedule the next one
	if index < len(notes):
		var next_note = notes[index]
		$Tempo.wait_time = (int(next_note[1]) - int(note[1]))*tempo_time
		$Tempo.start()
	else:
		$Tempo.stop()

	var note_entity = Note.instantiate()
	note_entity.direction = int((int(note[0]) - 45)*4.0/33)+1
	print(note_entity.direction)
	add_child(note_entity)
	
