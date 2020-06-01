extends TileMap

const Directions = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]

func generate_barriers(around_tilemap : TileMap) -> void:
    var used_tiles = around_tilemap.get_used_cells()
    for tile in used_tiles:
        for direction in Directions:
            var tile_in_direction = tile - direction
            var in_map_tile = around_tilemap.get_cellv(tile_in_direction)
            if in_map_tile == -1: # Let it overwrite them all, doesn't matter
                set_cellv(tile_in_direction, 0)
