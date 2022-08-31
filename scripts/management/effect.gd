extends AnimatedSprite
class_name Effect

func _ready() -> void:
	playing = true
	var _kill: bool = connect("animation_finished", self, "queue_free")
