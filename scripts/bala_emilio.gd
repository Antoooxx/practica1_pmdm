extends Node2D

var pos_original
var body_entered = false

func _ready() -> void:
	pos_original = global_position.y


func _physics_process(delta: float) -> void:
	$bala_emilio.position.y -= 5
	
	if body_entered:
		$bala_emilio.position.y = pos_original
	
func _on_area_tp_area_entered(area: Area2D) -> void:
	body_entered = true


func _on_area_tp_area_exited(area: Area2D) -> void:
	body_entered = false
