extends Move


const ANIMATION_END = 4.8

var hit_damage = 100

func default_lifecycle(input : InputPackage):
	if works_longer_than(ANIMATION_END):
		return best_input_that_can_be_paid(input)
	return "okay"


func update(_input : InputPackage, _delta):
	if works_between(2.2, 3.6): # later will be turned into a backend animation parameter
		player.model.active_weapon.is_attacking = true
	else:
		player.model.active_weapon.is_attacking = false


func form_hit_data(weapon : Weapon) -> HitData:
	var hit = HitData.new()
	hit.damage = hit_damage
	hit.hit_move_animation = animation
	hit.is_parryable = is_parryable()
	hit.weapon = player.model.active_weapon
	return hit


func on_enter_state():
	pass

func on_exit_state():
	player.model.active_weapon.hitbox_ignore_list.clear()
	player.model.active_weapon.is_attacking = false