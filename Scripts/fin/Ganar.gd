extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fondomove = false
var backorexit = false # false back, exit true
var speedpressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Glovar.VolumeMusic == true:
		$music.play()
	$Canvas/black.show()
	Glovar.Score = Glovar.ScoreBlue + Glovar.ScoreRed
	Glovar.ScoreMega += Glovar.Score
	
	#Guardar
	var data = $NG/Guardar.get_data()
	data["Score"] = Glovar.ScoreMega
	if Glovar.VolumeMusic == true:
		Glovar.Volumesavebug01.x = 1
	else:
		Glovar.Volumesavebug01.x = 0
	if Glovar.VolumeFX == true:
		Glovar.Volumesavebug01.y = 1
	else:
		Glovar.Volumesavebug01.y = 0
	data["VolumeMusic"] = Glovar.Volumesavebug01.x
	data["VolumeFx"] = Glovar.Volumesavebug01.y
	$NG/Guardar.save_data()
	#Fin
	
	
	$Control/buttons/SR.text = str(Glovar.ScoreRed)
	$Control/buttons/SB.text = str(Glovar.ScoreBlue)
	$Control/ScoreTotal.text = str(Glovar.Score)
	$Control/ScoreRed.text = str(Glovar.ScoreRed)
	$Control/ScoreBlue.text = str(Glovar.ScoreBlue)
	if Glovar.win == 1:
		$Control/Title/blue.hide()
		$Control/Title/tie.hide()
	elif Glovar.win == 2:
		$Control/Title/red.hide()
		$Control/Title/tie.hide()
	else:
		$Control/Title/blue.hide()
		$Control/Title/red.hide()
		$Control/Title/YouWin.hide()
	$start.current_animation = "anim"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Glovar.VolumeFX == true:
		if $start.current_animation_position >= 1.5 and $start.current_animation_position <= 1.53:
			$SFX/suash.play()
		if $start.current_animation_position >= 3 and $start.current_animation_position <= 3.1:
			$SFX/suash.play()
		if $start.current_animation_position >= 4.5 and $start.current_animation_position <= 4.53:
			$SFX/suash.play()
		if $start.current_animation_position >= 5.7 and $start.current_animation_position <= 5.73:
			$SFX/suash.play()
	
	
	if speedpressed == true:
		$start.playback_speed = 9
	else:
		$start.playback_speed = 2
	
	if $fondo.position.x >= 1000:
		fondomove = false
	elif $fondo.position.x <= -480:
		fondomove = true
	if fondomove == false:
		$fondo.position.x -= 50 * delta
	elif fondomove == true:
		$fondo.position.x += 50 * delta



func _on_back_pressed():
	$SFX/touch.play()
	$Canvas/black/end.current_animation = "anim"
	backorexit = false
func _on_exit_pressed():
	$SFX/touch.play()
	$Canvas/black/end.current_animation = "anim"
	backorexit = true
func _on_end_animation_finished(anim_name):
	if backorexit == false:
		Glovar.Score = 0
		Glovar.ScoreBlue = 0
		Glovar.ScoreRed = 0
		Glovar.accion = 0
		get_tree().change_scene("res://Escenas/Juego.tscn")
	if backorexit == true:
		get_tree().change_scene("res://Escenas/Menus/MenuPrincipal.tscn")


func _on_speed_pressed():
	speedpressed = true
func _on_speed_released():
	speedpressed = false
