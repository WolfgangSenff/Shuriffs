extends Node2D

onready var player_holder = $YSort/PlayerHolder

func _ready() -> void:
    randomize()
    
    var selected_sheriff = Context.current_sheriff_resource
    var sheriff_scene = selected_sheriff.SheriffScene
    var sheriff = sheriff_scene.instance()
    player_holder.add_child(sheriff)
    sheriff.CharacterResource = selected_sheriff
