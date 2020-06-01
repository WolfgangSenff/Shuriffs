extends Area2D

export (int) var HP

func _on_EnemyArea_area_entered(area: Area2D) -> void:
    HP -= area.Damage
    area.handle_hit(self)
    area.queue_free()
    if HP <= 0:
        owner.die()
        queue_free()
