extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fondomove = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$black/AnimationPlayer.current_animation = "start"
	if Glovar.VolumeMusic == true:
		$music.play()
	$info/score.text = str(Glovar.ScoreMega)


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


func _on_exit_pressed():
	$black/AnimationPlayer.current_animation = "end"


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "end":
		get_tree().change_scene("res://Escenas/Menus/MenuPrincipal.tscn")


func _on_removescore_pressed():
	var data = $NG/Guardar.get_data()
	Glovar.ScoreMega = 0
	data["Score"] = 0
	$NG/Guardar.save_data()
	$info/score.text = str(Glovar.ScoreMega)
	
	
