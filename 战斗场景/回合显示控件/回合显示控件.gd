extends Control


var 回合数:int = 1

func 回合加一():
	回合数 += 1
	$Panel/Label2.text = str(回合数)
