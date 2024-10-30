class_name Flyball extends Node2D

# 飞球，用于经验值效果

@onready var path_2d: Path2D = $Node/Path2D
@onready var path_follow_2d: PathFollow2D = $Node/Path2D/PathFollow2D
@onready var sprite_2d: Sprite2D = $Sprite2D




# 追踪目标
var target

enum STATE{
	IMPULSION,# 冲力
	TRACE,# 追踪玩家
}

@export var state:STATE = STATE.IMPULSION:
	set(value):
		self.updateState(state,value)
		state = value

# 飞球一开始受到冲击力的落点
var impulsion_pos = Vector2.ZERO


# 设置追踪目标
func setTarget(_target):
	self.target = _target
	self.state = STATE.IMPULSION

# 更新状态
func updateState(old_state,new_state):
	if new_state == STATE.IMPULSION:
		# 初始化RemoteTransform2D位置，防止为0造成拖尾拉伸
		self.path_follow_2d.global_position = global_position
		var offset = Vector2(randf_range(-1,1),randf_range(-1,1))*200
		self.impulsion_pos = global_position+offset
		self.path_2d.curve.clear_points()
		self.path_2d.curve.add_point(global_position)
		self.path_2d.curve.add_point(self.impulsion_pos)
		var tween = create_tween()
		self.path_follow_2d.progress_ratio = 0
		tween.tween_property(self.path_follow_2d,"progress_ratio",1,0.3).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		self.state = STATE.TRACE
		
	elif new_state == STATE.TRACE:
		var _pos = self.impulsion_pos
		self.path_2d.curve.clear_points()
		self.path_2d.curve.add_point(_pos,Vector2.ZERO,_pos-global_position)
		self.path_2d.curve.add_point(target.global_position,(global_position-target.global_position).normalized()*50,Vector2.ZERO)
		var tween = create_tween()
		self.path_follow_2d.progress_ratio = 0
		tween.tween_property(self.path_follow_2d,"progress_ratio",1,0.6).set_ease(Tween.EASE_IN_OUT)
		await tween.finished
		queue_free()
		

func _process(delta: float) -> void:
	if self.state == STATE.TRACE:
		self.path_2d.curve.clear_points()
		self.path_2d.curve.add_point(self.impulsion_pos,Vector2.ZERO,self.impulsion_pos-global_position)
		self.path_2d.curve.add_point(target.global_position,(global_position-target.global_position).normalized()*50,Vector2.ZERO)
	
