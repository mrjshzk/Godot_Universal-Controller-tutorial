extends Move
class_name JumpRun

const VERTICAL_SPEED_ADDED : float = 2.5

const TRANSITION_TIMING = 0.44
const JUMP_TIMING = 0.1

var jumped : bool = false

func _ready():
	animation = "jump_run"
	move_name = "jump_run"


func check_relevance(_input : InputPackage):
	if works_longer_than(TRANSITION_TIMING):
		jumped = false
		return "midair"
	else: 
		return "okay"


func update(_input : InputPackage, delta ):
	if works_longer_than(JUMP_TIMING):
		if not jumped:
			player.velocity.y += VERTICAL_SPEED_ADDED
			jumped = true
	player.move_and_slide()