extends Node2D



func _ready() -> void:
	$CanvasModulate.visible = true
	
	var hud = preload("res://游戏HUD界面/游戏hud界面.tscn").instantiate()
	Global.umg.add_child(hud)
	
	Global.play = $Player
	Global.game_scene = self
	Global.camera = $Camera2D
	
	var 相机框 = get_tree().get_nodes_in_group("相机框")
	for i in 相机框:
		i.follow_target = $Player
	
	var 能量电池 = get_tree().get_nodes_in_group("能量电池")
	for i in 能量电池:
		i.connect("解锁宝箱",_on_能量电池_解锁宝箱)
	

var 风声 = 1.0:
	set(value):
		风声 = value
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("风声"), linear_to_db(风声))

# 循环播放背景风声
func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()

# 循环播放钢琴BGM
func _on_audio_stream_player_2_finished() -> void:
	$AudioStreamPlayer2.play()


# 角色能量耗尽后会原地生成一盏灯，需要存储位置
func 创建死亡灯():
	var light = preload("res://灯光/灯光.tscn").instantiate()
	add_child(light)
	light.position = $Player.position
	light.rotation_degrees = -180.0
	Global.player_save.死掉灯.append($Player.position)
	Global.saveResource()
	

func _on_能量电池_解锁宝箱():
	Global.player_save.可分配经验 += 100
	Global.saveResource()
	var 信息框 = preload("res://游戏HUD界面/信息提示控件/message_panel.tscn").instantiate()
	Global.umg.add_child(信息框)
