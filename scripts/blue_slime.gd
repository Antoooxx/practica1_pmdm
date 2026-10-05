extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -400.0
const NUM_SALTOS = 2

var cont_saltos = 0

var body_entered = false

func _process(delta: float) -> void:
	if velocity.y < 0:
		$AnimatedSprite2D.play("blue_jump")
	elif velocity.x > 0:
		$AnimatedSprite2D.play("blue_walk")
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.play("blue_walk")
		$AnimatedSprite2D.flip_h = true
	elif body_entered:
		$AnimatedSprite2D.play("blue_die")
		$AnimatedSprite2D.sprite_frames.set_animation_loop_mode("blue_die", SpriteFrames.LoopMode.LOOP_NONE)

	else:
		$AnimatedSprite2D.play("blue_idle")

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if Input.is_action_just_pressed("ui_W") and cont_saltos < NUM_SALTOS:
			velocity.y = JUMP_VELOCITY
			cont_saltos += 1
	else:
		cont_saltos = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_W") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_A", "ui_D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "red_slime":
		body_entered = true
		velocity.x = 0


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "red_slime":
		body_entered = false
