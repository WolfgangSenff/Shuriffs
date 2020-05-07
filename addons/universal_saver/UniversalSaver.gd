extends Node

signal saved_values_loaded

# Array of strings defining what groups should be
# saved; a node should have the group tag if it needs 
# to be saved
const save_groups = ["Settings"]

const file_path = "user://save_game.save"

# Add to these if you have to! Or remove from - either way,
# these represent the different types to pull off of any object
# to save them.
var types_to_save = [TYPE_BASIS, TYPE_BOOL, TYPE_COLOR, TYPE_INT,
TYPE_TRANSFORM, TYPE_TRANSFORM2D, TYPE_REAL, TYPE_STRING, 
TYPE_VECTOR2, TYPE_VECTOR3]

func save_to(obj : Object, dictionary : Dictionary) -> void:
    for prop in obj.get_property_list():
        if types_to_save.has(prop.type):
            var property_name = prop.name
            if property_name == "volume_db":
                pass
            var saved_value = obj.get(property_name)
            dictionary[property_name] = saved_value
    
func load_from(obj : Object, dictionary : Dictionary) -> void:
    # Do not have to check the types to save, because only
    # those types which are able to be saved were
    for prop in dictionary.keys():
        if prop == "volume_db":
            pass
        var value = dictionary[prop]
        obj.set(prop, value)
            
            
func save_all() -> void:
    var save_dictionary = {}
    for group in save_groups:
        var group_objects = get_tree().get_nodes_in_group(group)
        for obj in group_objects:
            var obj_name = obj.name
            var obj_save_dictionary = {}
            save_to(obj, obj_save_dictionary)
            save_dictionary[obj_name] = obj_save_dictionary
            
    var saved_game = File.new()
    saved_game.open(file_path, File.WRITE)
    saved_game.store_var(save_dictionary)
    
    saved_game.close()
    
func load_all() -> void:
    var saved_game = File.new()
    if not saved_game.file_exists(file_path):
        return # No game was ever saved yet
    
    saved_game.open(file_path, File.READ)
    var dictionary = saved_game.get_var()
    
    for group in save_groups:
        var group_objects = get_tree().get_nodes_in_group(group)
        for obj in group_objects:
            if dictionary.has(obj.name):
                var obj_dictionary = dictionary[obj.name]
                load_from(obj, obj_dictionary)
            
    saved_game.close()
    emit_signal("saved_values_loaded")
