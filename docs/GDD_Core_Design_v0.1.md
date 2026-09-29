# **武侠 HD-2D RPG**

## **Game Design Document \- Current Foundation**

### **Document Status**

本文件记录目前已经讨论并确认的游戏核心方向。

这是一个 **Living Document**。后续设计可以持续补充、修改或删除。任何尚未明确决定的内容会标记为 **TBD**，不应该自动视为正式设计。

---

# **1\. Project Goal / 项目目标**

这是一个计划使用大约 **半年时间**独立开发的中国武侠题材 RPG / Action RPG。

项目目标不仅仅是完成学校作业，也不是制作一个单纯用于展示技术和玩法的 Vertical Slice。

目标是制作一个真正具有较高完成度、能够正式发布到 **Steam** 的可玩 Demo。

理想状态下：

* 游戏拥有正式 Steam 商店页面  
* 玩家可以直接在 Steam 上搜索到游戏  
* Demo 可以公开下载和游玩  
* Demo 的内容不是一次性的展示内容  
* Demo 本身就是未来完整游戏真正的开端  
* 后续开发会直接在这个项目和这部分内容上继续扩展

目标 Demo 的正常游玩时间至少约为：

**30 分钟～1 小时以上**

Demo 不应该给玩家一种：

> “这是一个学生 Prototype，每个系统各展示一点。”

的感觉。

而应该让玩家感觉：

> “我刚刚玩到了一个真正游戏的第一部分，只是后面的内容目前还没有制作完成。”

---

# **2\. Development Conditions / 开发条件**

## **Development Time**

预计开发周期：

**约 6 个月**

因此 Scope Control 非常重要。

项目应该优先保证：

* 完成度  
* 美术质量  
* 整体审美  
* 剧情体验  
* 战斗手感

而不是盲目追求大量地图、系统、敌人或内容数量。

---

## **Development Team**

项目由 **一名开发者独立完成**。

没有第二名正式开发成员。

开发过程中可以使用：

* 自己制作的美术  
* AI 辅助制作的美术资源  
* 购买的商业美术 Asset  
* 其他合法可用于游戏开发的资源

但是：

* Game Design  
* Programming  
* Level Design  
* Narrative Integration  
* System Integration  
* Final Production

等工作均由本人负责。

因此所有设计都必须考虑 **Solo Development Scope**。

---

# **3\. Development Engine / 开发引擎**

**Confirmed**

项目使用：

# **Godot**

作为正式开发引擎。

目标平台首先为：

# **PC / Steam**

后续游戏技术方案将围绕 Godot 设计。

除非未来遇到非常严重、无法解决的技术限制，否则目前不再同时考虑 Unity 等其他引擎。

---

# **4\. Core Player Experience / 核心玩家体验**

这个游戏最重要的体验不是只依靠某一个系统，而是希望玩家同时体验到三个核心部分：

## **1\. 剧情**

玩家应该对剧情的发展产生持续期待。

希望玩家体验剧情的时候有一点类似“追剧”的感觉：

> 想知道后面发生什么。  
> 想知道角色接下来会怎么样。  
> 愿意为了后续剧情继续玩下去。

剧情不是单纯服务战斗的背景包装，而是游戏非常重要的核心内容。

---

## **2\. 战斗**

战斗需要：

* 流畅  
* 爽快  
* 操作反馈明确  
* 有一定操作技巧  
* 同时允许玩家研究 Build

玩家应该单纯因为“打架很好玩”而愿意继续进行战斗。

---

## **3\. 美术与整体审美**

美术成功是这个项目非常重要的目标之一。

希望整个游戏：

* 美术风格统一  
* 审美在线  
* 场景有吸引力  
* 画面能够让玩家留下印象  
* 具有真正独立商业游戏的视觉质感

---

# **5\. Gameplay Content Ratio / 内容比例**

目前目标大致为：

### **40% 剧情**

### **40% 战斗**

### **20% 探索**

这个比例不需要成为严格数学标准，而是用于表达游戏体验重点。

游戏整体更偏：

**Narrative \+ Combat Driven**

探索属于重要的连接部分，但不是以超大型开放世界探索为核心的游戏。

