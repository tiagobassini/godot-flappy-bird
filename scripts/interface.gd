extends CanvasLayer


signal start_game

onready var button_pressed: Control = get_node("ButtonContainer")

onready var animation: AnimationPlayer = get_node("Animation")
onready var score_container: Control = get_node("ScoreContainer")
onready var button_container: Control = get_node("MessageContainer")

var score: int = 0

export(PackedScene) var sfx_scene


func _ready() -> void:
	animation.play("fade_out")
	for button in button_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Message":
			button_container.get_node("Message").hide()
			score_container.show()
			button_pressed.show()
			emit_signal("start_game")
		"GameOver":
			animation.play("fade_in")
			yield(get_tree().create_timer(1.0), "timeout")
			var _reload = get_tree().reload_current_scene()
			

func update_score() -> void:
	score +=1
	spawn_sfx("res://assets/sfx/point.ogg")
	score_container.get_node("Text").text = str(score)
	
func game_over() -> void :
	button_pressed.hide()
	button_container.get_node("GameOver").show()


func spawn_sfx(effect: String) -> void:
	var sfx: SoundEffect = sfx_scene.instance() 
	sfx.stream = load(effect)
	get_tree().root.call_deferred("add_child", sfx)
