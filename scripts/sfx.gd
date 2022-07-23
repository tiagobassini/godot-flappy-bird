extends AudioStreamPlayer

class_name SoundEffect


func _ready():
	play()



func on_sfx_finished():
	queue_free()
