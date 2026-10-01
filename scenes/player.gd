extends CharacterBody3D

# ===== 移动数值：全部是 Prototype 测试值，最终值 TBD =====
@export var walk_speed: float = 5.0
@export var run_speed: float = 9.0
@export var auto_run_delay: float = 0.4           # 按住方向多久自动 Run（测试范围 0.35～0.45）
@export var double_tap_window: float = 0.25       # 双击判定时间（测试值）
@export var controller_run_threshold: float = 0.75 # 摇杆推多大进入 Run

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var sprite: Sprite3D = $Sprite

var facing_right: bool = true
var is_running: bool = false
var move_hold_time: float = 0.0
var using_controller: bool = false

# 双击检测用：上一次按下的方向键、按下的时间
var last_tap_action: StringName = &""
var last_tap_time: float = -10.0

const MOVE_ACTIONS: Array[StringName] = [&"move_left", &"move_right", &"move_up", &"move_down"]


# 判断玩家现在用的是键盘还是手柄
func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion and abs(event.axis_value) > 0.2:
		using_controller = true
	elif event is InputEventJoypadButton:
		using_controller = true
	elif event is InputEventKey or event is InputEventMouseButton:
		using_controller = false


func _physics_process(delta: float) -> void:
	# 1. 重力
	if not is_on_floor():
		velocity.y -= gravity * delta

	# 2. 读取方向输入
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# 3. 判断现在是 Walk 还是 Run
	_update_run_state(input_dir, delta)

	# 4. 按 Walk / Run 速度移动
	var move_dir := input_dir.normalized()
	var speed := run_speed if is_running else walk_speed
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.y * speed
	move_and_slide()

	# 5. 朝向
	if input_dir.x > 0:
		facing_right = true
	elif input_dir.x < 0:
		facing_right = false
	sprite.flip_h = not facing_right

	# 6. 【测试用】Run 时角色变红，方便确认状态。以后会删掉
	sprite.modulate = Color(1.0, 0.6, 0.6) if is_running else Color.WHITE


func _update_run_state(input_dir: Vector2, delta: float) -> void:
	# 没有方向输入：停止 Run，计时清零
	if input_dir == Vector2.ZERO:
		is_running = false
		move_hold_time = 0.0
		return

	# 手柄：看摇杆推的幅度
	if using_controller:
		is_running = input_dir.length() >= controller_run_threshold
		return

	# 键盘 A：按住一段时间后自动 Run
	move_hold_time += delta
	if move_hold_time >= auto_run_delay:
		is_running = true

	# 键盘 B：快速双击同一个方向键，立即 Run
	var now := Time.get_ticks_msec() / 1000.0
	for action in MOVE_ACTIONS:
		if Input.is_action_just_pressed(action):
			if action == last_tap_action and now - last_tap_time <= double_tap_window:
				is_running = true
			last_tap_action = action
			last_tap_time = now
