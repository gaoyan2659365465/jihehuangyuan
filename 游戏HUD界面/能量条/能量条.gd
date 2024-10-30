extends Control


signal 能量耗尽

@onready var p1: TextureRect = $"Bar/小点"
@onready var p2: TextureRect = $"Bar/小点2"


func _ready() -> void:
	初始化黑暗抗性()
	# 初始化心跳声
	设置心跳声音量(0.0)


func 初始化黑暗抗性():
	Global.player_save.设置黑暗抗性一级.connect(_on_设置黑暗抗性一级)
	Global.player_save.设置黑暗抗性二级.connect(_on_设置黑暗抗性二级)
	if Global.player_save.黑暗抗性一级:
		p1.visible = true
	if Global.player_save.黑暗抗性二级:
		p2.visible = true

func _on_设置黑暗抗性一级():
	p1.visible = true
	p2.visible = false

func _on_设置黑暗抗性二级():
	p1.visible = true
	p2.visible = true


func 停止消耗能量():
	$Timer.stop()

func 恢复消耗能量():
	$Timer.start()

# 每秒减少灯光能量
func _on_timer_timeout() -> void:
	if Global.player_save.黑暗抗性二级:
		$Bar.value -= 0.5
		return
	if Global.player_save.黑暗抗性一级:
		$Bar.value -= 100.0/150.0
	else:
		$Bar.value -= 1.0





# 角色进入灯光区域，快速补充能量，并隐藏进度条
func play_anim3():
	停止消耗能量()
	var tween = create_tween()
	tween.tween_property($Bar,"value",100,0.5).set_delay(0.5)
	tween.tween_property($Bar,"modulate",Color(1.0,1.0,1.0,0.0),0.2).set_delay(0.2)
	return tween

# 角色离开灯光域，显示进度条
func play_anim4():
	恢复消耗能量()
	var tween = create_tween()
	tween.tween_property($Bar,"modulate",Color(1.0,1.0,1.0,1.0),0.2)


func 设置心跳声音量(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("心跳"), linear_to_db(value))

# 无限循环心跳声
func _on_心跳声_finished() -> void:
	$"心跳声".play()

# 进度条值被改变
func _on_texture_progress_bar_value_changed(value: float) -> void:
	var db = (100.0 - value)/100.0
	if db <= 0.5 or db == 1.0:
		db = 0.0
	设置心跳声音量(db)
	if value == 0.0:
		emit_signal("能量耗尽")
