extends Area2D

export (bool) var IsFurniture

func _on_Absorbable_area_entered(area: Area2D) -> void:
    area.queue_free()
