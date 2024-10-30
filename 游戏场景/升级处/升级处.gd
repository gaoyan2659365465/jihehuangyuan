class_name 升级处 extends 超级按钮


# 解锁升级、跳跃、黑暗抗性
# 有可能解锁其中N项，未解锁的被白色叉号框罩住，无法点击
@export var 解锁升级 = false
@export var 解锁跳跃 = false
@export var 解锁黑暗抗性 = false




func _on_点击动画结束() -> void:
	$"感叹号特效".visible = false
	
	# 显示升级页面
	var sj = preload("res://游戏HUD界面/升级面板/升级面板.tscn").instantiate()
	Global.umg.add_child(sj)
	sj.显示叉号框(0,解锁升级)
	sj.显示叉号框(1,解锁黑暗抗性)
	sj.显示叉号框(2,解锁跳跃)
