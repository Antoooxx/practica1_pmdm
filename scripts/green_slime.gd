extends CharacterBody2D

var body_entered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if body_entered:
		$AnimatedSprite2D.play("die")
	else:
		$AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
