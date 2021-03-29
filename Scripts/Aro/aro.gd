extends RigidBody2D

var redorblue = 0 #0 red, 1 blue
var colwithh = false #coliciono con grupo h
var hredorblue = 0 #1red 2blue
var x = 1
var i = 1

func _ready():
	if Glovar.VolumeFX == true:
		$SFX/movewater.play()
	$timetokill.start()
	position = Glovar.PathFollowpos
func _process(delta):
	x = x * delta
	if colwithh == true:
		if Glovar.accion == 1 and hredorblue == 2:
			Glovar.htimerblue = false
			gravity_scale = -5
			$timetoup.start()
		elif Glovar.accion == 2 and hredorblue == 1:
			Glovar.htimerred = false
			gravity_scale = -5
			$timetoup.start()
func _on_VisibilityNotifier2D_screen_exited(): #Si Sale de La Pantalla
	
	_killaro() # Eliminar

func _on_timeqf_timeout(): #Timer para ELIMINAR Y SUMAR PUNTAJE
	if redorblue == 1: #Si es Azul
		if Glovar.VolumeFX == true:
			$SFX/play.play()
		Glovar.ScoreBlue = Glovar.ScoreBlue + 1 # Sumarle un punto al azul
		_killaro() #y eliminar
	elif redorblue == 0: # si choco con Rojo
		if Glovar.VolumeFX == true:
			$SFX/play.play()
		Glovar.ScoreRed = Glovar.ScoreRed + 1 #Sumarle al rojo
		_killaro() # Eliminar

func _on_timetoup_timeout():
	gravity_scale = 1

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("exit"):
		gravity_scale = -3
	else:
		i = 1
	if area.is_in_group("exit2"):
		gravity_scale = 1
	else:
		i= 1
	if area.is_in_group("killarea"):
		_killaro()
	elif area.is_in_group("help"):
		gravity_scale = -0.5
	else:
		return


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):# Si choca con un cuerpo
	if body.is_in_group("h"): #si esta para tirar
		if Glovar.VolumeFX == true:
			$SFX/toc.play()
		else:
			i = 1
		colwithh = true
		if body.is_in_group("blue"): # y si es azul
			hredorblue = 2 # cocho con el azul
		elif body.is_in_group("red"): #pero si es rojo
			hredorblue = 1 #choco con el rojo
		else:
			i = 1
	else:
		i = 1
	if body.is_in_group("pa"):
		if Glovar.VolumeFX == true:
			$SFX/toc.play()
	else:
		i=1
func _on_Area2D_body_exited(body): # si dejo de chocar con un cuerpo
	if body.is_in_group("h"): #si no esta para tirar
		colwithh = true
		hredorblue = 0




func _on_timetokill_timeout():
	_killaro()


func _killaro():
	$killanim.current_animation = ("kill")
func _on_killanim_animation_finished(anim_name):
	queue_free()


func _on_Area2D_area_exited(area):
	if area.is_in_group("help"):
		gravity_scale = -0.01

func _on_areap_body_entered(body):
	if body.is_in_group("pa"): # Si el cuerpo es la cosa pa' meter argolla
		if Glovar.VolumeFX == true:
			$SFX/toc.play()
		if body.is_in_group("bluepa"): # y si es azul
			redorblue = 1 # cocho con el azul
		elif body.is_in_group("redpa"): #pero si es rojo
			redorblue = 0 #choco con el rojo
		$timeqf.start() #Iniciar Timer para ELIMINAR Y SUMAR PUNTAJE
	else:
		i = 1


func _on_areap_body_exited(body):	
	if body.is_in_group("pa"): # y ese cuerpo es uno para meter argollas
		redorblue = 3 # cancelar timer
