extends Node3D

signal drink_coffee()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_area_3d_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_released():
			$AnimationPlayer.play("drink")
			await $AnimationPlayer.animation_finished
			emit_signal("drink_coffee")
			$AudioStreamPlayer.play()
