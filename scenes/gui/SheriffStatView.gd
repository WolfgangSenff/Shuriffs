extends Control

onready var label setget set_label
onready var value setget set_value

func set_label(value) -> void:
    label = value
    $HSplitContainer/StatLabel.text = label
    
func set_value(_value) -> void:
    value = _value
    $HSplitContainer/StatValue.text = value
