extends Area3D

var speed = 5
var life_time = 5
var towards = Vector3.ZERO
var endpos = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	destroy(life_time)
	endpos = position.direction_to(towards)
	endpos.z *= -1 # flip direction to shoot forwards

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += endpos.normalized() * speed * delta



func _on_area_entered(area):
	if area.is_in_group("rocks"):
		$shot_hit.play()
		area.destroy()
		get_parent().num_rocks -= 1
		get_parent().add_score(100)
		if get_parent().num_rocks < 0:
			get_parent().num_rocks = 0
			
		visible = false
		destroy(1)


func destroy(delay):
	await get_tree().create_timer(delay).timeout
	queue_free()
