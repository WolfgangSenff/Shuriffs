extends Node2D

export (String) onready var IntroAnimation
export (float) onready var IntroTimeout = 2.0

onready var anim_player = $AnimationPlayer

func _ready():
    randomize()
    yield(get_tree().create_timer(IntroTimeout), "timeout")
    anim_player.play(IntroAnimation)
