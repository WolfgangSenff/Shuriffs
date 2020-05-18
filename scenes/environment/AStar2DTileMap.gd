extends TileMap

onready var astar_map = AStar2D.new()

const North = Vector2.UP
const East = Vector2.RIGHT
const South = Vector2.DOWN
const West = Vector2.LEFT

const tile_astar_id_map = {
    
   }

func _ready() -> void:
    var used_cells = get_used_cells()
    for tile in used_cells:
        var id = astar_map.get_available_point_id()
        astar_map.add_point(id, tile)
        tile_astar_id_map[tile] = id
        
    for tile in used_cells:
        add_connection_if(tile, North)
        add_connection_if(tile, East)
        add_connection_if(tile, South)
        add_connection_if(tile, West)
        
func add_connection_if(tile : Vector2, direction : Vector2):
    if get_cellv(tile + direction) != -1:
        var tile_id = tile_astar_id_map[tile]
        var neighbor_id = tile_astar_id_map[tile + direction]
        astar_map.connect_points(tile_id, neighbor_id, false) # False because we're looping over every tile anyway, which will inherently make them bidirectional

func disable_astar_point(pos : Vector2):
    var map_tile = world_to_map(pos)
    if tile_astar_id_map.has(map_tile):
        var astar_id = tile_astar_id_map[map_tile]
        astar_map.set_point_disabled(astar_id)
    
func enable_astar_point(pos : Vector2):
    var map_tile = world_to_map(pos)
    if tile_astar_id_map.has(map_tile):
        var astar_id = tile_astar_id_map[map_tile]
        astar_map.set_point_disabled(astar_id, false)
