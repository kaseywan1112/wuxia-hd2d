extends CharacterBody3D

# ===== 移动数值：Prototype 测试值，最终值 TBD =====
@export var walk_speed: float = 5.0
@export var run_speed: float = 9.0
@export var auto_run_delay: float = 0.4
@export var double_tap_window: float = 0.25
@export var controller_run_threshold: float = 0.75

# ===== Dodge 数值：Prototype 测试值，最终值 TBD =====
@export var dodge_distance: float = 3.0
@export var dodge_duration: float = 0.2
@export var dodge_end_lag: float = 0.3
@export var dodge_invincible_ratio: float = 0.5
@export var max_dodge_charges: int = 2
@export var dodge_recharge_time: float = 0.8
@export var dodge_buffer_time: float = 0.15
@export var perfect_dodge_window: float = 0.2

# ===== 子弹时间：Prototype 测试值，最终值 TBD =====
@export var bt_duration_normal: float = 0.6
@export var bt_duration_special: float = 2.0
@export var bt_extend_per_hit: float = 0.15
@export var bt_enemy_time_scale: float = 0.15
@export var bt_drain_acceleration: float = 0.8
@export var bt_max_remaining: float = 3.0

# ===== 普通攻击 4 段连段：Prototype 测试值，最终值 TBD =====
# 每个数组的 4 个数字 = 第 1 / 2 / 3 / 4 段
@export var combo_startup: Array[float] = [0.10, 0.10, 0.12, 0.18]   # 前摇（可以 Dodge Cancel）
@export var combo_active: Array[float] = [0.08, 0.08, 0.08, 0.12]    # 攻击判定
@export var combo_recovery: Array[float] = [0.22, 0.22, 0.25, 0.40]  # 后摇
@export var combo_lunge: Array[float] = [0.5, 0.5, 0.7, 1.2]         # 【Proposed】每段的前冲距离
@export var combo_hitbox_scale: Array[float] = [1.0, 1.0, 1.0, 1.6]  # 判定范围倍数（第 4 段更大）
@export var attack_reach: float = 0.8

# ===== Guard / Parry：Prototype 测试值，最终值 TBD =====
@export var max_guard: float = 100.0
@export var guard_recovery_delay: float = 0.5
@export var guard_recovery_time: float = 2.0
@export var guard_break_duration: float = 1.0
@export var parry_window: float = 0.2

# ===== Combat Meter（大招槽）：Prototype 测试值 =====
@export var max_combat_meter: float = 100.0
@export var meter_gain_perfect_parry: float = 25.0
@export var meter_gain_perfect_dodge: float = 20.0
@export var meter_gain_dodge: float = 5.0         # 普通 Dodge 躲开攻击
@export var meter_gain_hit: float = 5.0

# ===== Combo 计数 =====
@export var max_combo: int = 999                  # Confirmed
@export var combo_timeout: float = 2.0            # 测试值，TBD

const ENEMY_LAYER: int = 3

enum State { MOVE, DODGE, ATTACK, BLOCK, GUARD_BREAK }
enum AttackPhase { STARTUP, ACTIVE, RECOVERY }

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var sprite: Sprite3D = $Sprite
@onready var attack_hitbox: Area3D = $AttackHitbox
@onready var attack_shape: CollisionShape3D = $AttackHitbox/CollisionShape3D
@onready var debug_label: Label = $DebugUI/DebugLabel

var state: State = State.MOVE

# 移动
var facing_right: bool = true
var is_running: bool = false
var move_hold_time: float = 0.0
var using_controller: bool = false
var last_tap_action: StringName = &""
var last_tap_time: float = -10.0

# Dodge
var dodge_charges: int = 0
var dodge_recharge_timer: float = 0.0
var is_invincible: bool = false
var dodge_elapsed: float = 0.0
var dodge_direction: Vector3 = Vector3.ZERO
var dodge_passing_enemies: bool = false
var dodge_buffered_at: float = -10.0
var dodge_pressed_at: float = -10.0
var perfect_flash_timer: float = 0.0

