extends Node


var Note = preload("res://scenes/Note.tscn")
var notes = []

@export var tempo_time = 1 # In seconds


func _ready():
	$Tempo.wait_time = tempo_time
	$Tempo.start()


func _on_tempo_timeout():
	$TempoBeat.play()
	$Tempo.start()
	var note = Note.instantiate()
	$Tempo.timeout.connect(note._on_tempo_timeout)
	add_child(note)
	
