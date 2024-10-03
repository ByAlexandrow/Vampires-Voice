extends CharacterBody2D

@onready var flame_animations = $FlameAnimations
@onready var flame_sprite = $Flame

var min_speed = 150
var average_speed = 250
var max_speed = 400

enum State { IDLE, WALK, RUN, SLIDE, ROLL, HEALING, DAMAGE, DEATH, ATTACK_1, ATTACK_2, ATTACK_3, ATTACK_4 }
var current_state = State.IDLE

# Скольжение: направление, расстояние и скорость скольжения, текущее пройденное расстояние
var slide_direction = Vector2.ZERO
var slide_distance = 300
var slide_speed = 400
var current_slide_distance = 300

# Кувырок: направление, расстояние и скорость кувырка, текущее пройденное расстояние
var roll_direction = Vector2.ZERO
var roll_distance = 200
var roll_speed = 300
var current_roll_distance = 200


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	match current_state:
		State.IDLE:
			handle_idle_state(input_vector)
		State.WALK:
			handle_walk_state(input_vector)
		State.SLIDE:
			handle_slide_state(delta)
		State.ROLL:
			handle_roll_state(delta)
		
	move_and_slide()


func handle_idle_state(input_vector: Vector2) -> void:
	if input_vector != Vector2.ZERO:
		current_state = State.WALK
	else:
		flame_animations.play("Flame_idle")


func handle_walk_state(input_vector: Vector2) -> void:
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


func handle_slide_state(delta: float) -> void:
	if current_slide_distance < slide_distance:
		velocity = slide_direction * slide_speed
		current_slide_distance += velocity.length() * delta
	else:
		current_state = State.IDLE
		current_slide_distance = 0
		velocity = Vector2.ZERO


func handle_roll_state(delta: float) -> void:
	if current_roll_distance < roll_distance:
		velocity = roll_direction * roll_speed
		current_roll_distance += velocity.length() * delta
	else:
		current_state = State.IDLE
		current_roll_distance = 0
		velocity = Vector2.ZERO


func start_slide() -> void:
	if current_state != State.SLIDE:
		current_state = State.SLIDE
		slide_direction = get_slide_direction()
		flame_animations.play("Flame_slide")


func start_roll() -> void:
	if current_state != State.ROLL:
		current_state = State.ROLL
		roll_direction = get_roll_direction()
		flame_animations.play("Flame_roll")


func get_slide_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector == Vector2.ZERO:
		# Если игрок не двигается, скольжение происходит в направлении, куда он смотрит
		if flame_sprite.flip_h:
			return Vector2(-1, 0)
		else:
			return Vector2(1, 0)
	else:
		return input_vector.normalized()


func get_roll_direction() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector == Vector2.ZERO:
		# Если игрок не двигается, скольжение происходит в направлении, куда он смотрит
		if flame_sprite.flip_h:
			return Vector2(-1, 0)
		else:
			return Vector2(1, 0)
	else:
		return input_vector.normalized()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_slide"):
		start_slide()
	elif event.is_action_pressed("ui_roll"):
		start_roll()
