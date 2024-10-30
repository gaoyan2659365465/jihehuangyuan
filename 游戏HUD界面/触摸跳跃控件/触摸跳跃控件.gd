extends Control






func _process(delta: float) -> void:
	var 游戏hud界面 = Global.umg.get_child(0)
	if not 游戏hud界面:
		return
	var rect = 游戏hud界面.跳跃.get_rect()
	var tran = get_canvas_transform()
	var new_pos = rect.position * tran
	
	position = new_pos
	size = 游戏hud界面.跳跃.size


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			Input.action_release("ui_accept")
			Input.action_press("ui_accept")
