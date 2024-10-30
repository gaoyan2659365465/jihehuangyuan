extends Control


func _ready() -> void:
	初始化升级控件()
	初始化黑暗抗性文字()
	Global.player_save.设置可分配经验.connect(_on_设置可分配经验)
	可分配经验 = Global.player_save.可分配经验
	
	var bar = $VBoxContainer3/TextureProgressBar
	bar.max_value = 计算升级所需经验()
	bar.value = Global.player_save.经验条
	
	# 初始化移动模式文本
	if Global.player_save.跳跃:
		$VBoxContainer/Label3.text = "当前移动模式：跳跃"
	if Global.player_save.二段跳:
		$VBoxContainer/Label3.text = "当前移动模式：二段跳"
	
	$AnimationPlayer.play("进入")
	

var 可分配经验 = 0:
	set(value):
		可分配经验 = value
		$"已有经验".text = "已有经验：" + str(可分配经验)

func _on_设置可分配经验(old,new):
	可分配经验 = old
	var tween = create_tween()
	tween.tween_property(self,"可分配经验",new,0.5)
	# 非阻塞模式
	tween.set_parallel(true)
	# 沿着中心缩放
	$"已有经验".pivot_offset = $"已有经验".size/2
	tween.tween_property($"已有经验","scale",Vector2(1.1,1.1),0.2)
	tween.tween_property($"已有经验","scale",Vector2(1.0,1.0),0.1).set_delay(0.2)

func 初始化升级控件():
	$VBoxContainer3/Label.text = "角色等级：" + str(Global.player_save.等级)
	$VBoxContainer3/Label3.text = "升级所需经验：" + str(计算升级所需经验()-Global.player_save.经验条)

# 根据公式：经验 = 30 * （N * N * N+5 * N）- 80
# 每一级都需要这些经验才能升级到下一级
func 计算升级所需经验():
	var n = Global.player_save.等级
	return 30 * (n * n * n+5 * n) - 80

# 需要经验
func 升级():
	var 所需经验 = 计算升级所需经验()
	var 缺少经验 = 所需经验-Global.player_save.经验条
	
	var bar = $VBoxContainer3/TextureProgressBar
	bar.max_value = 所需经验
	bar.value = Global.player_save.经验条
	
	if Global.player_save.可分配经验 >= 缺少经验:
		# 需要播放进度条动画
		var tween = create_tween()
		tween.tween_property(bar,"value",所需经验,0.3)
		
		Global.player_save.经验条 = 所需经验
		Global.player_save.可分配经验 -= 缺少经验
		
		# 播放升级音效
		$AudioStreamPlayer.play()
		await tween.finished
		Global.player_save.等级 += 1
		Global.player_save.经验条 = 0
		# 升级后清空进度条
		bar.max_value = 所需经验
		bar.value = 0
	else:
		Global.player_save.经验条 += Global.player_save.可分配经验
		Global.player_save.可分配经验 = 0
		
		# 需要播放进度条动画
		var tween = create_tween()
		tween.tween_property(bar,"value",Global.player_save.经验条,0.5)
		
		await tween.finished
	
	Global.saveResource()


func 解锁跳跃():
	Global.player_save.跳跃 = true
	Global.saveResource()
	Global.play.初始化移动模式()

func 解锁二段跳():
	Global.player_save.二段跳 = true
	Global.saveResource()
	Global.play.初始化移动模式()

func 解锁黑暗抗性一级():
	Global.player_save.黑暗抗性一级 = true
	Global.saveResource()

func 解锁黑暗抗性二级():
	Global.player_save.黑暗抗性二级 = true
	Global.saveResource()


func _on_升级按钮_点击动画结束() -> void:
	await 升级()
	初始化升级控件()

# 需要有弹窗，说明已经兑换成功
func _on_解锁按钮_点击动画结束() -> void:
	if not Global.player_save.跳跃:
		if Global.player_save.可分配经验 >= 100:
			Global.player_save.可分配经验 -= 100
			解锁跳跃()
			$VBoxContainer/Label3.text = "当前移动模式：跳跃"
	else:
		if not Global.player_save.二段跳:
			if Global.player_save.可分配经验 >= 500:
				Global.player_save.可分配经验 -= 500
				解锁二段跳()
				$VBoxContainer/Label3.text = "当前移动模式：二段跳"
	初始化升级控件()
	

func 初始化黑暗抗性文字():
	$VBoxContainer2/Label3.text = "当前在黑暗中能存活：10秒"
	if Global.player_save.黑暗抗性一级:
		$VBoxContainer2/Label3.text = "当前在黑暗中能存活：15秒"
	if Global.player_save.黑暗抗性二级:
		$VBoxContainer2/Label3.text = "当前在黑暗中能存活：20秒"

func _on_解锁按钮2_点击动画结束() -> void:
	if not Global.player_save.黑暗抗性一级:
		if Global.player_save.可分配经验 >= 200:
			Global.player_save.可分配经验 -= 200
			解锁黑暗抗性一级()
	else:
		if not Global.player_save.黑暗抗性二级:
			if Global.player_save.可分配经验 >= 1000:
				Global.player_save.可分配经验 -= 1000
				解锁黑暗抗性二级()
	初始化黑暗抗性文字()
	初始化升级控件()


func _on_返回按钮_点击动画结束() -> void:
	$AnimationPlayer.play_backwards("进入")
	await $AnimationPlayer.animation_finished
	# 退出升级面板，恢复能量消耗
	queue_free()

func 显示叉号框(id=0,is_show=false):
	if id == 0:
		$"未解锁叉号0".visible = not is_show
	if id == 1:
		$"未解锁叉号1".visible = not is_show
	if id == 2:
		$"未解锁叉号2".visible = not is_show
