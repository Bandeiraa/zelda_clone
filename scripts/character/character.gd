extends KinematicBody2D
class_name Character

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")

onready var character_texture: Sprite = get_node("Texture")

onready var states: Node = get_node("States")
onready var move_state: Node = states.get_node("Move")
onready var attack_state: Node = states.get_node("Attack")

var on_action: bool = false
var current_action: String = ""

func _physics_process(_delta: float) -> void:
	move_state.velocity = move_and_slide(move_state.move())
	attack_state.attack()
	character_texture.animate(move_state.velocity)
	
	
func change_action_state(type: String, action_state: bool) -> void:
	on_action = action_state
	current_action = type
	sleep(action_state)
	
	
func sleep(sleep_state: bool) -> void:
	set_physics_process(not sleep_state)
