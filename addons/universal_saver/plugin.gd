tool
extends EditorPlugin


func _enter_tree() -> void:
    add_autoload_singleton("UniversalSaver", "res://addons/universal_saver/UniversalSaver.gd")


func _exit_tree() -> void:
    pass
