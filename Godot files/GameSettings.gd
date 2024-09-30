extends Control

@onready var necromant_anim = $Necromant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	necromant_anim.play("Necromant") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://GameMenu.tscn") # Replace with function body.
