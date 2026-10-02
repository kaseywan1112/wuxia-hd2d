extends Node3D

# ===== 测试用：一直左右移动的球，用来观察子弹时间 =====
@export var move_speed: float = 3.0   # 移动速度
@export var move_range: float = 4.0   # 从起点往左右各走多远

var start_x: float = 0.0
var direction: float = 1.0


func _ready() -> void:
	start_x = position.x


func _physics_process(delta: float) -> void:
	# 子弹时间中会变慢
	var d := delta * BulletTime.get_enemy_scale()
	position.x += direction * move_speed * d

	if position.x > start_x + move_range:
		position.x = start_x + move_range
		direction = -1.0
	elif position.x < start_x - move_range:
		position.x = start_x - move_range
		direction = 1.0
