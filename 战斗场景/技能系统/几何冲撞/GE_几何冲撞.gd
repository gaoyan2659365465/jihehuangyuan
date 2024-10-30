extends Effect


func _get_cue_tag():
	return ["伤害数字"]

# 对宿主身上的角色属性数据进行修改
# 在AbilitySystem组件中进行生命周期管理并调用
func run_effect():
	super.run_effect()
	var 伤害 = randi_range(25,35) + self.instigator.attribute.攻击 - self.target.attribute.防御
	伤害 = int(伤害)
	if 伤害 <= 0:
		self.target.attribute.血量 -= 0
	else:
		self.target.attribute.血量 -= 伤害
