class_name 告示牌 extends 超级按钮


@export
var 告示牌名:String = "告示牌1"

@export var 是否战斗:bool = false
@export var 敌人名字:String = ""


# 如果第一次点击，则播放摇晃和感叹号特效
func _ready() -> void:
	super._ready()
	
	# 没有被点击过才摇晃显示感叹号
	var is_ok = true
	for i in Global.player_save.告示牌被点击:
		if i == 告示牌名:
			is_ok = false
	if is_ok:
		$"感叹号特效".visible = true
		$AnimationPlayer.play("告示牌摇晃")


# 确保没有重复项
func 设置告示牌被点击(value):
	var is_ok = true
	for i in Global.player_save.告示牌被点击:
		if i == value:
			is_ok = false
	if is_ok:
		Global.player_save.告示牌被点击.append(value)
		

func _on_点击动画结束() -> void:
	$"感叹号特效".visible = false
	
	var 游戏HUD界面 = Global.umg.get_child(0)
	#游戏HUD界面.进入战斗转场(敌人名字)
	#return
	
	# 停止消耗能量
	游戏HUD界面.开始对话()
	await 游戏HUD界面.剧情镜头.进入剧情模式()
	
	var qp = preload("res://游戏HUD界面/对话气泡/对话气泡.tscn").instantiate()
	qp.connect("关闭",_on_气泡关闭)
	Global.umg.add_child(qp)
	qp.告示牌名 = 告示牌名
	
	设置告示牌被点击(告示牌名)
	if 告示牌名 == "告示牌0_2":
		Global.player_save.背景装饰红色眼睛 = true
	Global.saveResource()
	
func _on_气泡关闭():
	# 切换剧情模式
	var 游戏HUD界面 = Global.umg.get_child(0)
	# 恢复消耗能量
	游戏HUD界面.结束对话()
	await 游戏HUD界面.剧情镜头.离开剧情模式()
	
	if 是否战斗:
		# 进入战斗界面
		游戏HUD界面.进入战斗转场(敌人名字)
