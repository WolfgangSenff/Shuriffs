extends "res://scenes/weapons/Muzzle.gd"

export (int) var MinShots = 2
export (int) var MaxShots = 5

func fire():
    if BulletScene:
        for bullet in int(rand_range(MinShots, MaxShots)):
            var result = Spawn.instance_on_main(BulletScene, global_position + Vector2(rand_range(-5, 5), rand_range(-5, 5)), global_rotation + deg2rad(rand_range(-15, 15)))
            result.fire()
            
