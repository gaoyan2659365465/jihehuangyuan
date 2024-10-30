extends Control

var t = 10

signal 计时结束

# 开始计时
func play():
	t = 10
	$Timer.start()

# 停止计时
func stop():
	$Timer.stop()

func _on_timer_timeout() -> void:
	var _t = t - 1
	if _t >= 0:
		t = _t
		$Label.text = str(t)
		play_anim($Label)
	else:
		$Timer.stop()
		emit_signal("计时结束")
	

func play_anim(target):
	var tween = create_tween()
	# 非阻塞模式
	tween.set_parallel(true)
	target.pivot_offset = target.size/2
	target.modulate = Color(1,1,1,1)
	target.scale = Vector2(1.0,1.0)
	tween.tween_property(target,"scale",Vector2(1.2,1.2),0.2)
	tween.tween_property(target,"scale",Vector2(1.0,1.0),0.2).set_delay(0.2)
	tween.tween_property(target,"modulate",Color(1,1,1,0),0.2).set_delay(0.7)
