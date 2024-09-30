extends Control

@onready var fire_warrior_anim = $HeroFireWarrior
@onready var lightning_woman_anim = $HeroLightningWoman

var selected_hero = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_warrior_anim.play("HeroFireWarrior")
	lightning_woman_anim.play("HeroLightningWoman")
	$ChoiceFlame.connect("pressed", Callable(self, "_on_hero_button_pressed").bind("Flame"))
	$ChoiceShine.connect("pressed", Callable(self, "_on_hero_button_pressed").bind("Shine"))
	$RandomChoiceHeroButton.connect("pressed", Callable(self, "_on_random_choice_hero_button_pressed")) # Replace with function body.


func _on_hero_button_pressed(hero_name):
	selected_hero = hero_name
	save_hero_selection()
	get_tree().change_scene_to_file("res://Scene/GameSettings.tscn")


func save_hero_selection():
	var config = ConfigFile.new()
	config.set_value("HeroSelection", "SelectedHero", selected_hero)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameMenu.tscn") # Replace with function body.


func _on_random_choice_hero_button_pressed() -> void:
	var random_heroes = ["Flame", "Shine"]
	selected_hero = random_heroes[randi() % random_heroes.size()]
	save_hero_selection()
	get_tree().change_scene_to_file("res://Scene/GameSettings.tscn")# Replace with function body.
