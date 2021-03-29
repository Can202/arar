extends Node2D



export (PackedScene) var aro #este es el noseque
var fondomove = false #false left, true right
var timeistrue = false
var time = 0
var timeend = false
func _ready():
	if Glovar.soundinpause == true and Glovar.VolumeFX == true:
		$SFX/touch.play()
		Glovar.soundinpause = false
	if Glovar.scoreormin == true:
		timeistrue = true
		if Glovar.smn == 60:
			$Time.wait_time = 60
		elif Glovar.smn == 300:
			$Time.wait_time = 300
		else:
			$Time.wait_time = 60
		$Time.start()
	if Glovar.VolumeMusic == true:
		$Music/Music.volume_db = 0
	else:
		$Music/Music.volume_db = -80
	$Music/Music.play()
	$Canvas2/black.show()
	$Canvas2/black/Animation.current_animation = ("anim")
	randomize()
	$Path2D/timetospawn.start()
	$fondo.position.x = 1376
	if $Music/Music.volume_db == -80:
		$Canvas/pausa/back/Music/x.show()


func _process(delta):
	#if Glovar.accion == 1: #azul
	#	$blueh/AnimatedSprite.animation = "click"
	#else:
	$blueh/AnimatedSprite.animation = "normal"
	#if Glovar.accion == 2: #rojo
	#	$redh/AnimatedSprite.animation = "click"
	#else:
	$redh/AnimatedSprite.animation = "normal"
	
	
	if Glovar.scoreormin == true and timeend == true:
		if Glovar.ScoreRed > Glovar.ScoreBlue:
			Glovar.win = 1 
			$Canvas2/black/Animation2.current_animation = "anim"
		elif Glovar. ScoreRed < Glovar.ScoreBlue:
			Glovar.win = 2
			$Canvas2/black/Animation2.current_animation = "anim"
		else:
			Glovar.win = 0
			$Canvas2/black/Animation2.current_animation = "anim"
	if Glovar.scoreormin == false:
		if Glovar.ScoreRed >= Glovar.smn:
			Glovar.win = 1 
			$Canvas2/black/Animation2.current_animation = "anim"
		if Glovar.ScoreBlue >= Glovar.smn:
			Glovar.win = 2 
			$Canvas2/black/Animation2.current_animation = "anim"
		if Glovar.ScoreRed == Glovar.ScoreBlue and Glovar.ScoreRed >= Glovar.smn:
			Glovar.win = 0
			$Canvas2/black/Animation2.current_animation = "anim"
	time = int($Time.time_left)
	
	if timeistrue == true:
		$Control/timeorscore.set_text(str(time))
	elif timeistrue == false:
		$Control/timeorscore.set_text(str(Glovar.smn))


	if Input.is_action_pressed("ua"):
		$redbutton.emit_signal("pressed")
	elif Input.is_action_pressed("ud"):
		$bluebutton.emit_signal("pressed")
	if $fondo.position.x >= 1375:
		fondomove = false
	elif $fondo.position.x <= -800:
		fondomove = true
	if fondomove == false:
		$fondo.position.x -= 50 * delta
	elif fondomove == true:
		$fondo.position.x += 50 * delta
	$Control/redscore.set_text(str(Glovar.ScoreRed))
	$Control/bluescore.set_text(str(Glovar.ScoreBlue))
	#Glovar.PathFollowpos = $Path2D/PathFollow2D.position


func _on_bluebutton_pressed():
	if Glovar.VolumeFX == true:
		$SFX/button.play()
	Glovar.accion = 1
	$htimerblue.start()


func _on_redbutton_pressed():
	if Glovar.VolumeFX == true:
		$SFX/button.play()
	$htimerred.start()
	Glovar.accion = 2


func _on_htimerblue_timeout():
	Glovar.htimerblue = true


func _on_htimerred_timeout():
	Glovar.htimerred = true


func _on_timetospawn_timeout():
	$Path2D/PathFollow2D.set_offset(randi()) #Al AZAR pero antes randomize() en ready()
	Glovar.PathFollowpos = $Path2D/PathFollow2D.position # le da la informacion a una variable global usada para la posicion inicial de un aro
	var A = aro.instance() # funciona si exportas el no se que que esta arriba
	$aro.add_child(A) # añade el hijo A (aro)
	
	$Path2D/timetospawn.start()


func _on_Music_finished():
	$Music/Music.play()


func _on_Music_pressed():
	if $Music/Music.volume_db == -80:
		$Music/Music.volume_db = 0
		$Canvas/pausa/back/Music/x.hide()
		Glovar.VolumeMusic = true
	else:
		$Music/Music.volume_db = -80
		$Canvas/pausa/back/Music/x.show()
		Glovar.VolumeMusic = false


func _on_Time_timeout():
	timeend = true
	


func _on_Animation2_animation_finished(anim_name):
	get_tree().change_scene("res://Escenas/Fin/Ganar.tscn")
