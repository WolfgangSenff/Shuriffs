extends Node2D

onready var bartender = $Sprite
onready var movement_timer = $Sprite/Timer

func stop_moving():
    movement_timer.stop()
    
func start_moving():
    movement_timer.start()
    
func move_up():
    bartender.move_up()
    
func move_down():
    bartender.move_down()
    
func take_cover():
    bartender.take_cover()
