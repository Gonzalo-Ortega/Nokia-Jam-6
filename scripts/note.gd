extends StaticBody2D

var time = 0
var speed = 4
var tone = 1
var direction = 1

var viewport_rect
var rng = RandomNumberGenerator.new()


func  _ready():
	viewport_rect = get_viewport_rect()
	position = viewport_rect.get_center()
	direction = randi_range (1, 4)


func configure(time, speed, tone):
	self.time = time
	self.speed = speed
	self.tone = tone


func _on_tempo_timeout():
	match direction:
		1: position.x -= speed
		2: position.x += speed
		3: position.y -= speed
		4: position.y += speed
	
	if is_out_of_screen():
		#queue_free()
		pass


func is_out_of_screen() -> bool:
	
	return position.x < viewport_rect.size.x - 10 || \
		   position.x > viewport_rect.size.x + 10 || \
		   position.y < viewport_rect.size.y - 10 || \
		   position.y > viewport_rect.size.y + 10