# 攻击 / 连段
var attack_step: int = 0              # 现在是第几段（0 = 第 1 段）
var attack_phase: AttackPhase = AttackPhase.STARTUP
var attack_timer: float = 0.0
var attack_queued: bool = false       # 是否已经预约了下一段
var attack_queued_at: float = -10.0
var hit_bodies: Array = []
var base_hitbox_size: Vector3 = Vector3.ONE

# Guard / Parry
var guard: float = 0.0
var last_guard_pressure_time: float = -10.0
var guard_break_timer: float = 0.0
var block_pressed_at: float = -10.0
var parry_flash_timer: float = 0.0

# Combat Meter / Combo
var combat_meter: float = 0.0
var combo_count: int = 0
var combo_timer: float = 0.0

# 调试
var last_event_text: String = ""

const MOVE_ACTIONS: Array[StringName] = [&"move_left", &"move_right", &"move_up", &"move_down"]


func _ready() -> void:
	dodge_charges = max_dodge_charges
	guard = max_guard
	base_hitbox_size = (attack_shape.shape as BoxShape3D).size
	_update_hitbox_position()

	BulletTime.enemy_time_scale = bt_enemy_time_scale
	BulletTime.drain_acceleration = bt_drain_acceleration
	BulletTime.max_remaining = bt_max_remaining


func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion and abs(event.axis_value) > 0.2:
		using_controller = true
	elif event is InputEventJoypadButton:
		using_controller = true
	elif event is InputEventKey or event is InputEventMouseButton:
		using_controller = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("block"):
		block_pressed_at = _now()

	parry_flash_timer = max(parry_flash_timer - delta, 0.0)
	perfect_flash_timer = max(perfect_flash_timer - delta, 0.0)

	_update_dodge_recharge(delta)
	_update_guard_recovery(delta)
	_update_combo_timer(delta)

	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	match state:
		State.MOVE:
			_state_move(input_dir, delta)
		State.DODGE:
			_state_dodge(delta)
		State.ATTACK:
			_state_attack(input_dir, delta)
		State.BLOCK:
			_state_block()
		State.GUARD_BREAK:
			_state_guard_break(delta)

	move_and_slide()
	_update_debug_color()
	_update_debug_label()


# =========================================================
# 被攻击（敌人调用）
# =========================================================

func receive_attack(guard_damage: float, is_special: bool) -> void:
	if is_invincible:
		if _is_perfect_dodge_timing():
			_trigger_perfect_dodge(is_special)
		else:
			_on_normal_dodge_success()
		return

	if state == State.BLOCK:
		if is_special and _now() - block_pressed_at <= parry_window:
			parry_flash_timer = 0.25
			_add_combat_meter(meter_gain_perfect_parry)
			_log("★ Perfect Parry！")
			return

		guard -= guard_damage
		last_guard_pressure_time = _now()
		if is_special:
			_log("硬挡特殊攻击，Guard -%d" % guard_damage)
		else:
			_log("格挡成功，Guard -%d" % guard_damage)
		if guard <= 0.0:
			_start_guard_break()
		return

	_log("被击中！（HP 系统 TBD）")


func on_attack_evaded(is_special: bool) -> void:
	if state != State.DODGE:
		return
	if _is_perfect_dodge_timing():
		_trigger_perfect_dodge(is_special)
	else:
		_on_normal_dodge_success()


func _is_perfect_dodge_timing() -> bool:
	return _now() - dodge_pressed_at <= perfect_dodge_window


func _on_normal_dodge_success() -> void:
	_add_combat_meter(meter_gain_dodge)
	_log("Dodge 躲开了攻击（Meter +%d）" % meter_gain_dodge)


func _trigger_perfect_dodge(is_special: bool) -> void:
	perfect_flash_timer = 0.3
	_add_combat_meter(meter_gain_perfect_dodge)

	var duration := bt_duration_special if is_special else bt_duration_normal
	BulletTime.trigger(duration)

	if is_special:
		_log("★ Perfect Dodge！（闪光攻击 → 长子弹时间）")
	else:
		_log("★ Perfect Dodge！（普通攻击 → 短子弹时间）")


