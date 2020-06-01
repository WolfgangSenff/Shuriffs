extends Node

onready var current_sheriff_resource = preload("res://assets/resources/sheriffs/Dan.tres")
var current_enemy_resource
var current_difficulty_resource
var current_levels_list_resource

export (Resource) onready var AllLevelsListResource
export (Resource) onready var AllSheriffsListResource
