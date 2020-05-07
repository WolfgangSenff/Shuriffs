extends Sprite

var selected = false setget set_selected
onready var anim_player = $AnimationPlayer

func set_selected(value : bool) -> void:
    if !get_tree():
        return
        
    selected = value
    if selected:
        anim_player.play("Select")
    else:
        anim_player.play_backwards("Select")

func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.pressed:
            self.selected = !selected
