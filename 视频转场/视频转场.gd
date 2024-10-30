extends Control


@onready var video: VideoStreamPlayer = $VideoStreamPlayer


# 这两个视频是需要对接到一起放的
func 进入战斗转场Start():
	video.stream = preload("res://视频转场/素材/转场5.ogv")
	video.play()
	await get_tree().create_timer(1.0).timeout
	$"纯白色背景".visible = true
func 进入战斗转场End():
	video.stream = preload("res://视频转场/素材/转场6.ogv")
	video.play()
	$"纯白色背景".visible = false

func 进入场景转场Start():
	video.stream = preload("res://视频转场/素材/转场7.ogv")
	video.play()
	await get_tree().create_timer(1.5).timeout
	$"纯白色背景".visible = true
	await video.finished

func 进入场景转场End():
	video.stream = preload("res://视频转场/素材/转场8.ogv")
	video.play()

func 进入游戏转场():
	video.stream = preload("res://视频转场/素材/转场视频.ogv")
	video.play()
