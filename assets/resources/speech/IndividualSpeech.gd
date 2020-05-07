extends Resource
class_name Speech

export (Texture) var CharacterPortrait
export (Dictionary) var CharacterLines

func get_line(key : String) -> String:
    if CharacterLines.has(key):
        return CharacterLines[key]
    
    return ""
