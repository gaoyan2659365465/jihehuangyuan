extends Ability


signal 最大使用次数被改变(old_value, new_value)
var 最大使用次数 = 5:
	set(v):
		最大使用次数被改变.emit(最大使用次数,v)
		最大使用次数 = v

signal 当前剩余次数被改变(old_value, new_value)
var 当前剩余次数 = 5:
	set(v):
		当前剩余次数被改变.emit(当前剩余次数,v)
		当前剩余次数 = v


var 技能名字:String = "光之惩戒"
# 仅仅用于UI显示
var 威力:int = 45


func _init(_obj) -> void:
	super._init(_obj)
	# 技能标签
	self.tag = ["攻击","光之惩戒"]


# 运行技能
func activate_ability():
	super.activate_ability()
	if 当前剩余次数 > 0:
		当前剩余次数 -= 1
		攻击()

# 结束技能
func remove_ability():
	super.remove_ability()


# 获取敌方目标，如果是敌人释放的技能则目标是玩家
func get_traget():
	var wj = Global.战斗场景.玩家
	var dr = Global.战斗场景.敌人
	if self.obj == wj.ability_system:
		return dr.ability_system
	else:
		return wj.ability_system

# 找到攻击目标，并在对方的技能组件中添加伤害GE
func 攻击():
	# 如果命中敌人，就在敌人身上的ability_system中加入“造成伤害”的effect
	self.obj.apply_effect_to_target("res://战斗场景/技能系统/光之惩戒/GE_光之惩戒.gd", get_traget(),self.obj)
