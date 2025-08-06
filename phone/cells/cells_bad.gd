extends Area3D

var player
var speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("cells")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward(player.position, speed * delta)

func destroy():
	queue_free()
