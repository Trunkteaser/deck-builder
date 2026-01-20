extends CanvasLayer
class_name BattleUI

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var hand: Hand = %Hand
@onready var mana_ui: ManaUI = $ManaUI
@onready var end_turn_button: Button = %EndTurnButton
@onready var draw_pile_button: CardPileOpener = %DrawPileButton
@onready var discard_pile_button: CardPileOpener = %DiscardPileButton
@onready var draw_pile_view: CardPileView = %DrawPileView
@onready var discard_pile_view: CardPileView = %DiscardPileView

func _ready() -> void:
	Events.player_hand_drawn.connect(_on_player_hand_drawn)
	Events.damage_taken.connect(_damage_popup)
	draw_pile_button.pressed.connect(draw_pile_view.show_current_view.bind("Draw Pile", true))
	discard_pile_button.pressed.connect(discard_pile_view.show_current_view.bind("Discard Pile"))

func initialize_card_pile_ui() -> void: # Called by battle.
	draw_pile_button.card_pile = hero_stats.draw_pile
	draw_pile_view.card_pile = hero_stats.draw_pile
	discard_pile_button.card_pile = hero_stats.discard_pile
	discard_pile_view.card_pile = hero_stats.discard_pile

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	mana_ui.hero_stats = hero_stats
	hand.hero_stats = hero_stats

func _on_end_turn_button_pressed() -> void:
	end_turn_button.disabled = true
	Events.player_turn_ended.emit()

func _on_player_hand_drawn() -> void:
	end_turn_button.disabled = false

func _damage_popup(value: int, pos: Vector2) -> void:
	var number = Label.new()
	number.global_position = pos + Vector2(randi_range(-5, 5), randi_range(-5, 5))
	number.text = str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = Color.ALICE_BLUE
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 18
	number.label_settings.outline_color = Color.BLACK
	number.label_settings.outline_size = 3
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size/2)
	
	var enemy := pos.x > 320
	var launch_pos: Vector2 = number.position + Vector2(-15, -24)
	if enemy: 
		launch_pos += Vector2(30, 0)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(number, "position", launch_pos, 0.2)
	tween.tween_property(number, "position:y", number.position.y, 0.4).set_delay(0.2)
	tween.tween_property(number, "scale", Vector2.ZERO, 0.25).set_delay(0.4)
	await tween.finished
	number.queue_free()
