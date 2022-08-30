extends CanvasLayer
class_name TransitionScreen

onready var animation: AnimationPlayer = get_node("Animation")

var body = null
var teleport_position: Vector2

func make_transition(_body: Character, _teleport_position: Vector2) -> void:
	body = _body
	teleport_position = _teleport_position
	
	body.sleep(true)
	animation.play("fade_in")
	
	
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		body.global_position = teleport_position
		animation.play("fade_out")
		
	if anim_name == "fade_out":
		body.sleep(false)
