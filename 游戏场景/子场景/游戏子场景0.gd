extends Node2D



func _ready() -> void:
	if Global.player_save.背景装饰红色眼睛:
		$"特效/所有红眼".visible = true
	Global.player_save.设置背景装饰红色眼睛.connect(_on_设置背景装饰红色眼睛)

func _on_设置背景装饰红色眼睛():
	$"特效/所有红眼".visible = true
