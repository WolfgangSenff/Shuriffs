extends HBoxContainer

var speech setget set_speech
onready var label = $CenterContainer/RichTextLabel
onready var anim_player = $AnimationPlayer
onready var portrait = $TextureCenter/TextureRect

func set_speech(value):
    speech = value
    label.bbcode_enabled = true
    label.percent_visible = 0

func begin_saying(key):
    portrait.texture = speech.CharacterPortrait
    label.bbcode_text = speech.get_line(key)
    anim_player.play("Talk")
    yield(anim_player, "animation_finished")
    yield(get_tree().create_timer(1.0), "timeout")
