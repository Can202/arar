extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fondomove = false
var visibleforthefirsttime = false
var whatbutton = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	$animate.current_animation = "anim"
	$Choose.position.x = 0
	whatbutton = "1m"
	if Glovar.VolumeMusic == true:
		$music.play()
	$black.show()
	$black/start.current_animation = "anim"


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
func _on_1m_pressed():
	Glovar.scoreormin = true
	Glovar.smn = 60
	_eend()
func _on_5m_pressed():
	Glovar.scoreormin = true
	Glovar.smn = 300
	_eend()

func _eend():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	$black/end.current_animation = "anim"


func _on_end_animation_finished(anim_name):
	get_tree().change_scene("res://Escenas/Juego.tscn")


func _on_5s_pressed():
	Glovar.scoreormin = false
	Glovar.smn = 5
	_eend()


func _on_15s_pressed():
	Glovar.scoreormin = false
	Glovar.smn = 15
	_eend()


func _on_back_pressed():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	$black/end2.current_animation = "anim"


func _on_end2_animation_finished(anim_name):
	get_tree().change_scene("res://Escenas/Menus/MenuPrincipal.tscn")



#Choose

func _on_left_pressed():
	if whatbutton == "1m":
		$ModeChoose/choosean.current_animation = "15s byL"
	elif whatbutton == "5m":
		$ModeChoose/choosean.current_animation = "1m byL"
	elif whatbutton == "5s":
		$ModeChoose/choosean.current_animation = "5m byL"
	elif whatbutton == "15s":
		$ModeChoose/choosean.current_animation = "5s byL"
	else:
		$ModeChoose/choosean.current_animation = "1m byL"


func _on_right_pressed():
	if whatbutton == "1m":
		$ModeChoose/choosean.current_animation = "5m byR"
	elif whatbutton == "5m":
		$ModeChoose/choosean.current_animation = "5s byR"
	elif whatbutton == "5s":
		$ModeChoose/choosean.current_animation = "15s byR"
	elif whatbutton == "15s":
		$ModeChoose/choosean.current_animation = "1m byR"
	else:
		$ModeChoose/choosean.current_animation = "1m byR"

func _on_1m_screen_entered():
	whatbutton = "1m"
func _on_5m_screen_entered():
	whatbutton = "5m"
func _on_5s_screen_entered():
	whatbutton = "5s"
func _on_15s_screen_entered():
	whatbutton = "15s"
