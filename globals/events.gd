extends Node

# Card.
signal card_drag_started(card: Card)
signal card_drag_ended(card: Card)
signal card_aim_started(card: Card)
signal card_aim_ended(card: Card)
signal card_played(card_data: CardData)

# Player.
signal player_hand_drawn # To be emitted after having finished drawing.
signal player_hand_discarded
signal player_turn_ended
signal player_damaged # Emitted when damage goes past block.
signal player_died

# Enemy.
signal enemy_action_completed(enemy: Enemy)
signal enemy_turn_ended # Emit after ALL enemies have finished their turns.

# Effect.
signal request_card_draw(amount: int)
signal request_discard(amount: int)

# Battle.
signal battle_won
signal damage_taken(value: int, position: Vector2) # For dmg popup tween.

# Map.
signal map_exited(room: Room) # More like room entered.

# Shop.
signal shop_exited

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
