extends "res://scenes/gui/StartScreenBase.gd"

onready var music_slider = $NinePatchRect/CenterContainer/VBoxContainer/HBoxContainer/MusicContainer/MusicSlider

var is_loading = false

func _ready() -> void:
    UniversalSaver.connect("saved_values_loaded", self, "on_SavedValues_loaded")
    
func on_SavedValues_loaded() -> void:
    is_loading = true
    music_slider.value = GlobalAudio.get_music_volume()
    is_loading = false

func _on_MusicSlider_value_changed(value: float) -> void:
    if !is_loading:
        if music_slider.value == music_slider.min_value:
            GlobalAudio.turn_off_music()
        else:
            GlobalAudio.turn_on_music_if_required()
            
        GlobalAudio.set_music_volume(value)
        UniversalSaver.save_all()


func _on_BackButton_pressed() -> void:
    pass # Replace with function body.
