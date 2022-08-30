extends KinematicBody2D
class_name Character

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var animation_state = animation_tree.get("parameters/playback")

onready var attack_timer: Timer = get_node("AttackTimer")

var on_action: bool = false

var velocity: Vector2
var current_action: String = ""

export(int) var move_speed
export(float) var attack_cooldown

func _physics_process(_delta: float) -> void:
	move()
	attack()
	animate()
	
	
func move() -> void:
	var direction: Vector2 = get_direction()
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", direction)
		animation_tree.set("parameters/walk/blend_position", direction)
		animation_tree.set("parameters/attack/blend_position", direction)
		
		
	velocity = direction * move_speed
	velocity = move_and_slide(velocity)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	
func attack() -> void:
	if Input.is_action_just_pressed("ui_left_click") and not on_action:
		attack_timer.start(attack_cooldown)
		current_action = "attack"
		on_action = true
		sleep(true)
		
		
func animate() -> void:
	if on_action:
		action_behavior()
		return
		
	move_behavior()
	
	
func action_behavior() -> void:
	animation_state.travel(current_action)
	
	
func move_behavior() -> void:
	if velocity != Vector2.ZERO:
		animation_state.travel("walk")
		return
		
	animation_state.travel("idle")
	
	
func on_attack_timer_timeout() -> void:
	sleep(false)
	on_action = false
	current_action = ""
	
	
func sleep(state: bool) -> void:
	set_physics_process(not state)
