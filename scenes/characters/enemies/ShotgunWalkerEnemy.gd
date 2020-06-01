extends KinematicBody2D

# start with random position and rotation
# walk forward until RayCast hits
# turn randomly about and walk that direction
# if finds character, stay on target until leaves vision
# move toward character slower, rotating toward as walking

export (float) var NormalSpeed
export (float) var FollowingSpeed

onready var raycast := $RayCast2D
onready var shoot_timer = $Timer
onready var shotgun = $Sprite/ShotgunScene

var target = null
var current_direction = Vector2.RIGHT
var HP = 10

func _physics_process(delta: float) -> void:
    if target:
        follow_target()
        shoot()
    else:
        walk_forward()
        
func walk_forward():
    if raycast.is_colliding():
        current_direction = current_direction.bounce(raycast.get_collision_normal()).rotated(deg2rad(rand_range(-15, 15))).normalized()
        var raycast_length = raycast.cast_to.length()
        raycast.cast_to = current_direction * raycast_length
        rotation = current_direction.angle()
        
    move_and_slide(NormalSpeed * current_direction)
    
func follow_target():
    look_at(target.global_position)
    move_and_slide(FollowingSpeed * Vector2.RIGHT.rotated(rotation).normalized())
    
func shoot():
    if shoot_timer.is_stopped():
        shoot_timer.start()
        shotgun.fire()
        yield(get_tree().create_timer(0.3), "timeout")
        shotgun.fire()

func _on_VisionArea_body_entered(body: Node) -> void:
    target = body

func _on_VisionArea_body_exited(body: Node) -> void:
    target = null
