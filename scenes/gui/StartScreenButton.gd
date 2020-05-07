extends TextureButton

onready var tail = $Tail
onready var anim_player = $AnimationPlayer

export (int) onready var ToIndex

func BeginAnimation() -> void:
    anim_player.play("Default")
    
func StopAnimation() -> void:
    anim_player.play("Start")
