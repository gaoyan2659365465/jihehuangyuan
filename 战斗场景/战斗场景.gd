extends Control


var 玩家
var 敌人

var 玩家死亡 = false
var 敌人死亡 = false



func 初始化战斗场景(敌人名字):
	Global.战斗场景 = self
	
	初始化角色(敌人名字)
	
	初始化血条控件()
	
	初始化技能()
	
	$"倒计时控件".play()
	
	if Global.player_save.第一次进入战斗:
		var zz = preload("res://游戏HUD界面/引导/引导遮罩.tscn").instantiate()
		self.add_child(zz)
		await get_tree().create_timer(1.5).timeout
		# 可能提前点击被删除
		if zz:
			zz.过渡动画()
		Global.player_save.第一次进入战斗 = false
		Global.saveResource()

# 初始化角色
func 初始化角色(敌人名字):
	玩家 = preload("res://战斗场景/角色/角色.tscn").instantiate()
	add_child(玩家)
	玩家.名字 = "光核三角"
	玩家.position = Vector2(299,339)
	
	敌人 = preload("res://战斗场景/角色/角色.tscn").instantiate()
	add_child(敌人)
	敌人.名字 = 敌人名字
	敌人.position = Vector2(884,339)

# 初始化血条控件
func 初始化血条控件():
	$"血条控件".初始化血条控件(玩家)
	$"血条控件2".初始化血条控件(敌人)

func 初始化技能():
	$"战斗功能板控件".初始化技能(玩家)


func _on_倒计时控件_计时结束() -> void:
	# 锁定我方操作
	$"战斗功能板控件".禁用技能(true)
	$"倒计时控件".stop()
	# 敌方释放技能
	await get_tree().create_timer(1.0).timeout
	敌人.ability_system.try_activate_abilities_by_tag("几何冲撞")
	# 相机震动
	Global.camera.shake_UI(self)
	# 播放打击音效
	根据技能名播放音效("几何冲撞")
	
	# 播放攻击动画
	玩家.攻击动画()
	await get_tree().create_timer(0.2).timeout
	敌人.受击动画()
	
	await get_tree().create_timer(1.0).timeout
	# 开始下一回合
	$"回合显示控件".回合加一()
	$"倒计时控件".play()
	# 解锁我方操作
	$"战斗功能板控件".禁用技能(false)
	
func _on_战斗功能板控件_玩家释放技能(技能: Variant) -> void:
	# 检测敌人是否死亡
	if 玩家死亡:
		return
		
	# 锁定我方操作
	$"战斗功能板控件".禁用技能(true)
	$"倒计时控件".stop()
	await get_tree().create_timer(1.0).timeout
	print(技能.技能名字)
	玩家.ability_system.try_activate_abilities_by_tag(技能.技能名字)
	# 相机震动
	Global.camera.shake_UI(self)
	# 播放打击音效
	根据技能名播放音效(技能.技能名字)
	# 播放攻击动画
	玩家.攻击动画()
	await get_tree().create_timer(0.2).timeout
	敌人.受击动画()
	
	# 检测敌人是否死亡
	if 敌人死亡:
		return
	
	# 敌方释放技能
	await get_tree().create_timer(1.0).timeout
	敌人.ability_system.try_activate_abilities_by_tag("几何冲撞")
	# 相机震动
	Global.camera.shake_UI(self)
	# 播放打击音效
	根据技能名播放音效("几何冲撞")
	# 播放攻击动画
	敌人.攻击动画()
	await get_tree().create_timer(0.2).timeout
	玩家.受击动画()
	
	
	await get_tree().create_timer(1.0).timeout
	# 开始下一回合
	$"回合显示控件".回合加一()
	$"倒计时控件".play()
	# 解锁我方操作
	$"战斗功能板控件".禁用技能(false)

# 玩家死亡
func _on_血条控件_死亡() -> void:
	玩家死亡 = true
	$AudioStreamPlayer3.play()
	await get_tree().create_timer(1.0).timeout
	var 游戏HUD界面 = Global.umg.get_child(0)
	游戏HUD界面.离开战斗转场(self,false)

# 敌人死亡
func _on_血条控件2_死亡() -> void:
	敌人死亡 = true
	await get_tree().create_timer(1.0).timeout
	$AudioStreamPlayer2.play()
	var 游戏HUD界面 = Global.umg.get_child(0)
	游戏HUD界面.离开战斗转场(self,true)
	

func 根据技能名播放音效(技能名):
	if 技能名 == "几何冲撞":
		$AudioStreamPlayer.stream = preload("res://战斗场景/技能系统/几何冲撞/素材/撞击.mp3")
		$AudioStreamPlayer.play()
	elif 技能名 == "光之惩戒":
		$AudioStreamPlayer.stream = preload("res://战斗场景/技能系统/光之惩戒/素材/激光.mp3")
		await get_tree().create_timer(0.2).timeout
		$AudioStreamPlayer.play()

func 添加特效(target,pos):
	add_child(target)
	target.position = pos
	await get_tree().create_timer(3.0).timeout
	target.queue_free()
