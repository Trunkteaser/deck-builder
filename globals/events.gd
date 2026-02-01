extends Node

# Card.
signal card_drag_started(card: Card)
signal card_drag_ended(card: Card)
signal card_aim_started(card: Card)
signal card_aim_ended(card: Card)
signal card_played(card_data: CardData)
signal update_card_descriptions() # Emitted when ModifierValues altered.
signal card_drawn(card_data: CardData)
signal request_random_discard(amount: int)
signal request_specific_discard(card_data: CardData)

# Player.
signal player_hand_drawn # To be emitted after having finished drawing.
signal post_mana_reset
signal player_hand_discarded
signal player_turn_ended
signal player_damaged # Emitted when damage goes past block.
signal player_died

# Enemy.
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended # Emit after ALL enemies have finished their turns.
signal enemy_died(enemy: Enemy)

# Effect.
signal request_card_draw(amount: int)
signal request_discard(amount: int) # Not hooked up to anything.

# Battle.
signal battle_won
signal damage_taken(value: int, position: Vector2) # For dmg popup tween.
signal mood_changed

# Map.
signal map_exited(room: Room) # More like room entered.

# Shop.
signal shop_exited
signal shop_card_bought(card_data: CardData, inspiration_cost: int)
signal shop_mantra_bought(mantra: Mantra, inspiration_cost: int)

# Campfire?
signal campfire_exited

# Treasure room?
signal treasure_room_exited

# Event?
signal event_exited

# Hermit?
signal hermit_exited

# Battle rewards.
signal battle_reward_exited
signal card_reward_selected(card_data: CardData)

# Animations
signal animate(animation_name: String)
