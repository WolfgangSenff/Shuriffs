extends Node2D

onready var player_holder = $YSort/PlayerHolder
onready var generator = $Generator
onready var props = $YSort/Props
onready var barriers = $Barriers
var sheriff = null

func _ready() -> void:
    randomize()
    
    var selected_sheriff = Context.current_sheriff_resource
    var sheriff_scene = selected_sheriff.SheriffScene
    sheriff = sheriff_scene.instance()
    player_holder.add_child(sheriff)
    sheriff.CharacterResource = selected_sheriff
    sheriff.hide()
    yield(generator.generate_dungeon(), "completed")
    barriers.generate_barriers(generator)
    props.generate_props()
    var start_tile = generator.get_random_habitable_tile()
    sheriff.global_position = generator.map_to_world(start_tile)
    sheriff.show()
    sheriff.connect("dead", self, "on_sheriff_died")

func on_sheriff_died():
    sheriff.queue_free()

func _on_Button_pressed() -> void:
    get_tree().change_scene("res://experiments/Control.tscn")
