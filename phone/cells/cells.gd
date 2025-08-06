extends Node3D

var next_pos = Vector3.ZERO
var last_pos = Vector3.ZERO
var speed = 0.5
var score = 0

var max_fruit = 5
var num_fruit = 0

var paused = true
var gameover = false

var fruit = [load("res://phone/cells/charge.tscn")]
var cells_bad = load("res://phone/cells/cells_bad.tscn")

var level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	paused = not visible
	get_tree().call_group("charges", "pause", paused)
	get_tree().call_group("cells", "pause", paused)
	
	if not paused and not gameover:
		if num_fruit < 1:
			level += 1
			spawn_cells_bad()
			num_fruit = randi_range(1, max_fruit)
			for n in num_fruit:
				spawn_fruit()
		
		last_pos = $world/cells.position
		if next_pos != Vector3.ZERO:
			$world/cells.position = $world/cells.position.move_toward(next_pos, speed * delta)
			$world.position = $world.position.move_toward(-last_pos, speed * delta)
		
	if gameover:
		get_tree().call_group("cells", "pause", paused)


func _on_phone_app_interact(mouse_pos):
	if Input.is_action_pressed("cells_tap"):
		var pos = mouse_pos
		pos.x = -pos.x
		pos.x += $world/cells.position.x
		pos.y += $world/cells.position.y
		pos.z = 0
		
		next_pos = pos
	else:
		next_pos = Vector3.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if gameover:
			gameover = false
			score = 0
			$world/cells.show()
			$gameover.hide()
			get_tree().call_group("cells", "destroy")
			get_tree().call_group("charges", "destroy")
			num_fruit = 0
			$score.text = str(score)

func eat(score_):
	score += score_
	$score.text = str(score)
	$eat.play()

func spawn_fruit():
	var fruit_ = fruit.pick_random().instantiate()
	fruit_.position = Vector3($world/cells.position.x + randf_range(-1, 1), $world/cells.position.y + randf_range(-2, 2), position.z)
	#fruit_.scale *= level
	$world.add_child(fruit_)
	
func spawn_cells_bad():
	var cell = cells_bad.instantiate()
	cell.position = Vector3($world/cells.position.x + randf_range(-1, 1), $world/cells.position.y + randf_range(-2, 2), position.z)
	cell.player = $world/cells
	#fruit_.scale *= level
	$world.add_child(cell)


func _on_cells_area_entered(area):
	if area.is_in_group("charges"):
		num_fruit -= 1
		if num_fruit < 0:
			num_fruit = 0
		area.destroy()
		
		eat(100)

	elif area.is_in_group("cells"):
		$world/cells.hide()
		gameover = true
		$gameover_audio.play()
		$gameover.show()
