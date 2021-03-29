extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fondomove = false
var Open = false
var firstsave = false
var datacom = {}
var infos = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	#Cargar y Guardar DAta
	var data = $NG/Guardar.get_data()
	if Glovar.Exit == true:
		Glovar.Score = Glovar.ScoreBlue + Glovar.ScoreRed
		Glovar.ScoreMega += Glovar.Score
		data["Score"] = Glovar.ScoreMega
		$NG/Guardar.save_data()
		
	if data.empty():
		pass
	else:
		Glovar.ScoreMega = data["Score"]
	
	#Fin
	if Glovar.soundinpause == true and Glovar.VolumeFX == true:
		$SFX/touch.play()
		Glovar.soundinpause = false
	$canvas/black.show()
	$canvas/black/Animation2.current_animation = "anim"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $fondo.position.x >= 1000:
		fondomove = false
	elif $fondo.position.x <= -480:
		fondomove = true
	if fondomove == false:
		$fondo.position.x -= 50 * delta
	elif fondomove == true:
		$fondo.position.x += 50 * delta
func _on_TouchScreenButton_pressed():
	if Open == true:
		if Glovar.VolumeFX == true:
			$SFX/play.play()
		Open = false
		$canvas/black/Animation.current_animation = ("anim")
		Glovar.Score = 0
		Glovar.ScoreBlue = 0
		Glovar.ScoreRed = 0
		Glovar.accion = 0
func _on_Animation_animation_finished(anim_name):
	get_tree().change_scene("res://Escenas/Menus/MenuModeGame.tscn")


func _on_exit_pressed():
	get_tree().quit()


func _on_Animation2_animation_finished(anim_name):
	Open = true
	if Glovar.VolumeMusic == true:
		$Music/Music.volume_db = 0
	else:
		$Music/Music.volume_db = -80
	$Music/Music.play()
	$Play/Animation.current_animation = "anim"
	$Arar/Animation.current_animation = "megacolor"


func _on_Music_finished():
	$Music/Music.play()


func _on_info_pressed():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	$canvas/black/Animation3.current_animation = "anim"
	infos = 1


func _on_Animation3_animation_finished(anim_name):
	if infos == 1:
		infos = 0
		get_tree().change_scene("res://Escenas/info.tscn")
	elif infos == 2:
		infos = 0
		get_tree().change_scene("res://Escenas/Menus/MenuScore.tscn")
	else:
		infos = 0
	
	
	




func _on_info2_pressed():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	$canvas/black/Animation3.current_animation = "anim"
	infos = 2
