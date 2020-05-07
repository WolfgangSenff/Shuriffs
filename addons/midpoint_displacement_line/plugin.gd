tool
extends EditorPlugin

func _enter_tree() -> void:
    add_custom_type("MidpointDisplacementLine", "Line2D", preload("res://addons/midpoint_displacement_line/MidpointDisplacementLine.gd"), preload("res://addons/midpoint_displacement_line/icon.png"))

func _exit_tree() -> void:
    remove_custom_type("MidpointDisplacementLine")
