extends StaticBody3D

# ===== 测试假人（测试值）=====
@export var attack_interval: float = 2.0

# 普通攻击
@export var windup_time: float = 0.5
@export var guard_damage: float = 25.0

# 特殊闪光攻击
@export var special_every: int = 3
@export var special_windup_time: float = 0.9
@export var special_flash_final: float = 0.25
@export var special_guard_damage: float = 60.0

@export var active_time: float = 0.1
@export var evade_memory_time: float = 0.3

enum State { IDLE, WINDUP, ACTIVE }

var state: State = State.IDLE
var timer: float = 0.0
var has_hit: bool = false
var attack_resolved: bool = false
var attack_count: int = 0
var is_special: bool = false
var body_material := StandardMaterial3D.new()

var last_target: Node = null
var last_target_time: float = -10.0

@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var attack_hitbox: Area3D = $AttackHitbox


func _ready() -> void:
	mesh.material_override = body_material
	timer = attack_interval
	_set_color(Color.WHITE)


func _physics_process(delta: float) -> void:
	# 子弹时间中，敌人的时间变慢
	var d := delta * BulletTime.get_enemy_scale()
	timer -= d

	match state:
		State.IDLE:
			if timer <= 0.0:
				attack_count += 1
				is_special = special_every > 0 and attack_count % special_every == 0
				state = State.WINDUP
				timer = special_windup_time if is_special else windup_time
				last_target = null
				if not is_special:
					_set_color(Color(1.0, 1.0, 0.3))

		State.WINDUP:
			_remember_targets_in_range()
			if is_special:
				_update_special_flash()
			if timer <= 0.0:
				state = State.ACTIVE
				timer = active_time
				has_hit = false
				attack_resolved = false
				_set_color(Color(1.0, 0.2, 0.1))

		State.ACTIVE:
			_resolve_attack()
			if timer <= 0.0:
				state = State.IDLE
				timer = attack_interval
				_set_color(Color.WHITE)


func _remember_targets_in_range() -> void:
	for body in attack_hitbox.get_overlapping_bodies():
		if body.has_method("receive_attack"):
			last_target = body
			last_target_time = _now()


func _resolve_attack() -> void:
	var damage := special_guard_damage if is_special else guard_damage

	if not has_hit:
		for body in attack_hitbox.get_overlapping_bodies():
			if body.has_method("receive_attack"):
				body.receive_attack(damage, is_special)
				has_hit = true
				attack_resolved = true

	if not attack_resolved:
		attack_resolved = true
		if last_target != null and _now() - last_target_time <= evade_memory_time:
			if last_target.has_method("on_attack_evaded"):
				last_target.on_attack_evaded(is_special)


func _update_special_flash() -> void:
	if timer <= special_flash_final:
		_set_color(Color(0.2, 1.0, 1.0))
	else:
		var blink_on := int(timer * 10.0) % 2 == 0
		_set_color(Color(0.2, 1.0, 1.0) if blink_on else Color.WHITE)


func _set_color(color: Color) -> void:
	body_material.albedo_color = color


func _now() -> float:
	return Time.get_ticks_msec() / 1000.0
