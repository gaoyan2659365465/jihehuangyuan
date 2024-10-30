extends Control

signal 进入游戏

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	$AnimationPlayer.play("开始按钮出现")


func _on_开始游戏按钮_点击动画结束() -> void:
	await get_tree().create_timer(0.2).timeout
	$AnimationPlayer.play("开始按钮离开")
	await $AnimationPlayer.animation_finished
	emit_signal("进入游戏")

func _on_bgm_finished() -> void:
	await get_tree().create_timer(2).timeout
	$Bgm.play()
