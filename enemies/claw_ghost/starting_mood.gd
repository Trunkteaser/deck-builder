extends Node

@onready var enemy: Enemy = $".."


const ANGER = preload("uid://bl7yry7rm0qru")

func _ready() -> void:
	await enemy.ready
	Apply.mood([enemy], ANGER, 2)
