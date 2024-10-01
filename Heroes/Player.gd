extends CharacterBody2D

@onready var main_hero = $MainHero

var min_speed = 150
var max_speed = 400

func _ready() -> void:
	load_hero_selection()

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		velocity = input_vector.normalized() * min_speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func load_hero_selection():
	var config = ConfigFile.new()
	var err = config.load("user://hero_selection.cfg")
	
	if err == OK:
		var selected_hero = config.get_value("HeroSelection", "SelectedHero", "Unknown")
		print("Selected hero: ", selected_hero)
		load_hero_sprite(selected_hero)
	else:
		print("No hero selected")

func load_hero_sprite(hero_name):
	var sprite_path = "res://Heroes/" + hero_name + ".png"
	var sprite_texture = load(sprite_path)
	
	if sprite_texture:
		main_hero.texture = sprite_texture
		print("Hero sprite loaded successfully")
	else:
		print("Sprite not found for hero: ", hero_name)
