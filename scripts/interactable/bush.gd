extends Area2D
class_name Bush

const EFFECT: PackedScene = preload("res://scenes/effect/bush_effect.tscn")

func update_health(_damage: int, _type: String, _knockback_position: Vector2) -> void:
	spawn_effect()
	queue_free()
	
	
func spawn_effect() -> void:
	var effect = EFFECT.instance()
	effect.global_position = global_position
	get_tree().root.call_deferred("add_child", effect)
