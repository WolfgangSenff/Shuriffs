extends Area2D

# The order here matters; these must come before texture and shape, as the setters use them
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
onready var arrow_line = $Node/Line2D
var is_selected = false setget set_is_selected
var should_draw_arrow = false

export (Texture) onready var texture setget set_texture
export (Shape2D) onready var shape setget set_shape
export (bool) onready var rotate_collision_shape
export (Vector2) var reflection_direction

func _ready():
    if rotate_collision_shape and collision_shape:
        collision_shape.rotation_degrees = 125
    material = material.duplicate(true)
    arrow_line.clear_points()
    set_arrow()
    
func set_texture(value):
    if !sprite:
        yield(self, "ready")
        
    if value:
        texture = value
        sprite.texture = texture
        set_arrow()
    
func set_shape(value):
    if !collision_shape:
        yield(self, "ready")
        
    if value:
        shape = value
        collision_shape.shape = shape

func set_arrow():
    arrow_line.clear_points()
    if sprite and sprite.texture:
        var arrow_begin = global_position #+ (sprite.texture.get_size() / 2.0)
        var arrow_end = arrow_begin + (reflection_direction.normalized() * 100)
        var arrow_end_random = Vector2(rand_range(-5, 5), rand_range(-5, 5))
        arrow_line.add_point(arrow_begin)
        arrow_line.add_point(arrow_end + arrow_end_random)

func set_is_selected(value):
    is_selected = value
    if sprite:
        if is_selected:
            material.set("shader_param/width", 1)
            draw_arrow()
        else:
            material.set("shader_param/width", 0)
            clear_arrow()
            
        set_arrow()
    

func _on_Reflectable_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        self.is_selected = !is_selected

func draw_arrow():
    arrow_line.visible = true

func clear_arrow():
    arrow_line.visible = false
    

