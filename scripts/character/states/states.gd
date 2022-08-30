extends Node
class_name States

export(NodePath) onready var character = get_node(character) as KinematicBody2D
export(NodePath) onready var animation_tree = get_node(animation_tree) as AnimationTree

func _ready() -> void:
	for children in get_children():
		children.parent = self
