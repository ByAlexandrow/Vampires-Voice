extends CharacterBody2D

@onready var flame_animations = $FlameAnimations
@onready var flame_sprite = $Flame

var min_speed = 150
var average_speed = 250
var max_speed = 400


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			flame_sprite.flip_h = false
			flame_animations.play("Flame_walk_right")
		elif input_vector.x < 0:
			flame_sprite.flip_h = true
			flame_animations.play("Flame_walk_right")
		else:
			if input_vector.y > 0 or input_vector.y < 0:
				flame_animations.play("Flame_walk_right")
		velocity = input_vector.normalized() * min_speed
	else:
		flame_animations.play("Flame_idle")
		velocity = Vector2.ZERO
	move_and_slide()
