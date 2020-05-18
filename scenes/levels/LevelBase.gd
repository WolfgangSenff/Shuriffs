extends Node2D

onready var ground_astar = $YSort/Ground

func _ready() -> void:
    randomize()
    var astar_affectors = get_tree().get_nodes_in_group("AffectsAStarMap")
    for affector in astar_affectors:
        ground_astar.disable_astar_point(affector.global_position)
        
    
