extends Node


func _ready():
	$Tempo.start()
	$Square.position = Vector2(40, 40)
	$Bar.position = Vector2(40, 4)


func _on_tempo_timeout():
	$TempoBeat.play()
	$Tempo.start()
	$Square.position.y -= 3
