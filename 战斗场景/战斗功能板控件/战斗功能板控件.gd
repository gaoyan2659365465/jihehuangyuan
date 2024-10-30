extends Control


signal 玩家释放技能(技能)


func 初始化技能(target):
	$"技能板控件".初始化技能(target)


func _on_技能板控件_玩家释放技能(技能: Variant) -> void:
	emit_signal("玩家释放技能",技能)

func 禁用技能(value):
	$"技能板控件".禁用技能(value)
