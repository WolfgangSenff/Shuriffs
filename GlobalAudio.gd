extends Node

onready var main_theme_player = $MainThemePlayer

func set_music_volume(volume) -> void:
    main_theme_player.volume_db = volume

func get_music_volume() -> float:
    return main_theme_player.volume_db
    
func turn_off_music() -> void:
    main_theme_player.playing = false
    
func turn_on_music_if_required() -> void:
    # Without this, it will restart the music each time
    if !main_theme_player.playing:
        main_theme_player.playing = true
