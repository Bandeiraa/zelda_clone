extends Node2D
class_name GameLevel

func _ready() -> void:
	connect_signals()
	
	
func connect_signals() -> void:
	for notifier in get_tree().get_nodes_in_group("chunk_notifier"):
		notifier.connect("screen_entered", notifier.get_parent(), "show")
		notifier.connect("screen_exited", notifier.get_parent(), "hide")
