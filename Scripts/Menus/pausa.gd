extends Node2D

func _ready():
	$back.hide()
	if Glovar.VolumeFX == false:
		$back/FX/x.show()

#func _process(delta):
#	pass


func _on_Pause_pressed():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	if get_tree().paused == false:
		get_tree().paused = true
		$back.show()
	else:
		get_tree().paused = false
		$back.hide()


func _on_MainMenu_pressed():
	Glovar.Exit = true
	Glovar.soundinpause = true
	get_tree().paused = false
	get_tree().change_scene("res://Escenas/Menus/MenuPrincipal.tscn")


func _on_Restart_pressed():
	Glovar.soundinpause = true
	get_tree().paused = false
	Glovar.Score = 0
	Glovar.ScoreBlue = 0
	Glovar.ScoreRed = 0
	Glovar.accion = 0
	get_tree().change_scene("res://Escenas/Juego.tscn")


func _on_FX_pressed():
	if Glovar.VolumeFX == false:
		$back/FX/x.hide()
		Glovar.VolumeFX = true
	elif Glovar.VolumeFX == true:
		$back/FX/x.show()
		Glovar.VolumeFX = false
