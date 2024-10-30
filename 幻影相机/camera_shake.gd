extends Camera2D


var time = 0 # 时间
var length = 10 # 总长度
var time_add = 1 # 时间累加值
var shake_range = 5 #抖动范围
var freq = 0.01 # 抖动频率

func _ready():
	pass

# 屏幕震动函数
func shake_screen():
	var cameraPos = Vector2(0,0)
	while time < length:
		time += time_add
		
		var offset = Vector2()
		offset.x = randf_range(-shake_range,shake_range)
		offset.y = randf_range(-shake_range,shake_range)
		
		var newPos = cameraPos
		newPos += offset
		
		self.offset = newPos
		print(self.offset)
		await get_tree().create_timer(freq).timeout
		
	self.offset = Vector2(0,0)
	time = 0

# UI震动函数
func shake_UI(target:Control):
	var cameraPos = Vector2(0,0)
	while time < length:
		time += time_add
		
		var offset = Vector2()
		offset.x = randf_range(-shake_range,shake_range)
		offset.y = randf_range(-shake_range,shake_range)
		
		var newPos = cameraPos
		newPos += offset
		
		target.position = newPos
		await get_tree().create_timer(freq).timeout
		
	target.position = Vector2(0,0)
	time = 0
