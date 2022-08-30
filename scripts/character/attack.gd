extends Node
class_name AttackState

onready var attack_timer: Timer = get_node("AttackTimer")

var parent: Node = null

export(float) var attack_cooldown

func attack() -> void:
	if Input.is_action_just_pressed("ui_left_click") and not parent.character.on_action:
		attack_timer.start(attack_cooldown)
		parent.character.change_action_state("attack", true)
		
		
func on_attack_timer_timeout():
	parent.character.change_action_state("", false)
