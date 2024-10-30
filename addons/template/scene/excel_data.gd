class_name ExcelData extends Node

"""
# 获取数据
self.json.data['数据表名']
"""

# 用于加载Json数据
var json = preload("res://游戏HUD界面/对话气泡/数据表/游戏数据表.json")
var 对话数据 = self.json.data['对话数据']



func _ready() -> void:
	pass

func 获取对话(告示牌名 = "告示牌1"):
	var 对话数组 = []
	if 告示牌名 == "":
		return 对话数组
	
	for key in self.对话数据:
		var 对话 = self.对话数据[key][告示牌名]
		if 对话 != "":
			对话数组.append(对话)
		else:
			return 对话数组
