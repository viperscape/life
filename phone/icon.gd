extends Node3D

@export var app: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().call_group("phone", "run_app", app)
