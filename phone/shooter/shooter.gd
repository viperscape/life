extends Node3D

var next_pos = Vector3.ZERO
var speed = 0.5

var paused = true
var rocks = [load("res://phone/shooter/rock1.tscn"), load("res://phone/shooter/rock2.tscn"), load("res://phone/shooter/rock3.tscn"), load("res://phone/shooter/rock4.tscn"), load("res://phone/shooter/rock5.tscn")]
var shot = load("res://phone/shooter/shot.tscn")
var level = 1
var lives = 1
var num_rocks = 0

var shoot_delay = 0.35 # ms
var shoot_time = shoot_delay + 0.33

var score = 0
var gameover = false

var is_interacting := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_score(score_):
	score += score_
	$score.text = str(score)
	if score == 10000:
		level += 1
	elif score == 8000:
		level += 1
	elif score == 6000:
		level += 1
	elif score == 4000:
		level += 1
	elif score == 2200:
		level += 1
	elif score == 1000:
		level += 1
	
	lives = level
	if $lives.text.length() < lives:
		$lives.text = ""
		for n in lives:
			$lives.text += "҉"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	paused = not visible
	get_tree().call_group("rocks", "pause", paused)
	if gameover:
		$shooter.hide()
	
	if not paused and not gameover:
		if shoot_time > 0:
			shoot_time -= delta
		
		if position != next_pos:
			$shooter.look_at(next_pos, Vector3(0, 0, 1))
		if num_rocks < 1:
			if level == 1:
				add_rock(1)
			elif level == 2:
				add_rock(1)
				add_rock(1)
			elif level == 3:
				add_rock(2)
			elif level == 4:
				add_rock(2)
				add_rock(2)
			elif level == 5:
				add_rock(3)
			elif level == 6:
				add_rock(3)
				add_rock(3)

func _input(event):
	if event is InputEventMouseButton and is_interacting:
		if shoot_time > 0:
			return
		
		shoot_time = shoot_delay
		
		var shot_ = shot.instantiate()
		shot_.position = position #$shooter/muzzle.global_position # fixme if mouse is too close to ship, shoots wrong way from muzzle
		shot_.position.z = 0
		shot_.towards = next_pos
		
		add_child(shot_)
		
		if gameover:
			gameover = false
			$gameover.hide()
			$shooter.show()
			level = 1
			score = 0
			add_score(0) #trigger visuals

func _on_phone_app_interact(mouse_pos):
	is_interacting = true
	var pos = mouse_pos
	pos.x = -pos.x
	pos.x *= 0.25
	pos.y *= 0.22
	pos.z = 0
	next_pos = pos

# player gets hit
func _on_shooter_area_entered(area):
	if area.is_in_group("rocks"):
		if lives > 0:
			lives -= 1
			$lives.text = $lives.text.erase(0, 1)
			$shooter_get_hit.play()
		else:
			gameover = true
			$gameover.show()
			$gameover_audio.play()
		num_rocks -= 1
		if num_rocks < 0:
			num_rocks = 0
		area.destroy()


func add_rock(move_speed):
	var rock = rocks.pick_random().instantiate()
	rock.position = Vector3(position.x + randf_range(-6, 6), position.y + randf_range(-6, 6), position.z)
	rock.set_move_speed(move_speed)
	add_child(rock)
	num_rocks += 1


func _on_area_3d_mouse_exited() -> void:
	is_interacting = false
