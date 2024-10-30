class_name Chest extends Node2D


# 宝箱，碰到就生成经验球

@onready var flyball_generator: FlyballGenerator = $FlyballGenerator
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# 是否开启
var is_start:bool = false

signal 解锁宝箱

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body as Player:
		if self.is_start:
			return
		flyball_generator.target = body
		animation_player.play("chest_start_anim")
		$"方块炸裂特效".emitting = true
		self.is_start = true
		emit_signal("解锁宝箱")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	flyball_generator.createFlyBall()
	await get_tree().create_timer(2.0).timeout
	queue_free()
