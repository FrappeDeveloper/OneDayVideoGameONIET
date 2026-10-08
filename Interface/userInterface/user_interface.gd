extends CanvasLayer

@onready var bullets_count: Label = $"Bullets Count"
@onready var timer: Timer = $Timer
@onready var delay: ColorRect = $delay


var player

func _ready() -> void:
	player=get_tree().get_first_node_in_group("Player")
	player.timer=timer

func _process(delta: float) -> void:
	if timer.time_left:
		delay.scale.y=timer.time_left/timer.wait_time

func _input(event: InputEvent) -> void:
	if GameManager.current_weapond!=null:
		if GameManager.current_weapond.kind=="Gun" and GameManager.current_weapond.bullets!=0:
			bullets_count.text=str(GameManager.current_weapond.bullets)
		else:
			bullets_count.text=""
	else:
		bullets_count.text=""
