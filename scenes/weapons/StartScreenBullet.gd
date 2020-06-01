extends Area2D

export (float) var Speed
export (int) var Damage

func _ready():
    set_physics_process(false)

func fire():
    $AnimationPlayer.play("Fire")
    
func _physics_process(delta: float) -> void:
    position += Vector2.RIGHT.rotated(rotation) * Speed * delta

func _on_VisibilityNotifier2D_screen_exited() -> void:
    queue_free()
    
func handle_hit(area):
    pass
