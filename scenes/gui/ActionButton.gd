extends TextureButton

export (int) var MaxPointsInTail

onready var tail = $Node/Tail
var prev_position

func _ready() -> void:
    prev_position = rect_global_position

func _process(delta: float) -> void:
    if tail.points.size() > MaxPointsInTail:
        tail.remove_point(0)
        
    if prev_position > rect_global_position:
        tail.add_point(rect_global_position + Vector2(rect_min_size.x, rect_min_size.y / 2.0))
    else:
        tail.add_point(rect_global_position + Vector2(0, rect_min_size.y / 2.0))
        
    prev_position = rect_global_position