# =========================================================
# Combat Meter / Combo
# =========================================================

func _add_combat_meter(amount: float) -> void:
	var was_full := combat_meter >= max_combat_meter
	combat_meter = min(combat_meter + amount, max_combat_meter)
	if combat_meter >= max_combat_meter and not was_full:
		print("Combat Meter 满了！（Ultimate + Burst 之后做）")


func _add_combo() -> void:
	combo_count = min(combo_count + 1, max_combo)
	combo_timer = combo_timeout


func _update_combo_timer(delta: float) -> void:
	if combo_count <= 0:
		return
	combo_timer -= delta
	if combo_timer <= 0.0:
		_log("Combo 结束：%d Hit" % combo_count)
		combo_count = 0


# =========================================================
# MOVE 状态
# =========================================================

func _state_move(input_dir: Vector2, delta: float) -> void:
	if Input.is_action_just_pressed("dodge") and dodge_charges > 0:
		_start_dodge(input_dir)
		return

	if Input.is_action_just_pressed("attack"):
		_start_attack(0, input_dir)
		return

	if Input.is_action_pressed("block"):
		_start_block()
		return

	_update_run_state(input_dir, delta)
	var move_dir := input_dir.normalized()
	var speed := run_speed if is_running else walk_speed
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.y * speed

	if input_dir.x > 0:
		facing_right = true
	elif input_dir.x < 0:
		facing_right = false
	sprite.flip_h = not facing_right
	_update_hitbox_position()


# =========================================================
# BLOCK / GUARD BREAK 状态
# =========================================================

func _start_block() -> void:
	state = State.BLOCK
	is_running = false
	move_hold_time = 0.0


func _state_block() -> void:
	velocity.x = 0.0
	velocity.z = 0.0
	last_guard_pressure_time = _now()

	if not Input.is_action_pressed("block"):
		state = State.MOVE


func _start_guard_break() -> void:
	guard = 0.0
	state = State.GUARD_BREAK
	guard_break_timer = guard_break_duration
	_log("Guard Break！破防")


func _state_guard_break(delta: float) -> void:
	velocity.x = 0.0
	velocity.z = 0.0
	last_guard_pressure_time = _now()
	guard_break_timer -= delta
	if guard_break_timer <= 0.0:
		state = State.MOVE


func _update_guard_recovery(delta: float) -> void:
	if state == State.BLOCK or state == State.GUARD_BREAK:
		return
	if guard >= max_guard:
		return
	if _now() - last_guard_pressure_time < guard_recovery_delay:
		return
	guard = min(guard + (max_guard / guard_recovery_time) * delta, max_guard)


# =========================================================
# ATTACK 状态：4 段连段
# =========================================================

func _combo_length() -> int:
	return combo_startup.size()


func _start_attack(step: int, input_dir: Vector2) -> void:
	state = State.ATTACK
	attack_step = step
	attack_phase = AttackPhase.STARTUP
	attack_timer = combo_startup[step]
	attack_queued = false
	attack_queued_at = -10.0
	dodge_buffered_at = -10.0
	is_running = false
	move_hold_time = 0.0

	# 每一段开始时可以转身（TBD）
	if input_dir.x > 0:
		facing_right = true
	elif input_dir.x < 0:
		facing_right = false
	sprite.flip_h = not facing_right

	# 按这一段的倍数调整判定范围（第 4 段更大）
	var scale_factor := combo_hitbox_scale[step]
	(attack_shape.shape as BoxShape3D).size = base_hitbox_size * scale_factor
	_update_hitbox_position(scale_factor)


