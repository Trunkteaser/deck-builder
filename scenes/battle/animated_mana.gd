extends AnimatedSprite2D

@onready var animated_mana: AnimatedSprite2D = $"."

func _ready():
	animated_mana.play("idle")
