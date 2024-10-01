extends Control

@onready var flame_hero = $HeroFireWarrior
@onready var shine_hero = $HeroLightningWoman

var selected_hero = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flame_hero.play("HeroFireWarrior")
	shine_hero.play("HeroLightningWoman")
	$ChoiceFlame.connect("pressed", Callable(self, "_on_hero_button_pressed").bind("Flame"))
	$ChoiceShine.connect("pressed", Callable(self, "_on_hero_button_pressed").bind("Shine"))
	$RandomChoiceHeroButton.connect("pressed", Callable(self, "_on_random_choice_hero_button_pressed")) # Replace with function body.


func _on_hero_button_pressed(hero_name):
	selected_hero = hero_name
	save_hero_selection()
	get_tree().change_scene_to_file("res://Scene/GameWorld.tscn")


func save_hero_selection():
	var config = ConfigFile.new()
	var err = config.load("user://hero_selection.cfg")
	if err != OK:
		err = config.save("user://hero_selection.cfg")
	if err == OK:
		config.set_value("HeroSelection", "SelectedHero", selected_hero)
		config.save("user://hero_selection.cfg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameMenu.tscn") # Replace with function body.


func _on_random_choice_hero_button_pressed() -> void:
	var random_heroes = ["Flame", "Shine"]
	selected_hero = random_heroes[randi() % random_heroes.size()]
	save_hero_selection()
	get_tree().change_scene_to_file("res://Scene/GameWorld.tscn")