func _state_attack(input_dir: Vector2, delta: float) -> void:
	# 前冲：Startup + Active 期间朝面向方向移动，Recovery 停住
	var facing_sign := 1.0 if facing_right else -1.0
	var lunge_time := combo_startup[attack_step] + combo_active[attack_step]
	var lunge_speed := combo_lunge[attack_step] / lunge_time
	if attack_phase == AttackPhase.RECOVERY:
		velocity.x = 0.0
	else:
		velocity.x = facing_sign * lunge_speed
	velocity.z = 0.0

	attack_timer -= delta

	# 攻击中任何时候按攻击 → 预约下一段（最后一段不能再预约）
	if Input.is_action_just_pressed("attack") and attack_step < _combo_length() - 1:
		attack_queued = true
		attack_queued_at = _now()

	match attack_phase:
		AttackPhase.STARTUP:
			if Input.is_action_just_pressed("dodge") and dodge_charges > 0:
				_log("Dodge Cancel！")
				_start_dodge(input_dir)
				return
			if attack_timer <= 0.0:
				attack_phase = AttackPhase.ACTIVE
				attack_timer = combo_active[attack_step]
				hit_bodies.clear()

		AttackPhase.ACTIVE:
			_record_dodge_buffer()
			_check_attack_hits()
			if attack_timer <= 0.0:
				# 已经预约了下一段，并且比 Dodge 输入更晚 → 直接接下一段
				if _should_chain_next():
					_start_attack(attack_step + 1, input_dir)
					return
				attack_phase = AttackPhase.RECOVERY
				attack_timer = combo_recovery[attack_step]

		AttackPhase.RECOVERY:
			_record_dodge_buffer()
			# 【Proposed】后摇中按攻击 → 立刻接下一段
			if _should_chain_next():
				_start_attack(attack_step + 1, input_dir)
				return
			if attack_timer <= 0.0:
				_end_attack(input_dir)


func _should_chain_next() -> bool:
	return attack_queued and attack_queued_at > dodge_buffered_at


func _end_attack(input_dir: Vector2) -> void:
	state = State.MOVE
	attack_step = 0
	(attack_shape.shape as BoxShape3D).size = base_hitbox_size
	_update_hitbox_position()

	if _now() - dodge_buffered_at <= dodge_buffer_time and dodge_charges > 0:
		_log("Buffered Dodge！")
		_start_dodge(input_dir)
	dodge_buffered_at = -10.0


func _record_dodge_buffer() -> void:
	if Input.is_action_just_pressed("dodge"):
		dodge_buffered_at = _now()


func _check_attack_hits() -> void:
	for body in attack_hitbox.get_overlapping_bodies():
		if body not in hit_bodies:
			hit_bodies.append(body)
			_add_combat_meter(meter_gain_hit)
			_add_combo()
			if BulletTime.active:
				BulletTime.extend(bt_extend_per_hit)
			_log("第 %d 段 命中: %s" % [attack_step + 1, body.name])


func _update_hitbox_position(scale_factor: float = 1.0) -> void:
	# 判定范围变大时，中心也往前推，让它主要向前延伸
	var reach := attack_reach * scale_factor
	attack_hitbox.position.x = reach if facing_right else -reach


# =========================================================
# DODGE 状态：位移 → 收招
# =========================================================

func _start_dodge(input_dir: Vector2) -> void:
	var dir := input_dir.normalized()
	if dir == Vector2.ZERO:
		dir = Vector2.LEFT if facing_right else Vector2.RIGHT

	# 从攻击中 Dodge Cancel 时，恢复判定范围
	attack_step = 0
	(attack_shape.shape as BoxShape3D).size = base_hitbox_size
	_update_hitbox_position()

	dodge_direction = Vector3(dir.x, 0.0, dir.y)
	state = State.DODGE
	dodge_elapsed = 0.0
	dodge_pressed_at = _now()
	is_invincible = true
	dodge_charges -= 1
	dodge_passing_enemies = true
	set_collision_mask_value(ENEMY_LAYER, false)


