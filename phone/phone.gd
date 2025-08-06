extends Node3D

@onready var camera_zoom = $Control/SubViewportContainer/SubViewport/Camera3D.size
signal app_interact(mouse_pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("phone")
	$backdrop.show()


func run_app(app):
	print("running ", app)
	$Armature/Skeleton3D/screen/screen/apps.hide()
	$Control.show()
	$Armature/Skeleton3D/screen/screen/Area3D.show()
	
	$Armature/Skeleton3D/screen/screen/ScreenViewPort.show()
	
	if app == "cells":
		$games/cells.show()
	elif app == "shooter":
		$games/shooter.show()
	elif app == "music":
		$Armature/Skeleton3D/screen/screen/music.show()
		$Armature/Skeleton3D/screen/screen/ScreenViewPort.hide()
	

func _on_area_3d_input_event(_camera, event, ev_position, _normal, _shape_idx):
	if event is InputEventMouseMotion:
		emit_signal("app_interact", ev_position)


func _on_button_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouse:
		if event.is_pressed():
			$Armature/Skeleton3D/screen/screen/apps.show()
			$Control.hide()
			$Armature/Skeleton3D/screen/screen/Area3D.hide()
			$Armature/Skeleton3D/screen/screen/ScreenViewPort.hide()
			
			$games/cells.hide()
			$games/shooter.hide()
			$Armature/Skeleton3D/screen/screen/music.hide()


func _on_control_coffee_value(value):
	if value > 80:
		$AnimationPlayer.speed_scale = 3.2
	elif value > 75:
		$AnimationPlayer.speed_scale = 2.8
	elif value > 28:
		$AnimationPlayer.speed_scale = 1
	else:
		$AnimationPlayer.speed_scale = 0.5


func _on_phone_area_3d_mouse_entered() -> void:
	print("mouse entered!")
