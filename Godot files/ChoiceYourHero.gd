extends Control

@onready var flame_hero = $HeroFireWarrior
@onready var shine_hero = $HeroLightningWoman

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flame_hero.play("HeroFireWarrior")
	shine_hero.play("HeroLightningWoman")
	$RandomChoiceHeroButton.connect("pressed", Callable(self, "_on_random_choice_hero_button_pressed")) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameMenu.tscn") # Replace with function body.


func _on_choice_flame_pressed() -> void:
	Global.hero = "Flame"
	get_tree().change_scene_to_file("res://Scene/GameWorld.tscn") # Replace with function body.
	

func _on_choice_shine_pressed() -> void:
	Global.hero = "Shine"
	get_tree().change_scene_to_file("res://Scene/GameWorld.tscn") # Replace with function body.
