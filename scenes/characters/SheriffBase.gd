extends KinematicBody2D

signal character_selected(character)

onready var sprite = $YSort/CharacterSprite
onready var nickname = $NicknameLabel
onready var gun_holder = $YSort/GunHolder
var gun_scene

export (Resource) onready var CharacterResource setget set_sheriff_resource

export (float) var MaxSpeed
export (float) var Acceleration
export (float) var Friction

var motion := Vector2()
        
func set_sheriff_resource(value):
    CharacterResource = value
    sprite.texture = CharacterResource.FullBody
    nickname.text = CharacterResource.NickName
    gun_scene = CharacterResource.GunScene.instance()
    $YSort/GunHolder.add_child(gun_scene)
    MaxSpeed = CharacterResource.MaxSpeed
    Acceleration = CharacterResource.Acceleration
    Friction = CharacterResource.Friction

func _physics_process(delta: float) -> void:
    var mouse_pos = get_local_mouse_position()
    gun_holder.rotation = mouse_pos.angle()
    
    var direction = get_input_direction()
    var normalized_direction = direction.normalized()
    
    if direction == Vector2.ZERO:
        motion = motion.move_toward(Vector2.ZERO, Acceleration * delta)
    else:
        motion += direction * Acceleration * delta

    motion = motion.clamped(MaxSpeed)
    move_and_slide(motion)
    
    if Input.is_action_just_pressed("ui_mouse_left"):
        gun_scene.fire()
    
func get_input_direction() -> Vector2:
    return Vector2(
        Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
        Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
       )
