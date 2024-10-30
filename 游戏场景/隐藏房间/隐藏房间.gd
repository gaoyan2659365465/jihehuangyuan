extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# 玩家进入隐藏房间
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimationPlayer.play("显示")

# 玩家离开隐藏房间
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		$AnimationPlayer.play_backwards("显示")
