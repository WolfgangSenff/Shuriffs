extends TextureButton

onready var tail = $Tail
onready var anim_player = $AnimationPlayer

export (int) onready var ToIndex
export (String) onready var ToScreenPath

func BeginAnimation() -> void:
    anim_player.play("Default")
    
func StopAnimation() -> void:
    anim_player.play("Start")


func _on_StartScreenButton_pressed() -> void:
    if ToScreenPath:
        get_tree().change_scene("res://scenes/" + ToScreenPath + ".tscn")
