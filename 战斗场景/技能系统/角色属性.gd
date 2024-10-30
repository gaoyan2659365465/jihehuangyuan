class_name 角色属性 extends Resource

# 基础数值层
signal 血量被改变(old_value, new_value)
@export var 血量 = 100:
	set(v):
		if v < 0:
			v = 0
		血量被改变.emit(血量,v)
		血量 = v
		

signal 最大血量被改变
@export var 最大血量 = 100:
	set(v):
		最大血量 = v
		最大血量被改变.emit()

@export var 攻击 = 100
@export var 防御 = 100

# 防御*0.5， 攻击*1.0  因为是减法公式，所以需要攻击比防御大一点，否则会出现减0的情况
@export var 等级 = 1:
	set(value):
		等级 = value
		最大血量 = 100+等级*10
		血量 = 最大血量
		攻击 = 等级*1.0*攻击修正系数
		防御 = 等级*0.5*防御修正系数


# 整体控制所有等级的攻击防御
@export var 攻击修正系数 = 2.0
@export var 防御修正系数 = 1.0
