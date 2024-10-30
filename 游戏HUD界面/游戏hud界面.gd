extends Control

@onready var 跳跃: Control = $"跳跃"

@onready var 剧情镜头: Control = $"剧情镜头控件"
@onready var 视频转场: Control = $"视频转场"


func _ready() -> void:
	视频转场.进入场景转场End()

var is_light = false
func 进入灯光():
	is_light = true
	return $"能量条".play_anim3()

func 离开灯光():
	is_light = false
	$"能量条".play_anim4()

# 点击告示牌后触发
func 开始对话():
	$"能量条".停止消耗能量()

func 结束对话():
	# 如果当前玩家处于灯光中，则不恢复消耗能量
	if is_light:
		return
	$"能量条".恢复消耗能量()


func 进入战斗转场(敌人名字):
	await 视频转场.进入战斗转场Start()
	
	# 进入战斗时停止能量消耗，离开战斗后开启
	$"能量条".停止消耗能量()
	$"能量条".设置心跳声音量(0.0)
	Global.game_scene.风声 = 0.0
	
	var zd = preload("res://战斗场景/战斗场景.tscn").instantiate()
	add_child(zd)
	zd.初始化战斗场景(敌人名字)
	
	视频转场.进入战斗转场End()

# 删除战斗场景，并且返回是否胜利
func 离开战斗转场(target:Control,value=true):
	await 视频转场.进入战斗转场Start()
	# 离开战斗时开启能量消耗
	# 如果当前玩家处于灯光中，则不恢复消耗能量
	if not is_light:
		$"能量条".恢复消耗能量()
	Global.game_scene.风声 = 1.0
	
	target.queue_free()
	视频转场.进入战斗转场End()
	var 信息框 = preload("res://游戏HUD界面/信息提示控件/message_panel.tscn").instantiate()
	var jy = 0
	if value:
		jy = randi_range(450,550)
	else:
		jy = randi_range(10,30)
	信息框.text = "经验   +" + str(jy)
	Global.umg.add_child(信息框)
	Global.player_save.可分配经验 += jy
	Global.saveResource()
	

func _on_能量条_能量耗尽() -> void:
	# 静音风声
	var tween = create_tween()
	tween.tween_property(Global.game_scene,"风声",0.0,2.0)
	
	# 切换剧情模式
	剧情镜头.进入死亡剧情模式()
	
	await Global.play.死亡变成灯()
	Global.game_scene.创建死亡灯()
	
	await get_tree().create_timer(3.0).timeout
	
	var sw = preload("res://游戏HUD界面/死亡效果控件/死亡效果控件.tscn").instantiate()
	add_child(sw)
	await get_tree().create_timer(6.0).timeout
	
	# 复活
	var tween2 = create_tween()
	tween2.tween_property(Global.game_scene,"风声",1.0,2.0)
	# 切换相机
	Global.play.复活()
	# 切换非剧情模式
	剧情镜头.离开死亡剧情模式()
	sw.queue_free()
