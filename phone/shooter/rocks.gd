extends Area3D

var rot_speed = 20
var move_speed = 1
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rocks")
	scale = Vector3(randf_range(0.07, 0.1), randf_range(0.07, 0.1), randf_range(0.07, 0.1))
	set_move_speed(1)
	
func set_move_speed(speed):
	move_speed = randi_range(speed, speed + 0.5)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if paused:
		return

	var rot = delta * rot_speed
	rotation_degrees.x += rot
	rotation_degrees.y += rot
	rotation_degrees.z += rot
	
	if rotation_degrees.y > 360:
		rotation_degrees.y = 0
	if rotation_degrees.x > 360:
		rotation_degrees.x = 0
	if rotation_degrees.z > 360:
		rotation_degrees.z = 0

	position = lerp(position, Vector3(0,0, position.z), move_speed * delta)

func destroy():
	queue_free()

func pause(paused_):
	paused = paused_