---

# **6\. Visual Direction / 美术方向**

游戏目标为：

# **HD-2D / 2.5D Pixel Art Wuxia**

主要视觉参考之一：

**Octopath Traveler / 八方旅人**

希望表现为：

* 精细 Pixel Art Character  
* 像素风环境  
* 明显的空间纵深  
* 现代光影  
* 粒子效果  
* 景深  
* 环境氛围  
* 真实空间中的像素视觉

探索地图不是单纯传统平面 2D Tilemap。

地图会拥有：

* X  
* Y  
* Z

三个空间维度。

可以存在：

* 高低差  
* 楼梯  
* 建筑  
* 房顶  
* 桥梁  
* 不同高度的平台

但整体视觉仍然应该首先让玩家认为：

> “这是一个精致的像素游戏。”

而不是：

> “这是一个普通 3D 游戏加了 Pixel Filter。”

具体 Pixel Resolution、角色高度、Pixel Density 等暂未决定。

这些内容未来可以单独建立 **Art Bible**。

---

# **7\. Overall Game Structure / 游戏整体结构**

目前游戏主要考虑三个 Gameplay Layer。

## **1\. World Map / 大世界**

## **2\. Exploration Map / 区域探索地图**

## **3\. Battle Scene / 战斗地图**

基础流程可以理解为：

**World Map**

↓

**选择 / 前往某个区域**

↓

**Exploration Map**

↓

探索、剧情、NPC、宝箱、事件等

↓

遭遇战斗

↓

**Battle Scene**

↓

战斗结束

↓

返回 Exploration Map

---

# **8\. World Map / 大世界**

大世界系统计划存在，但目前形式尚未确定。

可能的形式包括：

* 世界地图上控制角色移动  
* 节点式地图  
* JRPG 式 World Map  
* 其他连接不同区域的方法

目前：

# **World Map \= TBD**

这个系统不应该在现阶段限制其他玩法设计。

---

# **9\. Exploration Map Structure / 探索地图结构**

**Confirmed**

游戏不会制作成为一个完全无缝连接的开放世界。

游戏由多个独立地图 / Scene 组成。

例如：

* 城镇  
* 村庄  
* 森林  
* 竹林  
* 山洞  
* 野外  
* 地牢  
* 特殊区域

全部可以分别作为不同 Scene。

不同地图的大小不需要一致。

例如：

主城可以：

* 更大  
* NPC 更多  
* 建筑更多  
* 内容更加丰富

普通野外区域则可以：

* 更紧凑  
* 更集中  
* 更容易控制开发规模

地图之间通过：

* 道路  
* 出口  
* 门  
* 场景切换  
* 剧情事件

等方式连接。

---

# **10\. Battle Maps Are Also Separate Scenes**

**Confirmed**

战斗地图同样为独立 Scene。

战斗不会直接发生在 Exploration Map 中。

基本结构：

**Exploration Scene**

↓

触发战斗

↓

Transition

↓

**Battle Scene**

↓

Battle Result

↓

返回原来的 Exploration Scene

因此：

探索地图和战斗地图是两个相对独立的游戏环境。

---

# **11\. Exploration Content / 探索内容**

探索地图未来可以包含：

* NPC  
* 剧情事件  
* 对话  
* 宝箱  
* 隐藏物品  
* 商人  
* 城镇  
* 建筑  
* 主线任务  
* 支线任务  
* 特殊事件  
* 战斗触发点  
* Boss  
* 可互动环境

具体内容数量根据开发 Scope 控制。

---

# **12\. Encounter System / 遇敌系统**

游戏采用：

# **Mixed Encounter System**

但整体更偏：

# **暗雷为主**

普通探索过程中，大部分普通敌人不会一直显示在地图上。

玩家在正常探索过程中会进入普通遭遇战。

具体遭遇算法、随机率、保护机制等暂未决定。

---

同时存在特殊的直接战斗触发。

例如：

## **NPC Encounter**

某个 NPC 主动攻击玩家。

## **Ambush**

剧情中的敌人埋伏。

## **Scripted Battle**

剧情强制进入战斗。

## **Obvious Combat Area**

玩家明显进入一个即将发生战斗的区域。

