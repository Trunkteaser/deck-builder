extends VBoxContainer
class_name ManaUI

const MANA_ICON_SCENE = preload("uid://7lmdiuapkdif")
const EMPTY_MANA_ICON = preload("uid://bcng3h7dx1ns")

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var mana_label: Label = %ManaLabel
@onready var icon_container: VBoxContainer = %IconContainer
@onready var extra_icon_container: VBoxContainer = %ExtraIconContainer

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	if not hero_stats.mana_changed.is_connected(_on_mana_changed):
		hero_stats.mana_changed.connect(_on_mana_changed)
	if not is_node_ready():
		await ready
	_on_mana_changed()

func _on_mana_changed() -> void:
	mana_label.text = "%s/%s" % [hero_stats.mana, hero_stats.max_mana]
	# Remove old icons.
	for mana_icon: ManaIcon in extra_icon_container.get_children():
		mana_icon.queue_free()
	for mana_icon: ManaIcon in icon_container.get_children():
		mana_icon.queue_free()
	# Create base icons.
	for i in hero_stats.max_mana:
		var mana_icon: ManaIcon = MANA_ICON_SCENE.instantiate()
		icon_container.add_child(mana_icon)
	# Create extra icons.
	if hero_stats.mana > hero_stats.max_mana:
		for i in (hero_stats.mana - hero_stats.max_mana):
			var mana_icon: ManaIcon = MANA_ICON_SCENE.instantiate()
			extra_icon_container.add_child(mana_icon)
	# Alter base icons.
	elif hero_stats.max_mana > hero_stats.mana:
		await get_tree().process_frame
		var base_icons := icon_container.get_children()
		for i in (hero_stats.max_mana - hero_stats.mana):
			if base_icons.size() > i:
				base_icons[i].empty()
				#base_icons[i].change_icon(EMPTY_MANA_ICON)
			
