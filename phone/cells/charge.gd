extends Area3D

var paused = true
var rot_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("charges")
	rotation_degrees.y += randi_range(1, 359)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paused:
		return

	var rot = delta * rot_speed
	rotation_degrees.x += rot
	rotation_degrees.y += rot
	#rotation_degrees.z += rot
	
	if rotation_degrees.y > 360:
		rotation_degrees.y = 0
	if rotation_degrees.x > 360:
		rotation_degrees.x = 0
	#if rotation_degrees.z > 360:
	#	rotation_degrees.z = 0

func destroy():
	queue_free()

func pause(paused_):
	paused = paused_