## **Boss Encounter**

Boss 或重要敌人触发专属战斗。

因此不是所有战斗都依靠随机暗雷。

---

# **13\. Exploration Movement / 探索移动**

目前正式确定的基础移动为：

## **Walk**

## **Run**

这是当前 Exploration Movement 的核心。

---

## **Jump**

**TBD**

未来可能加入：

* Jump  
* 甚至 Double Jump

但是目前尚未决定。

如果未来确定 Jump 是基础探索机制，更倾向于：

> 从游戏开始就让玩家拥有。

而不是中期突然作为能力解锁。

原因是后期解锁 Jump 会让旧地图自然产生：

* 回头探索  
* 新路线  
* Metroidvania-style gating

等额外设计需求。

目前不确定项目是否需要这种结构。

---

## **Rooftop / Vertical Traversal**

希望探索过程中可能存在：

* 上房顶  
* 翻越某些结构  
* 到达较高区域

但希望这些动作：

# **合理化**

不希望为了武侠主题强行加入非常夸张的移动系统。

未来可能采用：

* 特定攀爬点  
* 环境互动  
* 梯子  
* 建筑结构  
* 特定翻越动作

等方式实现。

具体形式：

# **TBD**

---

## **Qinggong / 轻功**

目前：

# **不考虑完整轻功系统**

未来有需要可以重新讨论，但不是现阶段核心设计。

---

# **14\. Player Character / 主角**

玩家可以选择：

# **Male Protagonist**

或者：

# **Female Protagonist**

但主角不是完全自由 Create Character。

目前更倾向于：

# **Semi-Fixed Protagonist / 半固定主角**

也就是说：

玩家可以选择男性或者女性主角，但主角仍然会拥有：

* 相对固定的故事身份  
* 游戏剧情中的固定位置  
* 一定程度的正式人物设定

而不是完全由玩家从零创建背景的角色。

---

# **15\. Player Control / 玩家控制**

玩家在实际 Gameplay 中：

# **只直接操控主角**

不会在战斗中切换其他队友角色。

不会制作传统：

* 4人 Party 实时切换  
* 多角色直接控制  
* AI 队友常驻战斗

这样的系统。

---

# **16\. Companion System / 同伴系统**

虽然玩家只控制主角，但游戏中仍然可以存在：

* 队友  
* 同伴  
* 盟友  
* 剧情伙伴

这些角色仍然可以：

* 与主角同行  
* 参与剧情  
* 建立人物关系  
* 在战斗中帮助玩家

但是：

# **他们不会作为完整 AI 战斗单位长期存在于战场。**

主要原因是 Solo Development Scope。

如果制作完整 AI Party，需要额外处理：

* Movement AI  
* Targeting  
* Pathfinding  
* Combat AI  
* Dodge  
* Hit Reaction  
* Death  
* Skill Logic  
* Animation  
* Character Art  
* Balance

工作量过高。

---

## **Companion Assist System**

因此目前倾向使用：

# **Companion Assist / 同伴支援系统**

队友在战斗中更接近一个特殊支援技能。

例如：

队友拥有自己的：

* 支援槽  
* 计时器  
* Cooldown  
* 其他触发机制

达到条件以后：

队友短暂进入战场

↓

播放一段专属技能 / 攻击动画

↓

产生效果

↓

退出战场

效果可能包括：

* Damage  
* Buff  
* Debuff  
* Control  
* Healing  
* Utility

具体触发方式尚未完全锁定。

核心原则是：

> 玩家依然能够感觉“我有队友，我不是永远一个人”。

但不需要制作完整 AI Companion System。

---

# **17\. Combat Type / 战斗类型**

**Confirmed**

游戏采用：

# **Real-Time Action Combat**

不是：

* Turn-Based  
* Command-Based  
* ATB  
* Pause-to-select skill

战斗开始后：

玩家和敌人均实时移动、攻击和反应。

---

# **18\. Battle Space / 战斗空间**

战斗空间参考：

**DNF / Dungeon Fighter 类三轴战斗**

不是单纯只能：

左右移动

的传统 Side Scroller。

玩家可以在战斗区域内进行：

