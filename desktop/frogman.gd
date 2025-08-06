extends Node3D

signal pet_frog()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		$AnimationPlayer.play("wave")
		emit_signal("pet_frog")
