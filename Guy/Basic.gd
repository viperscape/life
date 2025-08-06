extends CharacterBody3D

@export var speed = 5
@export var fall_acceleration = 75
@export var turn_speed = 3
var is_moving = false

@export var sight_distance = 7
var tracking_chibi = false

func _physics_process(delta):
	direct_player(delta)
	velocity.y -= fall_acceleration * delta
	move_and_slide()


func direct_player(_delta):
	var speed_ = speed
	if not is_moving:
		speed_ = 0
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.play("Walk")
		
	velocity = $Rig.transform.basis.z * speed_
