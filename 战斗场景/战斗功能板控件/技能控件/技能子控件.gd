extends 超级按钮


var 技能引用

# 解锁和锁定状态，当处于己的回合时候才能点击释放技能


signal 点击释放技能(技能引用)

func _ready() -> void:
	super._ready()
	# 刚进入对战允许玩家技能亮起
	禁用技能(false)


func 初始化技能(target:Ability):
	技能引用 = target
	target.最大使用次数被改变.connect(_on_最大使用次数被改变)
	target.当前剩余次数被改变.connect(_on_当前剩余次数被改变)
	$HBoxContainer/Label2.text = str(技能引用.当前剩余次数) + "/" + str(技能引用.最大使用次数)
	
	$"技能名".text = str(技能引用.技能名字)
	$HBoxContainer2/Label2.text = str(技能引用.威力)


func _on_最大使用次数被改变(old_value, new_value):
	$HBoxContainer/Label2.text = str(技能引用.当前剩余次数) + "/" + str(new_value)

func _on_当前剩余次数被改变(old_value, new_value):
	$HBoxContainer/Label2.text = str(new_value) + "/" + str(技能引用.最大使用次数)


func _on_点击动画结束() -> void:
	if 技能引用.当前剩余次数 > 0:
		emit_signal("点击释放技能",技能引用)
		禁用技能(true)


func 禁用技能(value=false):
	disabled = value
	if disabled:
		$"技能名".label_settings.font_color = Color(0.254, 0.254, 0.254)
	else:
		$"技能名".label_settings.font_color = Color(1, 1, 1)