* 左右移动  
* 前后 / 上下纵深移动

因此战斗本身拥有明显的：

# **X / Y / Z Space**

---

# **19\. Basic Combat Actions / 战斗基础操作**

目前确定的基础战斗动作：

## **Movement**

自由移动。

## **Normal Attack**

普通攻击 / Combo。

## **Block**

格挡。

## **Perfect Parry**

精确弹反。

## **Dodge**

闪避 / Dash / Roll 类动作。

## **Perfect Dodge**

精准闪避。

## **Martial Arts Skills**

武学技能。

---

## **Heavy Attack**

目前：

# **不计划设置独立 Heavy Attack**

原因是已经存在：

* Skills  
* Parry  
* Dodge  
* Build

没有必要为了动作数量强行增加一个系统。

---

## **Jump**

战斗中的 Jump：

# **TBD**

原因是如果加入 Jump，很容易连锁产生大量额外工作：

* Jump Animation  
* Jump Attack  
* Air Skill  
* Air Combo  
* Air Hit Reaction  
* Airborne Enemy State  
* Landing  
* Anti-Air Enemy Attack

因此暂时保留可能性，但不作为当前确定系统。

---

# **20\. Menu Access During Combat**

战斗不是完全封闭菜单的状态。

玩家仍然可以：

* 打开背包  
* 查看任务  
* 查看角色信息  
* 查看装备

对于一般 Equipment 是否允许在战斗中更换，目前可以保持较宽松。

但是有一个重要限制已经确定：

# **战斗过程中不能更换当前武器、武学技能或战斗流派。**

进入战斗时，本场 Build 即被确定。

---

# **21\. Weapon Philosophy / 武器系统**

目前计划制作大约：

# **2～3 种武器 / 战斗流派**

具体武器类型暂未决定。

每一种武器应该拥有自己的：

* 普通攻击  
* Combo  
* 战斗节奏  
* 武学技能  
* Talent Tree  
* Build  
* Weapon Properties  
* Special Affix / 特殊词条

武器之间不应该只是：

> Attack \+10  
> Damage 不同

而应该有明显不同的玩法。

---

# **22\. One Weapon Per Battle / 单武器战斗**

**Confirmed**

玩家不能在一场战斗中实时切换多个武器。

进入战斗时：

玩家已经确定：

* 当前武器  
* 当前流派  
* 当前技能  
* 当前 Build

然后：

# **一把武器 / 一个流派完成整场战斗。**

玩家如果想体验其他流派：

需要在战斗之外重新调整 Build。

---

# **23\. Respec / 洗点**

希望玩家具有较高 Build 自由度。

玩家可以：

# **Respec / 洗点**

然后：

* 换另一种武器  
* 尝试不同流派  
* 使用不同技能组合  
* 更改 Talent Build

目前希望洗点不要成为极其苛刻的系统。

具体费用、地点、限制：

# **TBD**

---

# **24\. Skill System / 武学技能系统**

玩家不会拥有几十个主动技能同时放在快捷栏。

实际战斗中预计：

# **大约 3 个主动技能**

具体数字未来可以调整。

这些技能属于当前武器 / 武学流派。

---

# **25\. Skill Cooldown**

**Confirmed**

游戏：

# **不设置 Qi / 内力资源条**

玩家不会需要管理：

* Mana  
* Qi  
* Internal Energy

这样的主动技能资源。

---

普通攻击：

不消耗资源。

格挡：

不消耗 Qi。

闪避：

不消耗 Qi。

技能主要通过：

# **Cooldown / CD**

限制使用频率。

这样玩家可以把注意力放在：

* Combat Positioning  
* Combo  
* Dodge  
* Parry  
* Skill Timing  
* Build

上，而不是管理额外资源条。

---

# **26\. Talent Tree / 天赋树**

玩家在游戏过程中可以获得：

# **Skill Points / Talent Points**

然后投入：

# **Talent Tree**

天赋树属于 Build 系统的重要组成部分。

---

天赋树不仅应该提供：

* \+5% Damage  
* \+10% Attack

这种纯数值成长。

更重要的是提供：

# **Active Skill Unlock**

解锁新的武学技能。

