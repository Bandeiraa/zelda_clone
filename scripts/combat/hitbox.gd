extends Area2D
class_name Hitbox

var health: int
var max_health: int

export(NodePath) onready var knockback_receiver = get_node(knockback_receiver)

func _ready() -> void:
	max_health = health
	
	
func update_health(value: int, type: String, target_position: Vector2) -> void:
	match type:
		"increase":
			health = int(clamp(health + value, 0, max_health))
			
		"decrease":
			health = int(clamp(health - value, 0, max_health))
			knockback_receiver.apply_knockback(target_position)
