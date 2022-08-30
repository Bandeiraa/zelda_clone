extends Node
class_name MoveState

var velocity: Vector2
var parent: Node = null

export(int) var move_speed

func move() -> Vector2:
	var direction: Vector2 = get_direction()
	if direction != Vector2.ZERO:
		parent.animation_tree.set("parameters/idle/blend_position", direction)
		parent.animation_tree.set("parameters/walk/blend_position", direction)
		parent.animation_tree.set("parameters/attack/blend_position", direction)
		
	velocity = direction * move_speed
	return velocity
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