# **Skill Enhancement**

强化已有技能。

# **Skill Modification**

改变技能玩法。

例如某个天赋可以：

* 改变技能攻击形式  
* 增加攻击段数  
* 改变技能范围  
* 改变技能触发方式  
* 增加技能与 Parry 的联动  
* 增加技能与 Combat Meter 的联动  
* 改变 CD  
* 形成不同 Build

具体技能以后单独设计。

---

# **27\. Limited Skill Loadout**

虽然 Talent Tree 中可能存在多个主动技能：

玩家实际战斗中只能选择少量技能。

目前目标大约：

# **3 Active Skills**

如果玩家希望体验另一套技能：

需要：

* 调整天赋  
* 洗点  
* 修改 Build

然后在下一场战斗使用。

---

# **28\. Block System / 格挡系统**

玩家拥有：

# **Guard Meter / 格挡槽**

格挡攻击会消耗 Guard Meter。

玩家不能无限一直按着 Block 无脑防御。

---

## **Normal Attack**

普通攻击可以被：

# **Block**

挡住。

具体每次消耗多少 Guard：

未来通过 Prototype 调整。

---

# **29\. Special Flash Attack / 特殊闪光攻击**

某些敌人攻击属于：

# **Special Attack**

例如：

* 蓄力攻击  
* 强力攻击  
* 特殊招式

这些攻击在释放前会给玩家明显 Telegraph。

可能表现为：

* 闪光  
* 武器特效  
* 特殊颜色  
* 音效  
* 动作提示

具体视觉语言以后统一设计。

---

特殊闪光攻击仍然：

# **可以普通 Block**

但是：

如果玩家只是普通格挡，而没有 Perfect Parry：

会造成：

# **大量 Guard Meter Damage**

例如设计目标可以做到：

连续硬挡大约 1～2 次强力特殊攻击，就可能让玩家 Guard 快要耗尽。

具体数值以后调整。

---

# **30\. Perfect Parry / 完美弹反**

只有某些：

# **特殊 Telegraph / 闪光攻击**

能够被 Perfect Parry。

普通攻击主要通过普通格挡处理。

---

Block 和 Parry：

# **使用同一个基础操作**

例如：

按住：

# **Block**

在特殊攻击命中的正确时间点精确按下：

# **Perfect Parry**

因此 Parry 不是一个额外独立按钮。

---

Perfect Parry 的时间窗口：

希望：

# **相对宽松**

不希望它成为只有高水平玩家才能经常使用的机制。

设计目标是：

让玩家感觉：

> “我看懂了敌人的攻击，并且成功处理了。”

而不是：

> “必须精准到极端帧数才能成功。”

---

# **31\. Guard Break / 破防**

如果 Guard Meter 被消耗至：

# **0**

玩家进入：

# **Guard Break / 破防状态**

在短时间内：

* 无法正常继续防守  
* 暴露给敌人攻击  
* 受到明显惩罚

具体：

* 破防时间  
* 是否硬直  
* 是否额外受伤  
* 动画表现

全部：

# **TBD**

---

# **32\. Guard Recovery**

**Confirmed**

玩家停止格挡并脱离持续压力后：

# **Guard Meter 自动恢复**

恢复速度：

# **偏快**

但是相比 Dodge Charge：

# **Guard 的完整恢复稍慢一些**

具体秒数：

未来通过 Playtest 调整。

---

# **33\. Dodge System / 闪避系统**

玩家拥有独立 Dodge。

具体表现形式：

# **TBD**

可能是：

* Dash  
* Roll  
* Quick Step  
* 瞬间位移感动作

最终根据武侠美术和 Combat Feel 决定。

---

# **34\. Dodge Charges**

玩家不能：

# **无限连续 Dodge**

Dodge 使用：

# **Charge System / 次数制**

例如玩家可能拥有若干 Dodge Charge。

具体数量：

# **TBD**

---

# **35\. Dodge Recovery**

**Confirmed**

Dodge Charge：

# **按时间自动恢复**

不要求：

* 攻击敌人才能恢复  
* Perfect Parry 才能恢复

基础恢复就是自动计时。

---

Dodge 的恢复速度：

