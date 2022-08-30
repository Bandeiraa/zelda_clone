extends Sprite
class_name CharacterTexture

onready var parent: KinematicBody2D = get_parent()

func animate(velocity: Vector2) -> void:
	if parent.on_action:
		action_behavior()
		return
		
	move_behavior(velocity)
	
	
func action_behavior() -> void:
	parent.animation_state.travel(parent.current_action)
	
	
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		parent.animation_state.travel("walk")
		return
		
	parent.animation_state.travel("idle")
