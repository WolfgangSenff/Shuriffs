extends Area2D

export (float) var Speed

func _ready():
    set_physics_process(false)

func fire():
    $AnimationPlayer.play("Fire")
    
func _physics_process(delta: float) -> void:
    position += Vector2.RIGHT.rotated(rotation) * Speed * delta