# **相对较快**

整体上：

**Dodge Recovery \> Guard Full Recovery**

也就是 Dodge Charge 恢复会比完整 Guard Meter 恢复稍快一点。

具体时间：

以后平衡。

---

# **36\. Dodge Cancel / 闪避取消动作**

这是战斗流畅感的重要设计。

玩家在某些攻击动作中：

可以直接使用 Dodge：

# **Cancel 当前动作**

然后：

立即进入闪避。

例如：

Normal Attack

↓

发现敌人准备攻击

↓

Dodge

↓

取消当前攻击后摇 / 部分动作

↓

脱离危险

---

目的：

避免玩家因为：

> “刚才按了一次攻击，所以现在什么都不能做。”

而感觉控制非常僵硬。

但不是所有 Animation 一定全部能 Cancel。

具体 Cancel Window：

未来设计。

---

# **37\. Perfect Dodge / 完美闪避**

Perfect Dodge：

不限于特殊闪光攻击。

理论上玩家精准避开：

# **普通攻击**

或者：

# **特殊攻击**

都可以触发 Perfect Dodge。

---

Perfect Dodge 可以：

# **增加 Combat Meter**

这是目前比较确定的奖励之一。

---

## **Bullet Time**

Perfect Dodge 成功以后是否进入：

例如：

# **约 0.5 秒的 Slow Motion / Bullet Time**

目前：

# **TBD**

这个效果可能：

* 增强爽感  
* 增加视觉反馈

但也可能：

* 打断节奏  
* 触发过于频繁

因此必须 Prototype 以后判断。

---

# **38\. Combat Meter / 核心战斗槽**

游戏计划加入一个独立：

# **Combat Meter**

目前只是工作名。

最终可以改成更符合武侠世界的名称。

---

玩家表现得越好：

Combat Meter 增长越快。

目前可能的增长来源：

# **Combo**

持续连击。

# **Perfect Parry**

完美弹反。

# **Perfect Dodge**

完美闪避。

未来：

* Talent  
* Weapon Affix  
* Skill  
* Special Effect

也可以影响其增长。

---

# **39\. Combat Meter Purpose**

Combat Meter 满以后：

希望玩家可以获得：

# **非常明显的强力奖励**

但具体奖励目前：

# **TBD**

曾讨论两个主要方向。

---

## **Option A：Ultimate**

满槽以后：

玩家主动消耗 Combat Meter

↓

释放：

# **Ultimate / 大招 / 奥义**

---

## **Option B：Burst State**

满槽以后：

玩家主动进入一段：

# **Burst / 爆发状态**

可能获得：

* 攻速提升  
* Skill CD 大幅减少  
* 技能循环加快  
* 特殊战斗效果

---

目前更倾向：

# **玩家主动决定何时使用**

而不是 Meter 一满就自动进入状态。

---

# **40\. Combat Meter \+ Talent Tree**

一个重要方向：

# **Talent Tree 可以改变 Combat Meter 的用途。**

例如未来不同 Build 可能让 Combat Meter：

* 用于 Ultimate  
* 用于 Burst State  
* 强化某类技能  
* 产生其他特殊效果

这可以让同一个核心系统服务不同 Build。

具体效果：

# **TBD**

---

# **41\. Battle Scene Structure / 战斗地图结构**

游戏同时存在：

# **普通 Arena 战**

以及：

# **Multi-Room Dungeon Battle**

---

# **42\. Normal Encounter Arena**

大部分普通遭遇战：

进入：

# **单独 Arena**

但 Arena 不一定是一个很小的正方形房间。

希望可以：

# **横向拉得比较长**

类似：

* Long Room  
* Corridor  
* 长走廊  
* 长战斗区域

给玩家足够：

* 移动  
* 拉扯  
* 推进  
* 使用技能

的空间。

---

普通流程：

**Exploration**

↓

**Random / Scripted Encounter**

↓

**Arena**

↓

击败敌人

↓

**Return to Exploration**

---

# **43\. Dungeon Battle Structure**

某些：

* 副本  
* 特殊剧情  
* 重要战斗区域

会采用：

# **Multi-Room Combat**

例如：

**Room 1**

