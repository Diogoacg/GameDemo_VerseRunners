extends CharacterBody2D

const SPEED = 150.0
const SHIFT_SPEED = 50.0
const JUMP_VELOCITY = -350.0
const ACCELERATION = 500.0
const DECELERATION = 500.0
const MAX_SPEED = 200.0
const MIN_SPEED = -200.0
const DASH_SPEED = 500.0
const DASH_TIME = 0.1

@onready var dash_cooldown_timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_speed = 0.0
var is_dashing = false
var dash_timer = 0.0

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	handle_dash()
	handle_movement(delta)
	update_animated_sprite()
	update_dash_timer(delta)
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor() and not is_dashing:
		velocity.y += gravity * delta

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_speed = velocity.x

func handle_dash():
	if Input.is_action_just_pressed("dash") and not is_on_floor() and not is_dashing and dash_cooldown_timer.is_stopped():
		velocity.x = DASH_SPEED * Input.get_axis("move_left", "move_right")
		is_dashing = true
		dash_timer = DASH_TIME
		dash_cooldown_timer.start()

func handle_movement(delta):
	var direction = Input.get_axis("move_left", "move_right")
	var speed = SPEED
	
	if Input.is_action_pressed("restart"):
		GameManager.scores[0]=0
		animation_player.play("restart")

	if Input.is_action_pressed("shift") and is_on_floor():
		speed = SHIFT_SPEED
	
	if is_dashing:
		velocity.y = 0
		return

	if direction:
		if is_on_floor():
			accelerate(direction, speed, delta)
		else:
			adjust_airborne_velocity(direction, delta)
	else:
		decelerate(delta)

func accelerate(direction, speed, delta):
	if sign(velocity.x) != sign(direction):
		velocity.x *= -1
	if abs(velocity.x) < speed:
		velocity.x = speed * direction
	velocity.x += speed * direction * delta
	velocity.x = clamp(velocity.x, MIN_SPEED, MAX_SPEED)
	if Input.is_action_pressed("shift"):
		velocity.x = clamp(velocity.x, -SHIFT_SPEED, SHIFT_SPEED)

func adjust_airborne_velocity(direction, delta):
	if abs(velocity.x) < 10:
		velocity.x = 50 * direction
	velocity.x -= sign(velocity.x) * delta * 100
	velocity.x = clamp(velocity.x, MIN_SPEED, MAX_SPEED)
	if sign(velocity.x) != sign(direction):
		velocity.x *= -1
	if Input.is_action_pressed("shift"):
		velocity.x = clamp(velocity.x, -SHIFT_SPEED, SHIFT_SPEED)

func decelerate(delta):
	velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

func update_animated_sprite():
	var direction = Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("midair")

func update_dash_timer(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

func die():
	if not animation_player.is_playing():
		self.get_node("CollisionShape2D").queue_free()
		animation_player.play("fade_in")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	if anim_name == "restart":
		get_tree().reload_current_scene()
		

