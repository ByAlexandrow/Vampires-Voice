extends CharacterBody2D

@onready var shine_animations = $ShineAnimations
@onready var shine_sprite = $Shine

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
			shine_sprite.flip_h = false
			shine_animations.play("Shine_walk_right")
		elif input_vector.x < 0:
			shine_sprite.flip_h = true
			shine_animations.play("Shine_walk_right")
		else:
			if input_vector.y > 0 or input_vector.y < 0:
				shine_animations.play("Shine_walk_right")
		velocity = input_vector.normalized() * min_speed
	else:
		shine_animations.play("Shine_idle")
		velocity = Vector2.ZERO
	move_and_slide()