func _state_dodge(delta: float) -> void:
	dodge_elapsed += delta
	var total_time := dodge_duration + dodge_end_lag

	if dodge_elapsed < dodge_duration:
		var dodge_speed := dodge_distance / dodge_duration
		velocity.x = dodge_direction.x * dodge_speed
		velocity.z = dodge_direction.z * dodge_speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		if dodge_passing_enemies:
			dodge_passing_enemies = false
			set_collision_mask_value(ENEMY_LAYER, true)

	is_invincible = dodge_elapsed < total_time * dodge_invincible_ratio

	if dodge_elapsed >= total_time:
		_end_dodge()


func _end_dodge() -> void:
	state = State.MOVE
	is_invincible = false
	velocity.x = 0.0
	velocity.z = 0.0
	if dodge_passing_enemies:
		dodge_passing_enemies = false
		set_collision_mask_value(ENEMY_LAYER, true)


func _update_dodge_recharge(delta: float) -> void:
	if dodge_charges >= max_dodge_charges:
		dodge_recharge_timer = 0.0
		return
	dodge_recharge_timer += delta
	if dodge_recharge_timer >= dodge_recharge_time:
		dodge_charges += 1
		dodge_recharge_timer = 0.0


# =========================================================
# Walk / Run
# =========================================================

func _update_run_state(input_dir: Vector2, delta: float) -> void:
	if input_dir == Vector2.ZERO:
		is_running = false
		move_hold_time = 0.0
		return

	if using_controller:
		is_running = input_dir.length() >= controller_run_threshold
		return

	move_hold_time += delta
	if move_hold_time >= auto_run_delay:
		is_running = true

	var now := _now()
	for action in MOVE_ACTIONS:
		if Input.is_action_just_pressed(action):
			if action == last_tap_action and now - last_tap_time <= double_tap_window:
				is_running = true
			last_tap_action = action
			last_tap_time = now


# =========================================================
# 工具函数
# =========================================================

func _now() -> float:
	return Time.get_ticks_msec() / 1000.0


func _log(text: String) -> void:
	last_event_text = text
	print(text)


# =========================================================
# 【测试用】调试显示，以后会删掉
# =========================================================

func _update_debug_label() -> void:
	var bar_count := int(combat_meter / max_combat_meter * 20.0)
	var meter_bar := "█".repeat(bar_count) + "░".repeat(20 - bar_count)
	var bt_text := "BULLET TIME  %.2f" % BulletTime.remaining if BulletTime.active else "-"
	var attack_text := "%d / %d" % [attack_step + 1, _combo_length()] if state == State.ATTACK else "-"
	debug_label.text = "State: %s\nAttack: %s\nGuard: %d / %d\nDodge Charge: %d / %d\nInvincible: %s\nCombat Meter: %s %d%s\nCombo: %d\nBullet Time: %s\n%s" % [
		State.keys()[state], attack_text, guard, max_guard, dodge_charges, max_dodge_charges,
		"YES" if is_invincible else "-",
		meter_bar, combat_meter, "  MAX!" if combat_meter >= max_combat_meter else "",
		combo_count, bt_text, last_event_text
	]


func _update_debug_color() -> void:
	if perfect_flash_timer > 0.0:
		sprite.modulate = Color(0.8, 1.0, 1.0)
		return
	if parry_flash_timer > 0.0:
		sprite.modulate = Color(1.0, 0.85, 0.2)
		return

	match state:
		State.DODGE:
			if is_invincible:
				sprite.modulate = Color(0.6, 0.8, 1.0, 0.5)
			else:
				sprite.modulate = Color(0.4, 0.5, 0.7)
		State.BLOCK:
			sprite.modulate = Color(0.3, 0.5, 1.0)
		State.GUARD_BREAK:
			sprite.modulate = Color(0.7, 0.2, 0.9)
		State.ATTACK:
			match attack_phase:
				AttackPhase.STARTUP:
					sprite.modulate = Color(1.0, 1.0, 0.4)
				AttackPhase.ACTIVE:
					sprite.modulate = Color(1.0, 0.3, 0.1)
				AttackPhase.RECOVERY:
					sprite.modulate = Color(0.5, 0.5, 0.5)
		_:
			sprite.modulate = Color(1.0, 0.6, 0.6) if is_running else Color.WHITE
