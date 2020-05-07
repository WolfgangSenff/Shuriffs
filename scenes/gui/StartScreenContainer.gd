extends Control

onready var anim_player = $AnimationPlayer

func _ready() -> void:
    UniversalSaver.load_all()
    get_tree().call_group("StartScreenButton", "connect", "pressed", self, "_on_Button_pressed")

func _on_Button_pressed() -> void:
    get_tree().call_group("StartScreenButton", "BeginAnimation")
    
func _on_OptionsButton_pressed() -> void:
    show_screen("ShowGameOptions")

func _on_ExitButton_pressed() -> void:
    get_tree().quit()

func _on_BackButton_pressed() -> void:
    show_screen("ShowMainOptions")

func _on_CreditsButton_pressed() -> void:
    show_screen("ShowCredits")
    
func show_screen(screen_animation : String) -> void:
    anim_player.play(screen_animation)
    yield(anim_player, "animation_finished")    
    get_tree().call_group("StartScreenButton", "StopAnimation")
