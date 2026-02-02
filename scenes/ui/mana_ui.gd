extends VBoxContainer
class_name ManaUI

const FULL_MANA = preload("uid://qelom54kfj4q")
const EMPTY_MANA = preload("uid://dish3ghum7b4c")
const MANA_ICON = preload("uid://7lmdiuapkdif")

@export var hero_stats: HeroStats : set = _set_hero_stats

@onready var mana_label: Label = %ManaLabel
@onready var mana_icons: VBoxContainer = %ManaIcons

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	hero_stats.mana = 3

func _set_hero_stats(value: HeroStats) -> void:
	hero_stats = value
	#if not hero_stats.stats_changed.is_connected(_on_stats_changed):
		#hero_stats.stats_changed.connect(_on_stats_changed)
	if not hero_stats.mana_changed.is_connected(_on_mana_changed):
		hero_stats.mana_changed.connect(_on_mana_changed)
	if not is_node_ready():
		await ready
	#_on_stats_changed()
	_on_mana_changed()

func _on_mana_changed() -> void:
	mana_label.text = "%s/%s" % [hero_stats.mana, hero_stats.max_mana]
	for mana_icon in mana_icons.get_children():
		mana_icon.queue_free()
	#await get_tree().process_frame
	for i in hero_stats.mana:
		var icon: ManaIcon = MANA_ICON.instantiate()
		mana_icons.add_child(icon)
	var empty_mana: int = hero_stats.max_mana - hero_stats.mana
	if empty_mana <= 0:
		return
	# Ändra textur på de som ska vara svarta.
	# empty_mana = antalet ikoner som behöver ändra textur.
	#var current_mana_icons: Array[ManaIcon]
	#for mana_icon in mana_icons.get_children():
		#if mana_icon.is_inside_tree():
			#current_mana_icons.append(mana_icon)
	#print(current_mana_icons)
	#for i in empty_mana:
		#current_mana_icons[i].change_icon(EMPTY_MANA)
		
	