↓

**Room 2**

↓

**Room 3**

↓

**Boss Room**

这种结构更接近 DNF-style Dungeon。

---

# **44\. Boss Arena**

Boss 可以拥有：

# **Dedicated Boss Room / 专属 Boss 战斗地图**

Boss Room 可以拥有：

* 特殊环境  
* 特殊演出  
* 特殊机制  
* 独立视觉设计

具体以后设计。

---

# **45\. World Setting / 世界观**

游戏采用：

# **Semi-Fictional Wuxia World / 半架空武侠世界**

不是完全真实历史。

也不是完全脱离中国历史文化的幻想世界。

---

整体会参考：

* 中国古代社会  
* 城市结构  
* 建筑  
* 服饰  
* 武器  
* 江湖文化  
* 社会阶级  
* 交通  
* 日常生活

但是：

会创作自己的：

* 朝代  
* 世界历史  
* 城市  
* 角色  
* 势力  
* 门派  
* 事件

---

由于开发者目前并不深入了解真实中国古代历史：

正式进行世界观创作之前：

需要先进行一定：

# **Historical Research**

然后从真实历史中提取：

适合游戏的：

* 美术元素  
* 社会结构  
* 文化背景  
* 生活方式

再进行架空设计。

---

具体主要参考哪个真实时代：

# **TBD**

---

# **46\. Factions & Sects / 门派与江湖势力**

世界中会存在：

* 门派  
* 世家  
* 帮派  
* 其他江湖组织  
* 不同势力

这些组织是武侠世界的重要组成部分。

---

玩家与门派之间：

希望具有：

# **较高自由度**

长期目标倾向于：

玩家可以：

* 接触不同门派  
* 与不同门派建立关系  
* 根据自己的选择影响关系  
* 学习相关武学  
* 参与不同势力剧情

---

# **47\. Joining a Sect / 加入门派**

这里目前存在两个都可以接受的方向。

## **Option A**

玩家可以：

# **正式加入自己选择的门派**

可能获得：

* 门派身份  
* 门派剧情  
* 门派武学  
* 门派任务  
* 特殊关系

---

## **Option B**

玩家：

# **保持独立身份**

但是仍然可以：

* 深入参与不同门派剧情  
* 与门派人物建立关系  
* 学习他们的武学  
* 做出影响关系的选择

---

目前：

# **A / B 均可**

具体实现：

# **TBD**

核心原则是：

# **Player Freedom / 玩家自由度优先**

---

# **48\. Demo Scope vs Full Game Vision**

虽然完整版游戏可以长期加入：

* 更多门派  
* 更多武器  
* 更多地图  
* 更多技能  
* 更多系统  
* 大世界  
* 更多人物

但是：

半年 Steam Demo 不需要一次性实现全部长期愿景。

尤其门派系统等复杂内容：

Demo 可以先：

* 展示部分势力  
* 让玩家认识世界  
* 建立未来可扩展结构

不需要为了证明“自由度很高”在半年内制作大量完整分支。

---

# **49\. Current Confirmed Combat Summary**

目前 Combat Core 可以快速总结为：

### **Real-Time Action Combat**

### **Three-Axis Battle Space**

### **One Controllable Protagonist**

### **One Weapon / One Build Per Battle**

### **Normal Attack / Combo**

### **Block**

### **Guard Meter**

### **Guard Break**

### **Special Telegraph Attacks**

### **Perfect Parry**

### **Dodge Charges**

### **Dodge Cancel**

### **Perfect Dodge**

### **Approximately 3 Active Skills**

### **Skill Cooldowns**

### **No Qi Resource**

### **Talent Tree**

### **Combat Meter**

### **Respec Outside Combat**

### **Companion Assist Instead of AI Party**

### **Normal Arena \+ Multi-Room Dungeon**

---

# **50\. Current Confirmed Exploration Summary**

目前 Exploration Core：

### **Independent Exploration Scenes**

### **HD-2D / 2.5D Visual**

### **XYZ World Space**

### **Walk**

### **Run**

### **Mixed Encounter**

### **Mostly Hidden / Random Encounters**

### **Scripted Battles**

### **NPC Encounters**

