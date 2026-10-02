extends Node

# ===== 子弹时间管理器（全局）=====
# 只让"敌人"变慢，玩家保持正常速度。
# 数值由 Player 在开始时设置，方便在 Player 的检查器里调整。

var enemy_time_scale: float = 0.15    # 子弹时间中敌人的速度（0.15 = 正常速度的 15%）
var max_remaining: float = 2.0        # 剩余时间的上限
var drain_acceleration: float = 1.5   # 流失加速度：越到后面流失越快

var active: bool = false
var remaining: float = 0.0            # 还剩多少子弹时间
var elapsed: float = 0.0              # 这次子弹时间已经持续了多久


# 敌人用这个函数决定自己要慢多少
func get_enemy_scale() -> float:
	return enemy_time_scale if active else 1.0


# 开始子弹时间（如果已经在子弹时间中，取较长的那个）
func trigger(duration: float) -> void:
	if not active:
		active = true
		elapsed = 0.0
		remaining = 0.0
	remaining = min(max(remaining, duration), max_remaining)


# 子弹时间中攻击命中：稍微延长
func extend(amount: float) -> void:
	if active:
		remaining = min(remaining + amount, max_remaining)


func _physics_process(delta: float) -> void:
	if not active:
		return

	elapsed += delta
	# 流失速度 = 1 + 加速度 × 已持续时间 → 越来越快
	var drain_rate := 1.0 + drain_acceleration * elapsed
	remaining -= delta * drain_rate

	if remaining <= 0.0:
		active = false
		remaining = 0.0
