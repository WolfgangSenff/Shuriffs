extends Node

func instance_on_main(scene, pos, rot):
    var inst = scene.instance()
    get_tree().current_scene.add_child(inst)
    inst.position = pos
    inst.rotation = rot        
    return inst
