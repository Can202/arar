extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fondomove = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CL/black.show()
	$CL/black/start.current_animation = "anim"
	if Glovar.VolumeMusic == true:
		$music.play()


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


func _on_music_finished():
	$music.play()


func _on_back_pressed():
	if Glovar.VolumeFX == true:
		$SFX/touch.play()
	$CL/black/end.current_animation = "anim"


func _on_end_animation_finished(anim_name):
	get_tree().change_scene("res://Escenas/Menus/MenuPrincipal.tscn")
