extends Line2D

export (int) var Displacement = 100
export (int) var Iterations = 10
export (int) var Height = 250
export (float) var Smoothing = 1.1

export (Vector2) onready var LineStart
export (Vector2) onready var LineEnd

export (bool) onready var AddPolygonShape = true

var current_displacement
var polygon : Polygon2D

func _ready() -> void:
    randomize()
    if AddPolygonShape:
        polygon = Polygon2D.new()
        add_child(polygon)
    polygon.color = default_color
    init_line()
    
func init_line() -> void:
    current_displacement = Displacement
    clear_points()
    var start = LineStart
    var end = LineEnd
    
    var screen_size = get_viewport().get_visible_rect().size
    
    if LineStart == Vector2.ZERO:
        start = Vector2(0, rand_range(Height - Displacement, Height + Displacement))
    if LineEnd == Vector2.ZERO:
        end = Vector2(screen_size.x, rand_range(Height - Displacement, Height + Displacement))
        
    add_point(start)
    add_point(end)
    
    for iter in Iterations:
        add_points()
    var p = points
    p.append(Vector2(end.x, screen_size.y * 1.5))
    p.append(Vector2(start.x, screen_size.y * 1.5))
    polygon.polygon = p
    
func add_points():
    var old_points = points
    clear_points()
    
    for i in old_points.size() - 1:
        var midpoint = (old_points[i] + old_points[i + 1]) / 2
        midpoint.y += current_displacement * pow(-1, randi() % 2)
        add_point(old_points[i])
        add_point(midpoint)
    
    var oldest_point = old_points[-1]
    add_point(oldest_point)
    current_displacement *= pow(2.0, -Smoothing)
