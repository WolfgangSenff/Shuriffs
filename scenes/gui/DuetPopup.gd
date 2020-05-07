extends PopupPanel

export (Resource) onready var DuetSpeech setget set_duet

onready var top_speech = $VSplitContainer/TopSpeech
onready var bottom_speech = $VSplitContainer/BottomSpeech

var current_speech_position = 0

onready var speech_containers = [top_speech, bottom_speech]

func set_duet(value):
    DuetSpeech = value
    top_speech.speech = DuetSpeech.FirstSpeaker
    bottom_speech.speech = DuetSpeech.SecondSpeaker
    

func play():
    popup_centered_minsize(Vector2(600, 300))
    for key in DuetSpeech.SpeechKeys:
        var value = DuetSpeech.SpeechKeys[key]
        yield(speech_containers[current_speech_position].begin_saying(value), "completed")
        current_speech_position += 1
        current_speech_position %= 2
