extends KinematicBody2D
class_name Character

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var state = animation_tree.get("parameters/playback")

var velocity: Vector2

export(int) var move_speed

func _physics_process(_delta: float) -> void:
	move()
	animate()
	
	
func move() -> void:
	var direction: Vector2 = get_direction()
	if direction != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", direction)
		animation_tree.set("parameters/walk/blend_position", direction)
		
		
	velocity = direction * move_speed
	velocity = move_and_slide(velocity)
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	
	
func animate() -> void:
	move_behavior()
	
	
func move_behavior() -> void:
	if velocity != Vector2.ZERO:
		state.travel("walk")
		return
		
	state.travel("idle")
