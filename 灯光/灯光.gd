extends PointLight2D

func _init() -> void:
	energy = 0.0

func _ready() -> void:
	await play_anim2(self)
	play_anim(self)


# 呼吸灯效果，明暗动画
func play_anim(target):
	var _tween = create_tween()
	_tween.set_loops()
	_tween.tween_property(target,"energy",1.5,3.0).set_ease(Tween.EASE_IN)
	_tween.tween_property(target,"energy",1.0,3.0).set_ease(Tween.EASE_IN)

# 灯开始出现时逐渐变亮
func play_anim2(target):
	var _tween = create_tween()
	_tween.tween_property(target,"energy",1.0,1.0).set_ease(Tween.EASE_IN)
	await _tween.finished

var tween:Tween
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		# 进度条充满并隐藏动画
		var 游戏HUD界面 = Global.umg.get_child(0)
		tween = 游戏HUD界面.进入灯光()
		Global.play.设置灯光亮度倍数(0.4)


# 当玩家离开灯的区域
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		if tween:
			tween.kill()
		# 进度条显示动画
		var 游戏HUD界面 = Global.umg.get_child(0)
		游戏HUD界面.离开灯光()
		Global.play.设置灯光亮度倍数(1.0)
