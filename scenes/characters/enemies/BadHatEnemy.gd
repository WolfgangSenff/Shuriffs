extends Node2D

onready var anim_player := $AnimationPlayer
onready var muzzle_position = $YSort/EnemyArea/Pivot/GunSprite/MuzzlePosition
onready var pivot = $YSort/EnemyArea/Pivot
onready var popout_timer = $PopoutTimer
export (int) var WaitTimeBetweenShots
export (float) var RotationSpeed = 200

const RotationEpsilon = .05
var is_dead = false
var current_rotation_target = 0

func _ready():
    yield(get_tree().create_timer(randi() % 5), "timeout")
    popout_timer.wait_time = (randi() % WaitTimeBetweenShots) + 1
    popout_timer.start()

func _on_PopoutTimer_timeout() -> void:
    if not is_dead:
        anim_player.play("Popout")
        yield(anim_player, "animation_finished")
        shoot()
        anim_player.play_backwards("Popout")
        yield(anim_player, "animation_finished")
        popout_timer.start()

func die():
    is_dead = true
    popout_timer.stop()
    anim_player.stop()
    set_physics_process(false)

func shoot():
    if not is_dead:
        muzzle_position.fire()
    
func _physics_process(delta: float) -> void:
    if not is_dead:
        var current_rotation_difference = pivot.rotation_degrees - current_rotation_target
        if abs(current_rotation_difference) > RotationEpsilon:
            if sign(current_rotation_difference) > 0:
                pivot.rotation_degrees -= deg2rad(delta * RotationSpeed)
            elif sign(current_rotation_difference) < 0:
                pivot.rotation_degrees += deg2rad(delta * RotationSpeed)
        else:
            current_rotation_target = pivot.rotation_degrees + randi() % 15
        
    
