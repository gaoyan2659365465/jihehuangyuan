class_name 角色 extends Node2D



var 名字:String = "三角形":
	set(value):
		名字 = value
		if 名字 == "光核三角":
			ability_system.attribute.等级 = Global.player_save.等级
		if 名字 == "疯狂三角":
			ability_system.attribute.等级 = 1
		if 名字 == "红女士":
			ability_system.attribute.等级 = 4

var 头像:Texture2D

@onready var ability_system: AbilitySystem = $AbilitySystem


func _ready() -> void:
	
	# 创建一个技能
	ability_system.create_ability("res://战斗场景/技能系统/几何冲撞/GA_几何冲撞.gd")
	ability_system.create_ability("res://战斗场景/技能系统/光之惩戒/GA_光之惩戒.gd")
	
func 攻击动画():
	$AnimationPlayer.play("攻击")
	
func 受击动画():
	$AnimationPlayer.play("受击")
