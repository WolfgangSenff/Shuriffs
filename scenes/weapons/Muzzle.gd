extends Position2D

export (PackedScene) var BulletScene
    
func fire():
    if BulletScene:
        var result = Spawn.instance_on_main(BulletScene, global_position, global_rotation)
        result.fire()
