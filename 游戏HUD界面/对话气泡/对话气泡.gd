extends NinePatchRect


signal 关闭

var 当前对话数 = 0
var 对话数据 = []

var 告示牌名:String = "告示牌1":
	set(value):
		告示牌名 = value
		if 告示牌名 != "":
			对话数据 = Global.excel_data.获取对话(告示牌名)
			_on_超级按钮_button_down()
		else:
			print("错误，告示牌为空")

func _ready() -> void:
	$翻书页声.play(0.2)
	play_anim($"超级按钮/Label")
	
	if Global.player_save.第一次进入对话:
		$Label.visible = true
		Global.player_save.第一次进入对话 = false
		Global.saveResource()
	

# 播放文字摇晃动画
func play_anim(target):
	var tween = create_tween()
	# 非阻塞模式
	tween.set_parallel(true)
	# 沿着中心缩放
	target.pivot_offset = target.size/2
	
	var rot = randf_range(0.01,0.1)
	tween.tween_property(target,"rotation",rot,0.08)
	tween.tween_property(target,"rotation",0.0,0.08).set_delay(0.08)
	tween.tween_property(target,"rotation",-rot,0.08).set_delay(0.08*2)
	tween.tween_property(target,"rotation",0.0,0.08).set_delay(0.08*3)
	tween.tween_property(target,"rotation",rot,0.08).set_delay(0.08*4)
	tween.tween_property(target,"rotation",0.0,0.08).set_delay(0.08*5)
	tween.tween_property(target,"rotation",-rot,0.08).set_delay(0.08*6)
	tween.tween_property(target,"rotation",0.0,0.08).set_delay(0.08*7)
	
	var pos = Vector2(randi_range(0,5),randi_range(0,5))
	tween.tween_property(target,"position",pos,0.08)
	tween.tween_property(target,"position",Vector2(0,0),0.08).set_delay(0.08)
	tween.tween_property(target,"position",-pos,0.08).set_delay(0.08*2)
	tween.tween_property(target,"position",Vector2(0,0),0.08).set_delay(0.08*3)
	tween.tween_property(target,"position",pos,0.08).set_delay(0.08*4)
	tween.tween_property(target,"position",Vector2(0,0),0.08).set_delay(0.08*5)
	tween.tween_property(target,"position",-pos,0.08).set_delay(0.08*6)
	tween.tween_property(target,"position",Vector2(0,0),0.08).set_delay(0.08*7)


func _on_超级按钮_点击动画结束() -> void:
	play_anim($"超级按钮/Label")


func _on_超级按钮_button_down() -> void:
	if 对话数据.size() > 当前对话数:
		$"超级按钮/Label".text = str(对话数据[当前对话数])
		当前对话数 += 1
		
		# 第一次进入气泡时候有引导提示
		if 当前对话数 > 1:
			$Label.visible = false
	else:
		$翻书页声.play(0.2)
		await get_tree().create_timer(0.3).timeout
		emit_signal("关闭")
		queue_free()
