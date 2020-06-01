extends Area2D

onready var invin_timer = $InvincibilityTimer
onready var sprite = $Sprite
onready var particles = $CPUParticles2D
export (bool) var IsFurniture = false

const max_sprite_frames = 3

func _on_ExplodingRock1_area_entered(area: Area2D) -> void:
    var bounced = area.global_position - self.global_position
    area.rotation = bounced.angle()
    if not invin_timer.is_stopped():
        return
    invin_timer.start()
    sprite.frame += 1
    if not particles.emitting:
        particles.emitting = true
    
    if sprite.frame >= max_sprite_frames:
        sprite.frame = 5
        disconnect("area_entered", self, "_on_ExplodingRock1_area_entered")
    
