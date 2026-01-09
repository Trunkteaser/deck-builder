extends Container
class_name Hand

const CARD =  preload("res://scenes/card/card.tscn")

@export var hero_stats: HeroStats


#region Fanning variables.
@export_group("Fanning")
@export var hand_curve: Curve
@export var rotation_curve: Curve
@export var max_rotation_degrees := 5
@export var x_sep := -10.0
@export var y_min := 0
@export var y_max := -15
#endregion

func _ready() -> void:
	#Events.request_card_draw.connect(draw) # Experimental.
	
	update_card_fanning()

func add_card(card_data: CardData) -> void:
	var new_card := CARD.instantiate()
	add_child(new_card)
	new_card.reparent_requested.connect(_on_card_reparent_requested)
	new_card.card_data = card_data
	new_card.parent = self
	new_card.hero_stats = hero_stats
	new_card.set_card_visuals()
	
	update_card_fanning()
	for child: Card in get_children():
		child.check_playability()

func discard_card(card: Card) -> void:
	card.queue_free()

func disable_hand() -> void: # Stops interaction with cards being discarded.
	for card: Card in get_children():
		card.disabled = true

func _on_card_reparent_requested(child: Card) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index)
	child.set_deferred("disabled", false)
	#can this call update card fanning?

#func draw() -> void: # Obsolete? Comment out.
	#var new_card = CARD.instantiate()
	#new_card.set_card_visuals()
	#add_child(new_card)
	#new_card.parent = self
	#update_card_fanning()
	#for child: Card in get_children():
		#child.check_playability()
	#
	## Temporary code to connect to drawn cards.
	#for child: Card in get_children():
		#if not child.reparent_requested.is_connected(_on_card_reparent_requested):
			#child.reparent_requested.connect(_on_card_reparent_requested)

func discard() -> void: # Still hooked up to the button.
	if get_child_count() < 1:
		return
	var child := get_child(-1)
	child.reparent(get_tree().root) # Instantly out of the hand to not mess with fanning.
	child.queue_free() # Implement discard pile later.
	update_card_fanning()

func update_card_fanning() -> void:
	var cards := get_child_count()
	var cards_total_size := Card.SIZE.x * cards + x_sep * (cards - 1)
	var final_x_sep := x_sep
	
	if cards_total_size > size.x: # If total size of cards is bigger than hand.
		final_x_sep = (size.x - Card.SIZE.x * cards) / (cards - 1)
		cards_total_size = size.x
	
	var offset := (size.x - cards_total_size) / 2 # Size remaining in hand / 2.
	
	for i in cards:
		var _card := get_child(i)
		var y_multiplier := hand_curve.sample(1.0 / (cards - 1) * i)
		var rot_multiplier := rotation_curve.sample(1.0 / (cards - 1) * i)
	
		if cards == 1:
			y_multiplier = 0.0
			rot_multiplier = 0.0
	
		var final_x: float = offset + Card.SIZE.x * i + final_x_sep * i
		var final_y: float = y_min + y_max * y_multiplier
		
		_card.position = Vector2(final_x, final_y)
		_card.rotation_degrees = max_rotation_degrees * rot_multiplier

func _on_child_order_changed() -> void:
	update_card_fanning()
