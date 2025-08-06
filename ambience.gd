extends AudioStreamPlayer

@onready var volume_orig = volume_db

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not playing:
		play()


func _on_control_coffee_value(value):
	if value < 30:
		volume_db = -50
	else:
		volume_db = volume_orig
