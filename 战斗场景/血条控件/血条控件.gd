@tool
extends Control


signal 死亡

enum STATE{
	PLAY_HP,# 玩家血条左边
	ENEMY_HP,# 敌人血条右边
}

# 当前血条的状态
@export var start:STATE = STATE.PLAY_HP:
	set(value):
		self.updateState(start,value)
		start = value

# 更新当前状态
func updateState(old_state:STATE,new_state:STATE):
	if new_state == STATE.PLAY_HP:
		$HBoxContainer.move_child(%"头像",0)
		%TextureProgressBar.fill_mode = TextureProgressBar.FILL_LEFT_TO_RIGHT
		$"HBoxContainer/MarginContainer/装饰血条".fill_mode = TextureProgressBar.FILL_LEFT_TO_RIGHT
		%"血量".visible = true
		%"血量".position = Vector2(292,-27)
		
		var tex:GradientTexture2D = %TextureProgressBar.texture_progress
		var grad:Gradient = tex.gradient
		grad.set_color(0,Color("#fcfff5"))
		grad.set_color(1,Color("#fcfff5"))
		tex.gradient = grad
		
	elif new_state == STATE.ENEMY_HP:
		$HBoxContainer.move_child($HBoxContainer/MarginContainer,0)
		%TextureProgressBar.fill_mode = TextureProgressBar.FILL_RIGHT_TO_LEFT
		$"HBoxContainer/MarginContainer/装饰血条".fill_mode = TextureProgressBar.FILL_RIGHT_TO_LEFT
		#%"血量".visible = false
		%"血量".position = Vector2(20,-27)
		
		var tex:GradientTexture2D = %TextureProgressBar.texture_progress
		var grad:Gradient = tex.gradient
		grad.set_color(0,Color("#fcfff5"))
		grad.set_color(1,Color("#fcfff5"))
		tex.gradient = grad
		

# 血条控件拿到角色属性的引用，方便获取值
var 属性
func 初始化血条控件(绑定角色):
	# 等待角色初始化完毕
	await get_tree().process_frame
	
	%"名字".text = 绑定角色.名字
	属性 = 绑定角色.ability_system.attribute
	%"等级".text = "LV:" + str(属性.等级)
	%"血量".text = str(属性.血量) + "/" + str(属性.最大血量)
	
	属性.血量被改变.connect(_on_血量被改变)
	属性.最大血量被改变.connect(_on_最大血量被改变)
	%TextureProgressBar.max_value = 属性.最大血量
	%TextureProgressBar.value = 属性.血量
	$"HBoxContainer/MarginContainer/装饰血条".max_value = 属性.最大血量
	$"HBoxContainer/MarginContainer/装饰血条".value = 属性.血量
	

func _on_血量被改变(old_value, new_value):
	%TextureProgressBar.value = new_value
	%"血量".text = str(new_value) + "/" + str(属性.最大血量)
	高光血量动画(new_value)
	# 如果有其中一方死亡，则退出战斗，并添加经验
	if new_value <= 0:
		emit_signal("死亡")
	

func _on_最大血量被改变(old_value, new_value):
	%TextureProgressBar.max_value = new_value
	$"HBoxContainer/MarginContainer/装饰血条".max_value = new_value
	%"血量".text = str(属性.血量) + "/" + str(new_value)


func 高光血量动画(hp):
	var tween = create_tween()
	tween.tween_property($"HBoxContainer/MarginContainer/装饰血条","value",hp,0.2)
