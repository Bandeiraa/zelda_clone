extends Area2D
class_name Hurtbox

onready var parent = get_parent()

var damage: int

func on_hurtbox_area_entered(area) -> void:
	area.update_health(damage, "decrease", parent.global_position)
