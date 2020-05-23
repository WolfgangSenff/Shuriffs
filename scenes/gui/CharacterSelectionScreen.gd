extends Control

onready var current_sheriff_selection = preload("res://assets/resources/sheriffs/Chip.tres") setget set_current_sheriff_selection
onready var current_sheriff_index = 0 setget set_current_sheriff_index

onready var portrait_rect = $HSplitContainer/MarginContainer/VSplitContainer/VSplitContainer/PortraitRect
onready var name_label = $HSplitContainer/MarginContainer/VSplitContainer/VSplitContainer/NameLabel
onready var stats_container = $HSplitContainer/VSplitContainer/ScrollContainer/StatsContainer

const StatScene = preload("res://scenes/gui/SheriffStatView.tscn")

func _ready() -> void:
    self.current_sheriff_index = Context.AllSheriffsListResource.find_index_of(current_sheriff_selection)

func set_current_sheriff_selection(value) -> void:
    current_sheriff_selection = value
    Context.current_sheriff_resource = current_sheriff_selection
    reload_current_ui()

func set_current_sheriff_index(value) -> void:
    current_sheriff_index = value
    current_sheriff_index = clamp(current_sheriff_index, 0, Context.AllSheriffsListResource.all_resources.size() - 1)
    self.current_sheriff_selection = Context.AllSheriffsListResource.all_resources[current_sheriff_index]

func _on_ScrollLeftButton_pressed() -> void:
    self.current_sheriff_index -= 1
    
func _on_ScrollRightButton_pressed() -> void:
    self.current_sheriff_index += 1

func reload_current_ui() -> void:
    if !portrait_rect:
        return
        
    for child in stats_container.get_children():
        child.queue_free()
        
    yield(get_tree(), "idle_frame")
    
    portrait_rect.texture = current_sheriff_selection.Portrait
    name_label.text = current_sheriff_selection.FullName
    var stat_view = StatScene.instance()
    
