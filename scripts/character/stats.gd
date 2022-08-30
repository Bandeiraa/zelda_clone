extends Node
class_name CharacterStats

export(NodePath) onready var states = get_node(states) as Node
export(NodePath) onready var hurtbox = get_node(hurtbox) as Area2D

var move_state: Node = null
var attack_state: Node = null

export(int) var health
export(int) var move_speed
export(int) var attack_damage

export(float) var attack_cooldown

func _ready() -> void:
	move_state = states.get_node("Move")
	attack_state = states.get_node("Attack")
	
	update_states_properties()
	
	
func update_states_properties() -> void:
	move_state.move_speed = move_speed
	attack_state.attack_cooldown = attack_cooldown
	
	hurtbox.damage = attack_damage
