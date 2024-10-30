@tool
class_name MessagePanel extends Control


@onready var label = $Backdrop/Label
@onready var backdrop = $Backdrop


@export var text = "通用消息框，创建时动态修改":
	set(value):
		text = value
		$Backdrop/Label.text = text


# UI从下到上逐渐显示
func playAnim3(target):
	var tween = create_tween()
	tween.set_parallel(true)
	var x = target.position.x
	var y = target.position.y
	target.set("position",Vector2(x,y+70))
	target.set("modulate",Color(1.0,1.0,1.0,0.0))
	
	tween.tween_property(target,"position",Vector2(x,y),0.2).set_delay(0.2)
	tween.tween_property(target,"modulate",Color(1.0,1.0,1.0,1.0),0.2)

# UI从下到上逐渐消失
func playAnim4(target):
	var tween = create_tween()
	tween.set_parallel(true)
	var x = target.position.x
	var y = target.position.y
	
	tween.tween_property(target,"position",Vector2(x,y-70),0.2)
	tween.tween_property(target,"modulate",Color(1.0,1.0,1.0,0.0),0.2)

func _ready():
	# 编辑器下不运行动画
	if not Engine.is_editor_hint():
		# UI从下到上逐渐显示
		playAnim3(backdrop)
		await get_tree().create_timer(1.0).timeout
		# UI从下到上逐渐消失
		playAnim4(backdrop)
		await get_tree().create_timer(1.0).timeout
		queue_free()
