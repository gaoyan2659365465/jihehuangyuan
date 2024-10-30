extends Node2D



func _ready() -> void:
	$Timer.wait_time = randf_range(0.0,3.0)
	$Timer.start()

func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(0.0,3.0)
	$AnimationPlayer.play("眨眼")
