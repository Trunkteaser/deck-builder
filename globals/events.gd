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

signal request_card_draw()
