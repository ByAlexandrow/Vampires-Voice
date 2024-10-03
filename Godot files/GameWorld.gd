extends Node2D


func _ready() -> void:
	var hero_scene
	if Global.hero == "Flame":
		hero_scene = preload("res://Scene/Player/Flame.tscn")
	elif Global.hero == "Shine":
		hero_scene = preload("res://Scene/Player/Shine.tscn")
	
	if hero_scene:
		var hero = hero_scene.instantiate()
		add_child(hero)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
