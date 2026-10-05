extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var body_entered = false
var derecha = true

func _process(delta: float) -> void:

	if velocity.x > 0:
		$AnimatedSprite2D.play("red_walk")
		$AnimatedSprite2D.flip_h = false
		derecha = true
	elif velocity.x < 0:
		$AnimatedSprite2D.play("red_walk")
		$AnimatedSprite2D.flip_h = true
		derecha = false
	elif body_entered:
		$AnimatedSprite2D.play("red_atack")
	else:
		$AnimatedSprite2D.play("red_idle")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if $izq.is_colliding():
		velocity.x = SPEED
	elif $dcha.is_colliding():
		velocity.x = -SPEED
	elif not $abajo_dcha.is_colliding():
		velocity.x = -SPEED
	elif not $abajo_izq.is_colliding():
		velocity.x = SPEED
	
	move_and_slide()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "blue_slime":
		body_entered = false
		
		if derecha:
			velocity.x = SPEED
		else:
			velocity.x = -SPEED

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "blue_slime":
		body_entered = true
		velocity.x = 0
