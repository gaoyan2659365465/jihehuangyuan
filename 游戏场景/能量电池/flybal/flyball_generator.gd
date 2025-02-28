class_name FlyballGenerator extends Node2D

# 飞球生成器

# 追踪目标
@export var target: Node2D = null

# 剩余数量
@export var surplus:int = 20
var flyball_class = preload("res://游戏场景/能量电池/flybal/flyball.tscn")

# 创建飞球
func createFlyBall():
	for i in randi_range(2,5):
		var flyball = flyball_class.instantiate()
		self.add_child(flyball)
		flyball.setTarget(target)
