extends Control

var empty = false
@onready var color = $ColorRect.color
var sleepy = 0

signal coffee_value(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value -= delta * 0.33
	emit_signal("coffee_value", $ProgressBar.value)
	if sleepy > 0.9:
		sleepy = 0.9
		$ColorRect/DrinkCoffeeLabel.show()
	else:
		$ColorRect/DrinkCoffeeLabel.hide()
	$ColorRect.color = Color(color, sleepy)
	if $ProgressBar.value < 10:
		sleepy += delta * 0.1
		if not empty:
			empty = true
			$ProgressBar/AudioStreamPlayer.play()


func _on_mug_drink_coffee():
	var val = randi_range(20, 48)
	$ProgressBar.value += val
	sleepy -= val
	if sleepy < 0:
		sleepy = 0


func _on_frogman_pet_frog():
	if $ProgressBar.value > 75:
		$ProgressBar.value = 75


func _on_book_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_released():
			var link = "https://www.youtube.com/@thenamelessdev"
			OS.shell_open(link)
