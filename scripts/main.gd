extends Node2D


onready var bird: KinematicBody2D = get_node("Bird")
onready var parallax_background: ParallaxBackground = get_node("ParallaxBackground")
onready var interface: CanvasLayer = get_node("Interface")
onready var pipe_spawner: Position2D = parallax_background.get_node("PipeSpawner")




func _ready() -> void:
	var _start = interface.connect("start_game", self, "start_game")
	var _game_over = bird.connect("game_over", self, "game_over")


func start_game() -> void:
	bird.start()
	pipe_spawner.spawn()

func game_over() -> void:
	interface.game_over()
	parallax_background.game_over()
	pipe_spawner.game_over()
