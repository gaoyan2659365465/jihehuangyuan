class_name PlayerSave extends Resource


"""
玩家存档

使用规范，这样数据一旦被更改，其他绑定此信号的地方就能被通知
signal set_hp
@export var hp = 100:
	set(value):
		hp = value
		set_hp.emit()
"""


# 告示牌是否被点击
@export var 告示牌被点击 = []

# 如果是第一次进入战斗，需要创建引导
@export var 第一次进入战斗 = true

@export var 第一次进入对话 = true

# 存储玩家死掉变成的灯的位置
@export var 死掉灯 = []


@export var 等级 = 1

signal 设置可分配经验(old,new)
@export var 可分配经验 = 100:
	set(value):
		设置可分配经验.emit(可分配经验,value)
		可分配经验 = value
		
@export var 经验条 = 0

signal 设置跳跃
@export var 跳跃 = false:
	set(value):
		跳跃 = value
		设置跳跃.emit()
signal 设置二段跳
@export var 二段跳 = false:
	set(value):
		二段跳 = value
		设置二段跳.emit()

signal 设置黑暗抗性一级
@export var 黑暗抗性一级 = false:
	set(value):
		黑暗抗性一级 = value
		设置黑暗抗性一级.emit()
signal 设置黑暗抗性二级
@export var 黑暗抗性二级 = false:
	set(value):
		黑暗抗性二级 = value
		设置黑暗抗性二级.emit()

signal 设置背景装饰红色眼睛
@export var 背景装饰红色眼睛 = false:
	set(value):
		背景装饰红色眼睛 = value
		设置背景装饰红色眼睛.emit()
