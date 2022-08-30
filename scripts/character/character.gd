extends KinematicBody2D
class_name Character

onready var kill_tween: Tween = get_node("KillTween")

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")

onready var character_texture: Sprite = get_node("Texture")

onready var states: Node = get_node("States")
onready var move_state: Node = states.get_node("Move")
onready var attack_state: Node = states.get_node("Attack")

var on_action: bool = false
var on_knockback: bool = false

var current_action: String = ""

func _ready() -> void:
	animation_tree.active = true
	
	
func _physics_process(_delta: float) -> void:
	move()
	attack_state.attack()
	character_texture.animate(move_state.velocity)
	
	
func move() -> void:
	if not on_knockback:
		move_state.velocity = move_and_slide(move_state.move())
		
	if on_knockback:
		move_state.velocity = move_and_slide(move_state.knockback())
		
		
func change_action_state(type: String, action_state: bool) -> void:
	if type == "hit" and not action_state:
		on_knockback = action_state
		on_action = action_state
		return
		
	on_action = action_state
	
	if type == "hit" and action_state:
		on_knockback = action_state
		return
		
	current_action = type
	sleep(action_state)
	
	
func sleep(sleep_state: bool) -> void:
	if current_action == "":
		animation_state.travel("idle")
		
	set_physics_process(not sleep_state)
	
	
func kill() -> void:
	sleep(true)
	animation_tree.active = false
	character_texture.texture_material.set_shader_param("on_kill", true)
	
	var _dissolve: bool = kill_tween.interpolate_property(
		character_texture.texture_material,
		"shader_param/progress",
		0.0,
		1.0,
		0.2
	)
	
	var _start: bool = kill_tween.start()
