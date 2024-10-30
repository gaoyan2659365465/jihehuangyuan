class_name GC_光之惩戒 extends Cue


static func _get_tag():
	return ["伤害数字_光之惩戒"]

# GE创建时被调用
func _ready() -> void:
	self.get_parent().ability_system.attribute.血量被改变.connect(_on_血量被改变)
	生成激光特效()
	
# GE激活时被调用
func process_cue():
	pass
# GE销毁时被调用
func end_cue():
	queue_free()

func 生成伤害数字(value):
	var harm_label = preload("res://战斗场景/伤害数字/harm_label.tscn").instantiate()
	Global.umg.add_child(harm_label)
	var tran = self.get_canvas_transform()
	harm_label.position = tran * (self.global_position + Vector2(0,-100))
	harm_label.set_text("-"+str(value))
	harm_label.颜色 = Color(1, 1, 1)
	harm_label.playAnim()

func 生成激光特效():
	var jg = preload("res://战斗场景/技能系统/光之惩戒/激光特效/激光特效.tscn").instantiate()
	Global.战斗场景.添加特效(jg,Vector2(299,339))
	


func _on_血量被改变(old_value, new_value):
	生成伤害数字(old_value - new_value)
