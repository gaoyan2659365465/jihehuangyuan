class_name Player extends CharacterBody2D


@onready var player_sprite: Sprite2D = %PlayerSprite


enum MoveMode{
	NONE,# 无法移动
	MOVE,# 仅移动
	JUMP,# 移动+跳跃
	DOUBLE_JUMP,# 移动+二段跳
}

@export var move_mode:MoveMode = MoveMode.NONE:
	set(value):
		self.updateMoveMode(move_mode,value)
		move_mode = value


# 重力
@export var gravity: int = 1500
# 移动速度
@export var SPEED = 350.0
# 跳跃高度
@export var JUMP_VELOCITY = -700.0


# 二段跳记录
var double_jump = 0:
	set(value):
		double_jump = value
		if double_jump == 1:
			$AudioStreamPlayer.pitch_scale = randf_range(1.0,1.2)
			$AudioStreamPlayer.play()
			var tween = create_tween()
			%PlayerSprite.rotation_degrees = 0
			tween.tween_property(%PlayerSprite,"rotation_degrees",5,0.15).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(%PlayerSprite,"rotation_degrees",-5,0.15).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(%PlayerSprite,"rotation_degrees",0,0.15).set_ease(Tween.EASE_IN_OUT)
		if double_jump == 2:
			$AudioStreamPlayer.pitch_scale = randf_range(1.0,1.2)
			$AudioStreamPlayer.play()
			var tween = create_tween()
			tween.tween_property(%PlayerSprite,"rotation_degrees",0,0.15).set_ease(Tween.EASE_IN_OUT)
			tween.tween_property(%PlayerSprite,"rotation_degrees",%PlayerSprite.rotation_degrees + 120,0.3).set_ease(Tween.EASE_IN_OUT)
			

func updateMoveMode(old_state,new_state):
	if new_state == MoveMode.NONE:
		pass
	elif new_state == MoveMode.MOVE:
		pass
	elif new_state == MoveMode.JUMP:
		pass
	elif new_state == MoveMode.DOUBLE_JUMP:
		pass

func _physics_process(delta: float) -> void:
	if self.move_mode == MoveMode.NONE:
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	if self.move_mode == MoveMode.JUMP:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	if self.move_mode == MoveMode.DOUBLE_JUMP:
		if is_on_floor():
			self.double_jump = 0
		if Input.is_action_just_pressed("ui_accept"):
			if self.double_jump <= 1:
				velocity.y = JUMP_VELOCITY
				self.double_jump += 1
		

	var input_dir: = Input.get_axis("ui_left","ui_right")

	if input_dir:
		velocity.x = input_dir * SPEED
		if input_dir > 0:
			player_sprite.set_flip_h(false)
		elif input_dir < 0:
			player_sprite.set_flip_h(false)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_force(-c.get_normal()*1000)


# 进入镜头动画
func play_anim():
	$剧情对话视角.priority = 50

func play_anim2():
	$剧情对话视角.priority = 0

# 进入镜头动画
func play_anim4():
	$"死亡相机视角".priority = 50

func play_anim5():
	$"死亡相机视角".priority = 0

func 死亡变成灯():
	# 禁止移动
	move_mode = MoveMode.NONE
	# 播放升空动画
	$AnimationPlayer.play("能量耗尽死亡")
	await $AnimationPlayer.animation_finished

func 复活():
	# 恢复移动
	初始化移动模式()
	%PlayerSprite.position = Vector2(0,0)
	position = Vector2(-1495,-2291)

func 初始化移动模式():
	move_mode = MoveMode.MOVE
	if Global.player_save.跳跃:
		move_mode = MoveMode.JUMP
	if Global.player_save.二段跳:
		move_mode = MoveMode.DOUBLE_JUMP

func _on_设置跳跃():
	初始化移动模式()
func _on_设置二段跳():
	初始化移动模式()

func _ready() -> void:
	Global.player_save.设置跳跃.connect(_on_设置跳跃)
	Global.player_save.设置二段跳.connect(_on_设置二段跳)
	初始化移动模式()
	
	play_anim3()

# 角色的显示灯光亮度，进入灯光以后倍数变小
var 角色灯光亮度倍数 = 1.0:
	set(value):
		角色灯光亮度倍数 = value
		$"PlayerSprite/角色发光".material.set("shader_parameter/n",角色灯光亮度倍数)
func 设置灯光亮度倍数(value):
	var tween = create_tween()
	tween.tween_property(self,"角色灯光亮度倍数",value,0.5)

# 角色自身灯光明暗动画
func play_anim3():
	var target = $"PlayerSprite/角色发光"
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(target,"material:shader_parameter/color",Color(1.0,1.0,1.0,0.5),2.0)
	tween.tween_property(target,"material:shader_parameter/color",Color(1.0,1.0,1.0,1.0),2.0)
