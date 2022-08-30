extends Area2D
class_name Interactable

export(Vector2) var house_travel_position

func on_body_entered(body) -> void:
	if body is Character:
		interact(body)
		
		
func interact(body: Character) -> void:
	get_tree().call_group("transition", "make_transition", body, house_travel_position)
