extends Control

signal 玩家释放技能(技能)


func _ready() -> void:
	if Global.player_save.等级 >= 2:
		$"HBoxContainer/技能子控件2".visible = true

func 初始化技能(target):
	var i:Ability = target.ability_system.ga_list[0]
	var i2:Ability = target.ability_system.ga_list[1]
	$"HBoxContainer/技能子控件".初始化技能(i)
	$"HBoxContainer/技能子控件2".初始化技能(i2)
	$"HBoxContainer/技能子控件3".初始化技能(i)
	$"HBoxContainer/技能子控件4".初始化技能(i)


func _on_技能子控件_点击释放技能(技能引用: Variant) -> void:
	emit_signal("玩家释放技能",技能引用)

func 禁用技能(value):
	$"HBoxContainer/技能子控件".禁用技能(value)
	$"HBoxContainer/技能子控件2".禁用技能(value)
	$"HBoxContainer/技能子控件3".禁用技能(value)
	$"HBoxContainer/技能子控件4".禁用技能(value)
