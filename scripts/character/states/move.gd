extends Node
class_name MoveState

onready var knockback_timer: Timer = get_node("KnockbackTimer")

var velocity: Vector2
var knockback_velocity: Vector2

var parent: Node = null

var move_speed: int
var knockback_lifetime: float

export(NodePath) onready var character_texture = get_node(character_texture) as Sprite

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
	
	
func apply_knockback(target_position: Vector2) -> void:
	var direction: Vector2 = target_position.direction_to(parent.character.global_position).normalized()
	parent.character.change_action_state("hit", true)
	knockback_velocity = direction * (move_speed * 4)
	knockback_timer.start(knockback_lifetime)
	
	character_texture.texture_material.set_shader_param("on_hit", true)
	
	
func knockback() -> Vector2:
	return knockback_velocity
	
	
func on_knockback_timer_timeout() -> void:
	knockback_velocity = Vector2.ZERO
	parent.character.change_action_state("hit", false)
	character_texture.texture_material.set_shader_param("on_hit", false)
