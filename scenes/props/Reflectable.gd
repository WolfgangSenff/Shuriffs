extends Area2D

# The order here matters; these must come before texture and shape, as the setters use them
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

export (Texture) onready var texture setget set_texture
export (Shape2D) onready var shape setget set_shape
export (bool) onready var rotate_collision_shape
export (bool) var IsFurniture = false

func _ready():
    if rotate_collision_shape and collision_shape:
        collision_shape.rotation_degrees = 125
    
func set_texture(value):
    if !sprite:
        yield(self, "ready")
        
    if value:
        texture = value
        sprite.texture = texture
    
func set_shape(value):
    if !collision_shape:
        yield(self, "ready")
        
    if value:
        shape = value
        collision_shape.shape = shape

func _on_Reflectable_area_entered(area: Area2D) -> void:
    var bounced = area.global_position - self.global_position
    area.rotation = bounced.angle()
