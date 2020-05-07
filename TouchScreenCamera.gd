extends Camera2D

export (NodePath) var target

var target_return_enabled = true
var target_return_rate = 0.02
var min_zoom = 0.5
var max_zoom = 2
var zoom_sensitivity = 10
var zoom_speed = 0.05

var events = {}
var last_drag_distance = 0

func _process(delta):
    if target and target_return_enabled and events.size() == 0:
        position = lerp(position, get_node(target).position, target_return_rate)

func _unhandled_input(event):
    if event is InputEventScreenTouch:
        if event.pressed:
            events[event.index] = event
        else:
            events.erase(event.index)

    if event is InputEventScreenDrag:
        events[event.index] = event
        if events.size() == 1:
            var relative_event_pos = -event.relative.rotated(rotation) * zoom.x
            #if position.x + relative_event_pos.x < limit_right or -relative_event_pos.x + position.x > limit_left:
            position += relative_event_pos
            #position += relative_event_pos
            # Not sure why the following doesn't prevent you from "moving" the camera outside the limits
            #position = Vector2(clamp(position.x, limit_left, limit_right), clamp(position.y, limit_top, limit_bottom))
        elif events.size() == 2:
            var drag_distance = events[0].position.distance_to(events[1].position)
            if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
                var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
                new_zoom = clamp(zoom.x * new_zoom, min_zoom, max_zoom)
                zoom = Vector2.ONE * new_zoom
                last_drag_distance = drag_distance
