extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_cutscene(cutscene_name: String):
	animation_player.play(cutscene_name)