### **Ambushes**

### **Separate Battle Scenes**

### **Contextual Vertical Exploration Possible**

---

Jump：

# **TBD**

Double Jump：

# **TBD**

Full Qinggong System：

# **Not Planned Currently**

---

# **51\. Important TBD List**

以下内容目前不能被 Claude 自动当作正式设定。

## **World Map Format**

TBD

## **Exploration Jump**

TBD

## **Double Jump**

TBD

## **Rooftop Traversal Implementation**

TBD

## **Combat Jump**

TBD

## **Dodge Visual Form**

Dash / Roll / Quick Step 等 TBD

## **Perfect Dodge Bullet Time**

TBD

## **Dodge Charge Count**

TBD

## **Guard Values**

TBD

## **Guard Break Duration**

TBD

## **Combat Meter Final Name**

TBD

## **Combat Meter Full Effect**

Ultimate / Burst / Talent-dependent 等 TBD

## **Exact Weapon Types**

TBD

只确定约 2～3 个流派。

## **Exact Skill Count**

目标约 3 个，未来可以微调。

## **Talent Tree Details**

TBD

## **Respec Cost / Restriction**

TBD

## **Historical Reference Period**

TBD

## **Sect Joining System**

A / B TBD

## **Detailed Main Story**

尚未正式设计。

## **Detailed World Lore**

尚未正式设计。

## **Exact Steam Demo Content**

仍需继续设计。

---

# **52\. Design Philosophy / 设计原则**

这个项目后续做任何设计时，都应该优先考虑下面几个原则。

## **1\. Quality Over Quantity**

宁可：

地图少一点

敌人少一点

技能少一点

但是：

* 美术更完整  
* 战斗更顺  
* 剧情更好  
* UI 更完整  
* 玩家体验更像正式游戏

---

## **2\. Solo Developer Reality**

任何系统都应该考虑：

> 一个人能不能在半年内做出来？

如果某个系统需要：

* 大量 AI  
* 大量动画  
* 大量角色美术  
* 大量特殊逻辑

但是对玩家核心体验提升有限：

应该优先简化。

Companion Assist System 就是这个原则的例子。

---

## **3\. Story \+ Combat \+ Art**

项目最核心不是单独追求：

最复杂 RPG 系统。

而是让：

# **剧情**

# **战斗**

# **美术**

三个部分共同达到高完成度。

---

## **4\. Build Depth Without Excessive Complexity**

战斗需要具有：

* 武器流派  
* Talent Tree  
* Skill Choice  
* Parry  
* Dodge  
* Combat Meter

产生一定研究空间。

但不希望因为 RPG 系统过多而出现：

* Qi  
* Mana  
* 过多资源条  
* 十几个战斗按钮  
* 同时控制多个角色

导致 Combat 变得混乱。

---

## **5\. Player Control Should Feel Responsive**

玩家应该尽量感觉：

角色一直处于自己控制之下。

因此目前已经考虑：

# **Dodge Cancel**

避免攻击动画把玩家长时间锁死。

Parry Window 也不应该过分苛刻。

---

# **53\. Claude Project Instructions**

Claude 在帮助开发这个项目时：

1. 应该把本文件作为当前游戏设计基础。  
2. 不要把自己的建议自动视为正式设计。  
3. 如果提出新功能，应先标记为：  
   * Proposed  
   * TBD  
4. 只有用户明确确认以后，才能改为：  
   * Confirmed  
5. 如果新设计与本文件已有设计冲突，应先指出冲突，而不是直接覆盖。  
6. 应持续考虑：  
   * 半年开发周期  
   * Solo Developer  
   * Steam Demo  
   * 高完成度目标  
7. 不应该为了增加“武侠感”自动加入大量复杂系统。  
8. 不应该自动恢复已经放弃的设计，例如：  
   * Qi Resource  
   * Heavy Attack  
   * 常驻 AI Party  
9. 应优先帮助项目保持：  
   * Scope 可控  
   * 系统清晰  
   * 战斗爽快  
   * 剧情吸引人  
   * 美术统一  
10. 本项目不是一次性的 Student Prototype，而是希望未来持续开发的正式游戏项目。

