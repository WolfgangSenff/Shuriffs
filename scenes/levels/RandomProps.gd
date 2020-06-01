extends YSort

export (Array, PackedScene) var PropScenes

export (int) var TotalProps
export (NodePath) onready var GeneratorPath
onready var generator = get_node(GeneratorPath)

func generate_props():
    for prop in TotalProps:
        var random_prop = PropScenes[randi() % PropScenes.size()]
        var prop_inst = random_prop.instance()
        add_child(prop_inst)
        #yield(get_tree(), "idle_frame")
        var random_tile = generator.get_random_habitable_tile()
#        else:
#            random_tile = generator.get_random_unhabitable_tile()
        
        prop_inst.global_position = generator.map_to_world(random_tile)
        prop_inst.rotation_degrees = rand_range(-10, 10)
