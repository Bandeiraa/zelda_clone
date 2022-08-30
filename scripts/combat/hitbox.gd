extends Area2D
class_name Hitbox

onready var parent = get_parent()

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
			decrease_health(value, target_position)
			
			
func decrease_health(value: int, target_position: Vector2) -> void:
	health = int(clamp(health - value, 0, max_health))
	if health == 0:
		parent.kill()
		return
		
	knockback_receiver.apply_knockback(target_position)
