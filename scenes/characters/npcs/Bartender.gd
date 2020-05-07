extends Sprite

onready var anim_tree = $AnimationTree
onready var state_machine = anim_tree.get("parameters/playback")
onready var movement_timer = $Timer

var bartender_state = 1

func take_cover():
    state_machine.travel("Cover")

func move_up():
    state_machine.travel("MoveUp")
    bartender_state = -1
    
func move_down():
    state_machine.travel("MoveDown")
    bartender_state = 1

func _on_Timer_timeout() -> void:
    var random_next = pow(-1, randi() % 2)
    if random_next != bartender_state:
        bartender_state = random_next
        if random_next == 1:
            state_machine.travel("MoveDown")
        else:
            state_machine.travel("MoveUp")
