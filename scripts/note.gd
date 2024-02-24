extends StaticBody2D

var time = 0
var delay = 1
var tone = 1
var direction = 1

var viewport_rect
var rng = RandomNumberGenerator.new()


func  _ready():
	viewport_rect = get_viewport_rect()
	position = viewport_rect.get_center()

# Get delta vector from speed and dir
func get_delta_vector():
	var delta = Vector2()
	if direction == 1:
		delta = Vector2(1, 0)
	if direction == 2:
		delta = Vector2(0, 1)
	if direction == 3:
		delta = Vector2(-1, 0)
	if direction == 4:
		delta = Vector2(0, -1)
	return delta * (18.0/delay)


# Move exactly 10u in delay seconds
func _process(delta):
	position += get_delta_vector()*delta

func _on_timer_timeout():

	# Remove this object from the scene
	queue_free()
