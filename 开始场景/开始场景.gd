extends Node2D


func _ready() -> void:
	%"视频转场".进入游戏转场()

func _process(delta: float) -> void:
	pass
	


func _on_主菜单界面_进入游戏() -> void:
	await %"视频转场".进入场景转场Start()
	get_tree().change_scene_to_file("res://游戏场景/游戏场景.tscn")
