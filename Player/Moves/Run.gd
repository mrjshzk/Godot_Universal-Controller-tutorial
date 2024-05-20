extends Move


const SPEED = 3.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func default_lifecycle(input : InputPackage):
	if not humanoid.is_on_floor():
		return "midair"
	
	return best_input_that_can_be_paid(input)


func update(input : InputPackage, delta : float):
	humanoid.velocity = velocity_by_input(input, delta)
	humanoid.look_at(humanoid.global_position - humanoid.velocity)
	humanoid.move_and_slide()


func velocity_by_input(input : InputPackage, delta : float) -> Vector3:
	var new_velocity = humanoid.velocity
	
	var direction = (humanoid.camera_mount.basis * Vector3(-input.input_direction.x, 0, -input.input_direction.y)).normalized()
	new_velocity.x = direction.x * SPEED
	new_velocity.z = direction.z * SPEED
	
	if not humanoid.is_on_floor():
		new_velocity.y -= gravity * delta
	
	#print(new_velocity)
	return new_velocity
