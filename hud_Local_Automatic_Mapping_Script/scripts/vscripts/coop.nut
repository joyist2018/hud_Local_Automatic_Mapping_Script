 /*	hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
	设置HUD界面位置预设参数：
	HUD_RIGHT_TOP - 屏幕正中右上
	HUD_RIGHT_BOT - 屏幕正中右下
	
	HUD_MID_TOP - 屏幕正中上
	HUD_MID_BOT - 屏幕正中下
	
	HUD_LEFT_TOP - 屏幕正中左上
	HUD_LEFT_BOT - 屏幕正中左下
	
	HUD_TICKER - 屏幕正中(准心处)
	
	HUD_FAR_LEFT - 屏幕左上角
	HUD_FAR_RIGHT - 屏幕右上角


	hudtip.AddFlag(g_ModeScript.HUD_FLAG_PRESTR); 这是HUD界面的代码
	设置HUD界面参数，如需添加多条参数只需加上|即可
	例如：HUD_FLAG_BLINK|HUD_FLAG_NOBG(文字闪烁|不绘制背景框)
	参数-原文：
	HUD_FLAG_NOBG - 不要为这个UI元素绘制背景框
	HUD_FLAG_PRESTR/POSTSTR - 是否希望字符串string/value值对以静态字符串开始（pre前）或结束（POST后）（默认为PRE）
	HUD_FLAG_BEEP - 让计时器倒数闪烁
	HUD_FLAG_BLINK - 你想让这个字段闪烁吗
	HUD_FLAG_ALLOWNEGTIMER - 认情况下，计时器在0:00停止，以避免在网络上短暂变为负值，这样就不会发生这种情况 
	HUD_FLAG_SHOW_TIME - 将此浮点值视为时间 (i.e. --:--) 而不是浮动值
	HUD_FLAG_NOTVISIBLE - 如果您想保留slot槽位数据，但又不让它显示
	HUD_FLAG_ALIGN_LEFT - 左对齐此文本
	HUD_FLAG_ALIGN_CENTER - 中心对齐此文本
	HUD_FLAG_ALIGN_RIGHT - 右对齐此文本
	HUD_FLAG_TEAM_SURVIVORS - 仅向幸存者团队展示
	HUD_FLAG_TEAM_INFECTED - 仅向特殊感染团队显示
	HUD_FLAG_AS_TIME -无注解
*/

IncludeScript("VSLib");
IncludeScript("SetMapName");
IncludeScript("MapData");


::IsSurvivorsDeathCount <- 0;
::IsInfectedDeathCount <- 0;
::IsZombieDeathCount <- 0;

::GetInfectedName <- {};
::HeadShotNum <-{};
::KillNum <-{};
::KillCount <-{};
::_HeadShot <-{};
::Kill_InfectedNum <-{};
::DeathNum <-{};
::TongueGrab <-{};
::LungePounce <-{};
::DmgTankHealth <-{};
::ClientKillNum <-{};
::KillNum_PlayerRank <-{};
::DmgTank_PlayerRank <-{};
::JockeyRide <-{};
::LedgeGrabNum <-{};
::ChargerPummel <-{};
::ReviveNum <-{};
::PillsUsed <-{};
::HealNum <-{};
::AdrenalineUsed <-{};
::DoorOpenNum <-{};
::DoorCloseNum <-{};
::DefibrillatorNum <-{};
::GetTankHealth <-{};
::StartPlaying <- {};
::CirculatePlay <- {};
::PlayerTake <- {};
::HeGrenadesType <- {};
::Fov <- {};
::ProtectOff <- 0;
::IsFinaleWin <- 0;
::SurvivorsModel <-
{
   Coach = "models/survivors/survivor_coach.mdl",
   Ellis = "models/survivors/survivor_mechanic.mdl",
   Nick = "models/survivors/survivor_gambler.mdl",
   Rochelle = "models/survivors/survivor_producer.mdl",
   Zoey = "models/survivors/survivor_teenangst.mdl",
   Francis = "models/survivors/survivor_biker.mdl",
   Louis = "models/survivors/survivor_manager.mdl",
   Bill = "models/survivors/survivor_namvet.mdl"
}
::KillRank_Off <- 0; //幸存者杀敌排行榜 0=关闭 1=开启
::KillRank_Type <- 3; //设置杀敌排行榜统计数据 1=仅统计特感 2=仅统计丧尸 3=两者都统计
::GetKillRankType <- []; //获取统计数据名称
::Show_TankRank <- 0; //检查坦克死亡伤害是否正在显示，切勿修改
::RoundStart_ShowInfo <- 0; //检查回合开始提醒信息是否正在显示，切勿修改
::_Timer <- 0; //杀敌排行榜计时器，切勿修改

::AutoChangeMap_Off <- 1; //0=关闭官方自动换图 1=开启官方自动换图
::TimerMax <- 0; //计时器参数，切勿修改
::AutoChange <- 0; //条件参数，切勿修改
::IsRoundEnd <- 1; //救援关逃离失败后启动自动换图 0=不启动 1=启动

/* 在救援关显示救援车辆到达信息 */
::ShowFinaleVehicleInfo_Off <- 1; //0=关闭 1=显示

/* 显示幸存者重生时间 */
::AotoRescue_Off <- 1; //是否启用幸存者自动复活 0=否 1=是
::ShowRescueTime_Off <- 1; //是否显示重生时间 0=否 1=是
::GetRescueTime <- {};
::RescueTimer <- {};
::SurvivorCallForHelp <- {};
::_ShowRescueTime <- {};

/*	自动恢复幸存者Hp 
*	开启指令：!gongneng 2
*	再输一次可关闭
*/
::RegeneratesHP <- {};
::SetHealthValue <- 20; //当幸存者Hp(含虚血)小于或等于该值时，自动恢复Hp
::SetRegeneratesHP <- 100; //设置恢复多少Hp

/*	爆头特感声音，0=关闭  1=开启
*	当玩家爆头特感时，根据玩家扮演的角色播放相对应的声音 
*/
::HeadShotSound <- 1; //0=关闭 1=开启

/*	击杀特感声音，0=关闭  1=开启
*	当玩家击杀特感时，根据玩家扮演的角色播放相对应的声音 
*/
::KillSound <- 1; //0=关闭 1=开启

/*	击杀|爆头特感——特殊HUD提示 
*	开启指令：!hud 1
*/
::KillOrHeadShot_HUD <- 4; //0=关闭 1=图标 2=条形 3=圆形 4=回合开始随机选择123
::Random_HUD <- 0; //随机选择参数，切勿修改

/* 设置丧尸大小，最小(0.5) 最大(2.5)*/
::_Scale <- 1.5;
/*	丧尸死亡射线 
*	相当于自动机器人
*	指令：!baohu
*/
::DebugDrawLine_ParticleMap <- 2; //射线仅在哪些地图启用 0=关闭 1=官方地图 2=任何地图
::_DamageFrom <- 200; //射线攻击范围
::_Damage <- 100; //射线伤害值
::SetUseName <- "高须龙儿"; //设置指定玩家名称，如你在游戏中名称是"某某"，只有"某某"才可使用该指令

/* 特感死亡显示一条细线 */
::DebugDrawLine_AddParticleMap <- 2; //细线仅在哪些地图显示 0=关闭 1=官方地图 2=任何地图
::ShowDebugDrawLine_Time <- 3.0; //细线停留时间

/* 坦克防卡 */
::NewTank <- 0;
::SetNewTankHealth <- 0;

/* 坦克出现声音、闪屏、震动、慢动作 */
::TankSpawnSound <- 2; //0=关闭 1=坦克怒吼 2=随机幸存者声音
::FadeScreenOff <- 0; //0=关闭 1=开启闪屏
::ShakeScreenOff <- 0; //0=关闭 1=开启震屏
::TankSlowTime_Off <- 1; //0=关闭 1=开启慢动作
::TankNum <- 0; //获得坦克同时产卵数量

/*	升级激光瞄准器 
*	升级指令：!jg
*/
::UpgradeLaserSight_Off <- 1; //0=关闭 1=开启

/* 幸存者杀死特感随机给予或产卵物品(除Witch) */
::GiveOrSpawnOff <- 2; //0=关闭给予或产卵物品  1=自动给予幸存者随机物品 2=特感死亡产卵随机物品 3=随机选择1.2
::GiveOrSpawnProbability <- 10; //给予或产卵物品概率(1, 100)
::GetGiveItemsName <- []; //获得给予物品名称
::GetSpawnItemName <- []; //获得产卵物品名称


/* 聊天栏循环广告 */
::Simple_Advertising_Off <- 1; //0=关闭 1=开启
::Simple_Advertising_Time <- 15; //发送广告间隔时间
::Simple_Advertising_Num <- 0; //广告循环参数，切勿修改
::Simple_Advertising_AdsTime <- 0; //计时参数，切勿修改
//设置广告词
::SimpleAdvertising<-function()
{
	/* 如需新增广告，请参考以下格式写入 */
	local GetSimpleAdvertising = [];
	Simple_Advertising_Num++;
	
	local GetHostName = Convars.GetStr("hostname");

	if(Simple_Advertising_Num == 1) //广告1
	{
		GetSimpleAdvertising = "欢迎来到本房间，祝您游戏愉快";
	}
	if(Simple_Advertising_Num == 2) //广告2
	{
		if(Convars.GetStr("survivor_allow_crawling") == "0")
		{
			GetSimpleAdvertising = "已关闭倒地爬行！已关闭倒地爬行！";
		}
		if(Convars.GetStr("survivor_allow_crawling") == "1")
		{
			GetSimpleAdvertising = "已开启倒地爬行！已开启倒地爬行！";
		}
	}
	if(Simple_Advertising_Num == 3) //广告3
	{
		GetSimpleAdvertising = "文明游戏！注意素质！游戏愉快！";
	}
	if(Simple_Advertising_Num == 4) //广告4 导演特感参数提醒，如已删除 DirectorOptions <- 导演参数，这也要删除
	{
							 //预览：特感刷新：30秒内刷出3特感(最小5秒 最大30秒)
		GetSimpleAdvertising = "特感刷新："+DirectorOptions.cm_SpecialRespawnInterval+"秒内刷出"+DirectorOptions.cm_MaxSpecials+"特感(最小"+DirectorOptions.SpecialInitialSpawnDelayMin+"秒 最大"+DirectorOptions.SpecialInitialSpawnDelayMax+"秒)";
	}
	if(Simple_Advertising_Num == 5) //广告5 导演特感参数提醒，如已删除 DirectorOptions <- 导演参数，这也要删除
	{
							 //预览：特感限制：Smoker.2-Boomer.2-Hunter.2-Spitter.2-Jockey.2-Charger.2
		GetSimpleAdvertising = "特感限制："+"Smoker."+DirectorOptions.SmokerLimit+"-"+"Boomer."+DirectorOptions.BoomerLimit+"-"+"Hunter."+DirectorOptions.HunterLimit+"-"+"Spitter."+DirectorOptions.SpitterLimit+"-"+"Jockey."+DirectorOptions.JockeyLimit+"-"+"Charger."+DirectorOptions.ChargerLimit;
	}
	if(Simple_Advertising_Num == 6) //广告6
	{
		if(Convars.GetStr("z_witch_always_kills") == "0")
		{
			GetSimpleAdvertising = "秒杀女巫散弹枪最合适，狂虐女巫燃烧瓶最痛快";
		}
		if(Convars.GetStr("z_witch_always_kills") == "1")
		{
			GetSimpleAdvertising = "女巫一击必杀！女巫一击必杀！女巫一击必杀！";
		}
	}
	if(Simple_Advertising_Num == 7) //广告7
	{
		GetSimpleAdvertising = "拒绝装逼！拒绝跑图！拒绝捣乱！";
	}
	if(Simple_Advertising_Num == 8) //广告8
	{
		Simple_Advertising_Num = 0;
		GetSimpleAdvertising = "欢迎来到本房间，祝您游戏愉快";
	}
	
	return GetSimpleAdvertising;
}


/* 显示信息 */
::ShowInfo_Type <- 1; //0=不显示信息  1=聊天栏显示  2=HUD显示  3=1.2都显示
/* 特感或人类生命显示 - 小字显示在模型头部位置 */
::TRDebugDrawText_Off <- 0; //0=不显示  1=显示
/* 小僵尸生命显示 - 小字显示在模型脚底位置 */
::JZDebugDrawText_Off <- 0; //0=不显示  1=显示

/* Witch出现提醒 */
::WitchSpawnInfo <- 0; //提醒信息
::WitchSpawn <- 0; //Witch出现次数
::Witchid <- 0; //获得Witch ID

/*  设置Witch死亡触发哪些事件
*	0=关闭触发事件
*	1=触发丧尸快攻事件  
*	2=触发坦克产卵事件
*	3=触发无限尸潮和坦克，即最后一关救援抵达(背景音乐响起)
*	4=随机触发1.2.3
*	5=触发团灭事件，本回合重来，并非处死全部幸存者，仅触发团灭事件
*/
::WitchDeath_TriggerEventType <- 1;

/*		设置【丧尸快攻】参数		*/
::TriggerEvent_ZombieMax <- 15; //【丧尸快攻】总刷新次数，可修改
::TriggerEvent_Zombie <- 0; //刷新次数，切勿修改，当该值 >= TriggerEvent_ZombieMax 时停止刷新
::CommonSpawnMax <- 30;//【丧尸快攻】产卵丧尸数量
::CommonSpawnLocation_Min <- 300.0; //【丧尸快攻】产卵丧尸最小范围
::CommonSpawnLocation_Max <- 1000.0; //【丧尸快攻】产卵丧尸最大范围
::Mychainsaw <- {}; //给予随机玩家特殊电锯，无限燃料

//设置触发丧尸快攻概率(1, 100)
::TriggerEvent_Panic <- 10;
//设置触发坦克产卵概率(1, 100)
::TriggerEvent_Tank <- 10;
//设置触发无限尸潮和坦克概率(1, 100)
::TriggerEvent_Escape <- 5;
//设置触发团灭事件概率(1, 100)
::TriggerEvent_Results <- 5;
//触发时慢动作
::WitchSlowTime_Off <- 1; //0=关闭 1=开启


/*	是否关闭防盗汽车里的闪烁灯光？就是那辆会触发尸潮的汽车
*	关闭之后不影响触发尸潮，只是车辆驾驶室不再发出红色闪烁光
*	但是当幸存者站在这辆车旁边开火时，车辆还是会发出警报的
*/
::CarAlarms_Off <- 1; //0=否 1=是

/* 幸存者获得物品提示 */
::PlayerTankInfo <- 1; //0=关闭 1=开启

/* 幸存者协助队友奖励——血量 */
::ProtectInfo <- 1; //是否开启奖励血量 0=否 1=是
::Protect_AddHealth <- 5; //奖励多少血量
::Protect_ShowHUD <- 1; //HUD提示 0=关闭 1=开启

/* 玩家误伤队友(不含电脑)——踢出 */
::_SetDmgMax <- 999; //设置误伤队友的伤害值，当误伤值超过该值时弹出警告
::_SetWarningMax <- 10; //设置警告次数，当警告次数超过该值时自动踢出玩家
::FadeScreen_Off <- 1; //0=关闭 1=开启射击队友闪屏
::ClientDmgHealth <- {};
::WarningClient <- {};
/* 玩家误杀队友(不含电脑)——踢出 */
::_SetkillNum <- 2; //设置误杀队友次数，当误杀值超过该值时踢出
::ClientkillMax <- {};

/*	安全门警告，防止玩家频繁开/关安全门
*	当玩家开/关次数>=SafeDoor_Num时，自动处死
*	Ps：如果开启，请设置 AotoRescue_Off 为 0
*/
::SafeDoor_Off <- 1; //0=关闭警告 1=开启警告
::SafeDoor_Num <- 8; //设置次数

/* 玩家倒汽油参数，即救援关需要幸存者倒汽油 */
::Completed_Num <- 0; //玩家已倒完汽油桶次数

/* 安全门——路程 */
::SaferoomLocation_Off <- 1; //0=关闭 1=开启
::_GetSaferoomLocation <- 0.0;
::GetSaferoomNum <- 0;
::last_set <- 0;
::FirstPlayer <- 0;
::PlayerLimit <- 0;
::GetFirstPlayerName <- [];

/* 当幸存者死亡时，是否产卵虚拟模型(0=否 1=是) */
::SpawnCommentaryDummy_Off <- 1;
//产卵虚拟模型概率(1, 100)
::SpawnCommentaryDummy_Probability <- 100;

/* 删除地图上的物品参数(0=否 1=是) */

//是否删除地图上所有补给箱
::DelFootLockers_Off <- 0;

//是否删除地图上共同产卵位置(机器翻译)
//原文：Removes common spawn locations.
::DelZombieSpawns_Off <- 0;

//是否删除地图上所有迷你机枪
::DelMiniguns_Off <- 0;

//是否删除地图上所有医疗补给：医疗包、止痛药、肾上腺素、电击器
::DelUnheldMeds_Off <- 0;

//是否删除地图上所有Items补给：胆汁、土质炸弹、燃烧瓶、武器升级包
::DelUnheldItems_Off <- 0;

//是否删除地图上所有副武器
::DelUnheldSecondary_Off <- 0;

//是否删除地图上所有主武器
::DelUnheldPrimary_Off <- 0;

//是否删除地图上全部武器(主副)
::DelUnheldWeapons_Off <- 0;

//是否删除地图上全部项目(主副武器、投掷类、药品、升级包、弹药堆)
::DelAllUnheldWeapons_Off <- 0;

/* 设置枪支后备子弹数量 */
Convars.SetValue("ammo_smg_max", "1000"); //冲锋枪
Convars.SetValue("ammo_shotgun_max", "1000"); //二代连喷
Convars.SetValue("ammo_autoshotgun_max", "1000"); //一代连喷
Convars.SetValue("ammo_huntingrifle_max", "1000"); //一代连阻
Convars.SetValue("ammo_sniperrifle_max", "1000"); //阻击枪
Convars.SetValue("ammo_assaultrifle_max", "1000"); //步枪
Convars.SetValue("ammo_grenadelauncher_max", "100"); //榴弹枪
/* 设置幸存者相关参数 */
Convars.SetValue("z_survivor_respawn_health", "100"); //重生血量，默认50Hp
Convars.SetValue("survivor_revive_duration", "5"); //拉人时间，默认5秒
Convars.SetValue("first_aid_kit_use_duration", "5"); //打包时间，默认5秒
Convars.SetValue("first_aid_heal_percent", "1"); //打包恢复血量百分比，1=100Hp 默认0.8
Convars.SetValue("survivor_allow_crawling", "1"); //倒地爬行 0=关闭 1=开启
Convars.SetValue("survivor_crawl_speed", "75"); //倒地爬行速度，默认15
Convars.SetValue("survivor_crouch_speed", "75"); //蹲下移动速度，数值越高越快，默认75
/* 友伤，0=关闭 1=默认 */
Convars.SetValue("survivor_friendly_fire_factor_easy", "0"); //简单 默认0
Convars.SetValue("survivor_friendly_fire_factor_normal", "0"); //普通 默认0.1
Convars.SetValue("survivor_friendly_fire_factor_hard", "0"); //高级 默认0.3
Convars.SetValue("survivor_friendly_fire_factor_expert", "0"); //专家 默认0.5
/* 火伤，0=关闭 1=默认 */
Convars.SetValue("survivor_burn_factor_easy", "0");  //简单 默认0.2
Convars.SetValue("survivor_burn_factor_normal", "0"); //普通 默认0.2
Convars.SetValue("survivor_burn_factor_hard", "0"); //高级 默认0.4
Convars.SetValue("survivor_burn_factor_expert", "0"); //专家 默认1
/* 感染设置 */
Convars.SetValue("z_acquire_far_range", "2500"); //丧尸看到幸存者范围，默认2500
Convars.SetValue("z_acquire_far_time", "1.0"); //丧尸看到幸存者之后反应，默认5.0秒
Convars.SetValue("z_must_wander", "1"); //丧尸游走 0=默认 1=徘徊(不坐不躺) 2=徘徊坐下或躺下
/* 其他设置 */
Convars.SetValue("z_difficulty", "Impossible"); //Easy =简单  Normal =普通  Hard =高级  Impossible =专家
Convars.SetValue("crosshair", "1"); //准心 0=关闭 1=开启
Convars.SetValue("sv_consistency", "1"); //是否检查文件一致 0=否 1=是

/* 设置药品产卵数量 */
::MedicalSupplies_Off <- 1; //0=关闭 1=开启
::_MedicalCount <- 4; //产卵数量
::Time_MedicalSupplies <- 0;

/* 自动挣脱，即杀死特感，只对玩家有效 */
::AotoFlounce_Off <- 1; //0=关挣脱 1=开挣脱
::GetVictimId <- 0; //获得受害者ID
::GetAttackerId <- 0; //获得攻击者ID
::_FlounceTime <- 5.0; //设置多少秒后杀死特感

/* 保存游戏运行时间 */
::Win_ResetGameRunTime <- 0; //每当在救援关幸存者成功逃离时重置运行时间数据 0=关闭 1=启用
::SetGameRunTimeShow <- 1; //设置运行时间显示 1=一直显示 2=间隔显示
::SetInterval <- 30; //设置"间隔显示"时间
::GetRunTime <- {};
::saferached <- false;
::CheckPointDoor <- false;
::NewYear <- 0;
::NewMonth <- 0;
::NewDay <- 0;
::NewHours <- 0;
::NewMinutes <- 0;
::NewSeconds <- 0;

/* 保存总回合时间，每当救援关成功逃离时重置总回合时间 */
::TotalGameTime <- {};
::TotalGameTimeHours <- 0;
::TotalGameTimeMinutes <- 0;
::TotalGameTimeSeconds <- 0;
::TotalGameRestart <- 0;

/*	保存本张地图死亡总数，每当救援关成功逃离或新地图开始时重置死亡总数 
*	也可以使用指令[!gongneng 5]立即重置死亡总数
*/
::TotalDeathNum <- {};
::TotalDeathNum_Survivors <- 0;
::TotalDeathNum_Infection <- 0;
::TotalDeathNum_Zombie <- 0;

/* 重置总回合或运行时间 */
::GetRunTime_Seconds <- 0;
::GetRunTime_Minutes <- 0;
::GetRunTime_Hours <- 0;

/* =====================================================================================
*	根据用户ID(数字)来保存升级数据，由于ID是不固定的，所以不能准确读取玩家升级数据
*	查看用户ID：建房进入游戏后，控制台输入 users
*	例如：
	users
	<slot:userid:"name">
	0:2:"玩家名" —— "我"在游戏里的ID是2
	1:3:"Rochelle" —— 电脑ID 3
	2:4:"Ellis" —— 电脑ID 4
	3:5:"Coach" —— 电脑ID 5

*	ID不固定：当玩家首次进入房间时Ta的ID是2，之后Ta退出房间
*	当Ta再次进入房间时Ta的ID可能会变成其他数字
*	只要玩家不退出房间，Ta的ID是不会发生变化
*	有一个方法可准确读取玩家数据，就是使用玩家名称读取数据，但是这方法会导致控制台报错
*	因为玩家名称不能含有中文或标点符号。
*	如果你是房主可使用此方法来保存你个人数据，前提是不要使用含中文或标点符号的名称
*	先在脚本里搜索"某某"设置指定玩家名称，然后就可保存你个人数据了
* =====================================================================================
* 保存玩家升级数据 */
::UpgradeOff <- 1; //是否启用升级系统 0=否 1=是
::KillJockey_GetExp <- 200; //击杀Jockey获得经验
::KillHunter_GetExp <- 250; //击杀Hunter获得经验
::KillCharger_GetExp <- 400; //击杀Charger获得经验
::KillSmoker_GetExp <- 200; //击杀Smoker获得经验
::KillSpitter_GetExp <- 200; //击杀Spitter获得经验
::KillBoomer_GetExp <- 150; //击杀Boomer获得经验
::KillTank_GetExp <- 1000; //击杀Tank获得经验
::KillWitch_GetExp <- 700; //击杀Witch获得经验
::KillZombie_GetExp <- 5; //击杀Zombie获得经验
::KillSurvivor_LoseExp <- 1000; //击杀幸存者(非bot)扣除经验
::Survivor_ReviveTeammate <- 200; //拉起幸存者获得经验值
::Survivor_ReanimateTeammate <- 500; //电击幸存者获得经验值
::Survivor_HealTeammate <- 300; //治愈幸存者获得经验值
::SurvivorIncapped_LoseExp <- 10; //幸存者(非bot)倒下扣除经验值系数: (现有等级*5)*系数
::SurvivorDeath_LoseExp <- 20; //幸存者(非bot)死亡扣除经验值系数: (现有等级*5)*系数
::UpgradeMax <- 999; //设置升级上限
::UpgradeRate <- 500; //设置升级Exp系数: 升级=升级系Exp数*(当前等级+1)
::SavedUpgrade <- {}; //获取升级数据文件
::GetExp <- 0; //获取经验值
::NewExp <- 0; //获取升级经验值
::ExperiencePercent <- {}; //获取剩余经验百分比

/*	设置幸存者(玩家)生命上限，加上原先100Hp
*	每当玩家升级时，在原先100Hp上再加10点血量
*	原先100Hp + 加血上限 = 玩家血量
*/
::_SetHealthMax <- 200; //设置加血上限
::_SetHealth <- {};

/*	设置幸存者(玩家)力量上限
*	每当玩家升级时加1点力量
*	原先伤害 + 力量上限 = 实际伤害
*	Ps：特感生命将根据玩家力量变化而增减
*/
::_SetHurtMax <- 20; //设置力量上限
::HurtRandom <- 5; //设置特感生命倍数：(玩家力量x生命倍数)+随机数 = 特感生命

::UpgradeIdx <- {
	Lv = "Lv"
	Exp = "Exp"
	Hp = "Hp"
	Hurt = "Hurt"
}
::SetUpgradeKV <- function (player, keyIdx, value)
{
	local steamid = [];
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
		
	if(Player(player).GetName() != SetUseName)
	{
		steamid = Player(player).GetUserID();
	}
	if(Player(player).GetName() == SetUseName)
	{
		steamid = Player(player).GetName();
	}
	if (!steamid) return;
	
	if (!(steamid in ::SavedUpgrade))
	{
		::SavedUpgrade[steamid] <- {};
	}
	
	::SavedUpgrade[steamid][keyIdx] <- value;
}
::GetUpgradeKV <- function (player, keyIdx)
{
	local steamid = [];
	
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
	
	if(Player(player).GetName() != SetUseName)
	{
		steamid = Player(player).GetUserID();
	}
	if(Player(player).GetName() == SetUseName)
	{
		steamid = Player(player).GetName();
	}
	if (!steamid) return;
	
	if (!(steamid in ::SavedUpgrade))
	{
		::SavedUpgrade[steamid] <- {};
	}
	
	if (!(keyIdx in ::SavedUpgrade[steamid]))
		::SavedUpgrade[steamid][keyIdx] <- 0;
	
	return ::SavedUpgrade[steamid][keyIdx];
}
::AddZombieExpKV <- function (player)
{
	NewExp = GetUpgradeKV(player, UpgradeIdx.Exp) + KillZombie_GetExp;
	if(NewExp >= UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1))
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
		local Upgrade = GetUpgradeKV(player, UpgradeIdx.Lv) + 1;
		local AddHealth = GetUpgradeKV(player, UpgradeIdx.Hp) + 10;
		local AddHurt = GetUpgradeKV(player, UpgradeIdx.Hurt) + 1;
		if(AddHurt <= _SetHurtMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hurt, AddHurt);
		}
		if(AddHealth <= _SetHealthMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hp, AddHealth);
			Entity(player).SetMaxHealth(AddHealth+100);
		}
		if(Upgrade <= UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, Upgrade);
			Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
			local Info = "升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级";
			Player(player).ShowHint(Info, 8, "zombie_team_hunter_ghost", "", HUD_RandomColor());
		}
		if(Upgrade > UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Lv)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hurt)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hp)*0);
		}
	}
	else
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, NewExp);
	}
}
::AddWitchExpKV <- function (player)
{
	NewExp = GetUpgradeKV(player, UpgradeIdx.Exp) + KillWitch_GetExp;
	local New = UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1);
	ExperiencePercent[Entity(player).GetBaseIndex()] = NewExp.tofloat() / New.tofloat() * 100.0;
	if(NewExp >= UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1))
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"杀死Witch获得"+KillWitch_GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%)，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
		local Upgrade = GetUpgradeKV(player, UpgradeIdx.Lv) + 1;
		local AddHealth = GetUpgradeKV(player, UpgradeIdx.Hp) + 10;
		local AddHurt = GetUpgradeKV(player, UpgradeIdx.Hurt) + 1;
		if(AddHurt <= _SetHurtMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hurt, AddHurt);
		}
		if(AddHealth <= _SetHealthMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hp, AddHealth);
			Entity(player).SetMaxHealth(AddHealth+100);
		}
		if(Upgrade <= UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, Upgrade);
			Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
			local Info = "升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级";
			Player(player).ShowHint(Info, 8, "zombie_team_hunter_ghost", "", HUD_RandomColor());
		}
		if(Upgrade > UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Lv)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hurt)*0);
		}
	}
	else
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, NewExp);
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"杀死Witch获得"+KillWitch_GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%)，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
	}
}
::DefibrillatorUsed_AddExpKV <- function (player)
{
	local GetInfo = [];
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
	
	GetExp = Survivor_ReanimateTeammate;
	GetInfo = "电击队友";
	NewExp = GetUpgradeKV(player, UpgradeIdx.Exp) + GetExp;
	local New = UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1);
	ExperiencePercent[Entity(player).GetBaseIndex()] = NewExp.tofloat() / New.tofloat() * 100.0;
	if(NewExp >= UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1))
	{
		Player(player).Say("(玩家)"+GetInfo+"获得"+GetExp"Exp(100%)."+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
		SetUpgradeKV(player, UpgradeIdx.Exp, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
		local Upgrade = GetUpgradeKV(player, UpgradeIdx.Lv) + 1;
		local AddHealth = GetUpgradeKV(player, UpgradeIdx.Hp) + 10;
		local AddHurt = GetUpgradeKV(player, UpgradeIdx.Hurt) + 1;
		if(AddHurt <= _SetHurtMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hurt, AddHurt);
		}
		if(AddHealth <= _SetHealthMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hp, AddHealth);
			Entity(player).SetMaxHealth(AddHealth+100);
		}
		if(Upgrade <= UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, Upgrade);
			Player(player).Say("(玩家)升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
			local Info = "升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级";
			Player(player).ShowHint(Info, 8, "zombie_team_hunter_ghost", "", HUD_RandomColor());
		}
		if(Upgrade > UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Lv)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hurt)*0);
		}
	}
	else
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, NewExp);
		Player(player).Say("(玩家)"+GetInfo+"获得"+GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%)."+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
		local KillInfo = GetInfo+"获得"+GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%%)."+GetUpgradeKV(player, UpgradeIdx.Lv)+"级";
		Player(player).ShowHint(KillInfo, 15, "icon_info", "", HUD_RandomColor());
	}
}
::AddExpKV <- function (player, Type, target)
{
	local GetInfo = [];
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
	if(Type == 1)
	{
		if(Player(target).GetPlayerType() == Z_SPITTER)
		{
			GetExp = KillSpitter_GetExp;
			GetInfo = "击杀Spitter";
		}
		if(Player(target).GetPlayerType() == Z_HUNTER)
		{
			GetExp = KillHunter_GetExp;
			GetInfo = "击杀Hunter";
		}
		if(Player(target).GetPlayerType() == Z_JOCKEY)
		{
			GetExp = KillJockey_GetExp;
			GetInfo = "击杀Jocker";
		}
		if(Player(target).GetPlayerType() == Z_SMOKER)
		{
			GetExp = KillSmoker_GetExp;
			GetInfo = "击杀Smoker";
		}
		if(Player(target).GetPlayerType() == Z_BOOMER)
		{
			GetExp = KillBoomer_GetExp;
			GetInfo = "击杀Boomer";
		}
		if(Player(target).GetPlayerType() == Z_CHARGER)
		{
			GetExp = KillCharger_GetExp;
			GetInfo = "击杀Charger";
		}
		if(Player(target).GetPlayerType() == Z_TANK)
		{
			GetExp = KillTank_GetExp;
			GetInfo = "击杀Tank";
		}
	}
	if(Type == 2)
	{
		if(Player(target).GetPlayerType() == Z_SURVIVOR)
		{
			GetExp = Survivor_ReviveTeammate;
			GetInfo = "拉起队友";
		}
	}
	if(Type == 4)
	{
		GetExp = Survivor_HealTeammate;
		GetInfo = "治愈队友";
	}
	NewExp = GetUpgradeKV(player, UpgradeIdx.Exp) + GetExp;
	local New = UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1);
	ExperiencePercent[Entity(player).GetBaseIndex()] = NewExp.tofloat() / New.tofloat() * 100.0;
	if(NewExp >= UpgradeRate*(GetUpgradeKV(player, UpgradeIdx.Lv)+1))
	{
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+GetInfo+"获得"+GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%)，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
		SetUpgradeKV(player, UpgradeIdx.Exp, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
		local Upgrade = GetUpgradeKV(player, UpgradeIdx.Lv) + 1;
		local AddHealth = GetUpgradeKV(player, UpgradeIdx.Hp) + 10;
		local AddHurt = GetUpgradeKV(player, UpgradeIdx.Hurt) + 1;
		if(AddHurt <= _SetHurtMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hurt, AddHurt);
		}
		if(AddHealth <= _SetHealthMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Hp, AddHealth);
			Entity(player).SetMaxHealth(AddHealth+100);
		}
		if(Upgrade <= UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, Upgrade);
			Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
			local Info = "升级，当前"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级";
			Player(player).ShowHint(Info, 8, "zombie_team_hunter_ghost", "", HUD_RandomColor());
		}
		if(Upgrade > UpgradeMax)
		{
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Lv)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Exp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hp)*0);
			SetUpgradeKV(player, UpgradeIdx.Lv, GetUpgradeKV(player, UpgradeIdx.Hurt)*0);
		}
	}
	else
	{
		SetUpgradeKV(player, UpgradeIdx.Exp, NewExp);
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+GetInfo+"获得"+GetExp+"Exp("+ExperiencePercent[Entity(player).GetBaseIndex()].tointeger()+"%)，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
	}
}
::ReduceExpKV <- function (player, Type)
{
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;

	local GetReduceExp = 0;
	local ReduceExp = GetUpgradeKV(player, UpgradeIdx.Exp) - GetReduceExp;
	if(Type == 1)
	{
		GetReduceExp = KillSurvivor_LoseExp;
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"误杀队友，扣除-"+GetReduceExp+"/"+ReduceExp+"Exp，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级，生命"+Entity(player).GetHealth()+"Hp，力量"+GetUpgradeKV(player, UpgradeIdx.Hurt)+"级");
	}
	if(Type == 2)
	{
		GetReduceExp = GetUpgradeKV(player, UpgradeIdx.Lv)*5*SurvivorIncapped_LoseExp;
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"倒下，扣除-"+GetReduceExp+"/"+ReduceExp+"Exp，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级");
	}
	if(Type == 3)
	{
		GetReduceExp = GetUpgradeKV(player, UpgradeIdx.Lv)*5*SurvivorDeath_LoseExp;
		Utils.SayToAll("[-]"+"(玩家)"+Player(player).GetName()+"死亡，扣除-"+GetReduceExp+"/"+ReduceExp+"Exp，等级"+GetUpgradeKV(player, UpgradeIdx.Lv)+"级");
	}
	SetUpgradeKV(player, UpgradeIdx.Exp, ReduceExp);
}
/* 保存玩家数据 */
::_StatsMax <- 1000; //设置统计上限
::SavedStats <- {};
::StatIdx <- {
	KillInfection = "Infection"
	HeadshotInfection = "Headshot"
	KillZombie = "Zombie"
	HudInfo = "hud"
}
::SetStatKV <- function (player, keyIdx, value)
{
	local steamid = [];
	
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
		
	if(Player(player).GetName() != SetUseName)
	{
		steamid = Player(player).GetUserID();
	}
	if(Player(player).GetName() == SetUseName)
	{
		steamid = Player(player).GetName();
	}
	if (!steamid) return;
	
	if (!(steamid in ::SavedStats))
	{
		::SavedStats[steamid] <- {};
	}
	
	::SavedStats[steamid][keyIdx] <- value;
}
::GetStatKV <- function (player, keyIdx)
{
	local steamid = [];
	
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;
	
	if(Player(player).GetName() != SetUseName)
	{
		steamid = Player(player).GetUserID();
	}
	if(Player(player).GetName() == SetUseName)
	{
		steamid = Player(player).GetName();
	}
	if (!steamid) return;
	
	if (!(steamid in ::SavedStats))
	{
		::SavedStats[steamid] <- {};
	}
	
	if (!(keyIdx in ::SavedStats[steamid]))
		::SavedStats[steamid][keyIdx] <- 0;
	
	return ::SavedStats[steamid][keyIdx];
}
::IncreaseOrDecrease_StatKV <- function (player, keyIdx)
{
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;

	local Stats = GetStatKV(player, keyIdx) + 1;
	if(Stats <= _StatsMax)
	{
		SetStatKV(player, keyIdx, Stats);
	}
	if(Stats >= _StatsMax)
	{
		SetStatKV(player, keyIdx, GetStatKV(player, keyIdx)*0);
	}
}
::ResetStatKV <- function (player, keyIdx)
{
	if (Entity(player).IsBot())
		return;
	else if (!Player(player).IsPlayerEntityValid())
		return;

	SetStatKV(player, keyIdx, GetStatKV(player, keyIdx)*0);
}
/*	房名设置 
*	0=默认 
*	1=固定，搜索"固定房名"修改房名
*	2=跟随地图中文名
*	3=玩家人数+跟随地图中文名，例：4人在玩黑色嘉年华-第一站
*	4=随机房名
*/
::SetHostName_Off <- 4;
/*	设置随机房名 */
::RandomHostName <- function()
{
	local NewName = [];
	local Num = RandomInt(1, 20);
	
	if(Num == 1)
	{
		NewName = "风ペ流逝";
	}
	if(Num == 2)
	{
		NewName = "酸の果";
	}
	if(Num == 3)
	{
		NewName = "写゜ー爿眞惢";
	}
	if(Num == 4)
	{
		NewName = "ジ向你゛倾诉♂";
	}
	if(Num == 5)
	{
		NewName = "べ默守い";
	}
	if(Num == 6)
	{
		NewName = "花香沁人*飞舞";
	}
	if(Num == 7)
	{
		NewName = "'梦幻♂决影";
	}
	if(Num == 8)
	{
		NewName = "メ情花っ";
	}
	if(Num == 9)
	{
		NewName = "⑦ゾ仴╰☆╮ ";
	}
	if(Num == 10)
	{
		NewName = "丿灬若丶不离";
	}
	if(Num == 11)
	{
		NewName = "★脚吖♂";
	}
	if(Num == 12)
	{
		NewName = "? 爆脾气";
	}
	if(Num == 13)
	{
		NewName = "︶傻瓜。";
	}
	if(Num == 14)
	{
		NewName = "卜變↗訫";
	}
	if(Num == 15)
	{
		NewName = "々放空的瓶子";
	}
	if(Num == 16)
	{
		NewName = "こ微風初阳づ";
	}
	if(Num == 17)
	{
		NewName = "栺尖煙愺萫、";
	}
	if(Num == 18)
	{
		NewName = "今生无缘，来世再爱_";
	}
	if(Num == 19)
	{
		NewName = "Dr.也许";
	}
	if(Num == 20)
	{
		NewName = "灬╮幸运草";
	}
	
	return NewName;
}
/* 模式 */
::GetBaseModeName  <- []; //获取游戏模式名称
::ModelOption <- 1; //1=正常 2=特感速递 3=写实模式 4=猎头者 5=狩猎盛宴 6=骑乘派对 7=绝境求生 8=尸潮来袭 9=随机选择1.2.3.4.5.6.7.8
::ModelRandom <- RandomInt(1, 8); //随机参数，切勿修改
::GetModelOptionName <- []; //获取脚本模式名称
//尸潮来袭：丧尸将会发起群攻，特感只有Boomer(2)、Spitter(2)，5秒内刷出4只特感
//只对官方地图(除救援关)有效
::ZombieIncoming_Time <- 5; //设置每隔多少秒触发尸潮来袭
::ZombieIncoming_Off <- 0; //触发条件，即当特感出现时触发尸潮来袭

/* 环境 */
::Skyboxes_Type <- 0;
::Skyboxes <- [
   "sky_l4d_c2m1_hdr",
   "sky_l4d_night02_hdr",
   "sky_l4d_c4m1_hdr",
   "sky_l4d_c4m4_hdr",
   "sky_l4d_c6m1_hdr",
   "river_hdr",
   "docks_hdr",
   "sky_l4d_urban01_hdr",
   "test_moon_hdr",
   "sky_day01_09_hdr",
   "urbannightburning_hdr"
]
::worldspawn <- Entities.FindByClassname (null, "worldspawn");
::GetSkyname <- [];

Utils.PrecacheCSSWeapons(); //缓存CS武器，使其即拿即可有射击伤害
/* 导演设置 */
DirectorOptions <-
{
	/* 转换武器——解锁CS武器 */
	weaponsToConvert =
	{
		/* 需要转换武器类型 = "转换为" */
		weapon_sniper_military	= "weapon_sniper_awp_spawn"
		weapon_hunting_rifle	= "weapon_sniper_scout_spawn"
		weapon_smg_silenced	= "weapon_smg_mp5_spawn"
		weapon_smg	= "weapon_rifle_sg552_spawn"
	}
	function ConvertWeaponSpawn( classname )
	{
		if ( classname in weaponsToConvert )
		{
			return weaponsToConvert[classname];
		}
		return 0;
	}
	/* 参数 */
	ActiveChallenge = 1
	PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS //特感优先产卵地点
	cm_SpecialRespawnInterval = 30 //特感刷新间隔
	cm_MaxSpecials = 3 //特感最大产卵数，一次产卵多少特感
	DominatorLimit = 3 //Hunter、Smoker、Jockey、Chargers 统治者数量
	SmokerLimit = 2
	BoomerLimit = 2
	HunterLimit = 2
	SpitterLimit = 2
	JockeyLimit = 2
	ChargerLimit = 2
	SpecialInitialSpawnDelayMin = 5 //特感刷新最小间隔
	SpecialInitialSpawnDelayMax = 30 //特感刷新最大间隔
	//丧尸产卵 0=禁止
	ZombieSpawnRange = 1500 //丧尸产卵范围，默认1500
	cm_CommonLimit = 30 //丧尸数量，默认30
	//禁止坦克和女巫产卵  false=产卵 true=禁止
	cm_ProhibitBosses = false
	//坦克和女巫出现时允许特感产卵 false=产卵 true=不产卵
	ShouldAllowSpecialsWithTank = false
	//在救援关产卵坦克 false=不产卵 true=产卵
	EscapeSpawnTanks = true
	//只有爆头才能杀死丧尸(猎头者) 0=关闭 1=开启
	cm_HeadshotOnly = 0
	//没有注解(狩猎盛宴)
	cm_SpecialSlotCountdownTime = 15
	//绝境求生
	cm_BaseSpecialLimit = 3
	
	/* 修改默认武器 */
	DefaultItems =
	[
		"weapon_pistol_magnum"
	]
	function GetDefaultItem( idx )
	{
		if ( idx < DefaultItems.len() )
		{
			return DefaultItems[idx];
		}
		return 0;
	}
}
/* 传送 */
function ChatTriggers::gongneng( player, args, text)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		if(Player(player).GetName() == SetUseName)
		{
			local client = null;
			local Info = [];
			local Num = GetArgument(1);
			if(Num == null)
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("用法：!gongneng 1=传送 2=回血 3=重置运行 4=重置总回合 5=重置死亡总数", 8, "icon_no", "", HUD_RandomColor());
				return;
			}
			Num = Num.tointeger();
			if(Num == 1)
			{
				local GetPlayerLocation = Entity(player).GetLocation();
				while (client = Entities.FindByClassname(client, "player"))
				{
					if (Get_UserIdTeam(client) == 2 && ClientIsAlive(client) == 1 && client != player)
					{
						Entity(client).SetLocation(GetPlayerLocation);
					}
				}
				SendToServerConsole("exec gongneng.cfg");
				Player(player).ShowHint("召唤队友,快捷:小键盘+", 5, "icon_run", "", HUD_RandomColor());
				Player(player).PlaySound("Christmas.GiftDrop");
			}
			if(Num == 2)
			{
				while (client = Entities.FindByClassname(client, "player"))
				{
					if (Get_UserIdTeam(client) == 2)
					{
						if(RegeneratesHP[Entity(client).GetBaseIndex()] == 0)
						{
							RegeneratesHP[Entity(client).GetBaseIndex()] = 1;
							Timers.AddTimer(0.1, true, Timer_RegeneratesHP, client);
						}
						else
						{
							RegeneratesHP[Entity(client).GetBaseIndex()] = 0;
						}
					}
				}
				SendToServerConsole("exec gongneng.cfg");
				Player(player).ShowHint("自动回血,再输一次可关闭,快捷:小键盘*", 5, "icon_run", "", HUD_RandomColor());
				Player(player).PlaySound("Christmas.GiftDrop");
			}
			if(Num == 3)
			{
				SendToServerConsole("exec gongneng.cfg");
				Player(player).ShowHint("重置运行时间", 5, "icon_run", "", HUD_RandomColor());
				FileIO.SaveTable( "Save_RunTime", _ResetGameRunTime());
				::GetRunTime = FileIO.LoadTable("Save_RunTime");
			}
			if(Num == 4)
			{
				SendToServerConsole("exec gongneng.cfg");
				Player(player).ShowHint("重置总回合时间", 5, "icon_run", "", HUD_RandomColor());
				FileIO.SaveTable( "total_gametime", _ResetGameTime());
				::TotalGameTime = FileIO.LoadTable("total_gametime");
			}
			if(Num == 5)
			{
				SendToServerConsole("exec gongneng.cfg");
				Player(player).ShowHint("重置死亡总数", 5, "icon_run", "", HUD_RandomColor());
				FileIO.SaveTable( "total_DeathNum", _ResetDeathNum());
				::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
			}
			if(Num.tointeger() > 5 || Num == 0)
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("用法：!gongneng 1=传送 2=回血 3=重置运行 4=重置总回合 5=重置死亡总数", 8, "icon_no", "", HUD_RandomColor());
			}
		}
		else
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("仅限指定玩家使用", 8, "icon_no", "", HUD_RandomColor());
		}
	}
}
::Timer_RegeneratesHP <- function(client)
{
	if(ClientIsAlive(client) == 1 && Get_UserIdTeam(client) == 2)
	{
		if(RegeneratesHP[Entity(client).GetBaseIndex()] == 1)
		{
			if(Entity(client).GetHealth() <= SetHealthValue || Entity(client).GetRawHealth() <= SetHealthValue)
			{
				Entity(client).SetHealth(SetRegeneratesHP);
			}
		}
		else
		{
			Timers.RemoveTimer(Timer_RegeneratesHP);
		}
	}
	else
	{
		Timers.RemoveTimer(Timer_RegeneratesHP);
	}
}
/* 给予补给 */
function ChatTriggers::gg ( player, args, text )
{
	local Probability = RandomInt(1, 4);
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		if(Player(player).GetName() == SetUseName)
		{
			Player(player).Give("pain_pills"); //止痛药
			Player(player).Give("weapon_first_aid_kit"); //医疗包
			Player(player).Give("weapon_pistol_magnum"); //沙漠之鹰
			Player(player).Give("molotov"); //燃烧瓶
			if(Probability == 1)
			{
				Player(player).Give("weapon_rifle_ak47"); //Ak47 
			}
			if(Probability == 2)
			{
				Player(player).Give("weapon_rifle"); //M16
			}
			if(Probability == 3)
			{
				Player(player).Give("weapon_sniper_military"); //二代连阻
			}
			if(Probability == 4)
			{
				Player(player).Give("weapon_shotgun_spas"); //二代连喷
			}
		}
		else
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("仅限指定玩家使用", 8, "icon_no", "", HUD_RandomColor());
		}
	}
}
/* 开关杀敌特殊提示 */
function ChatTriggers::hud( player, args, text)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		local Num = GetArgument(1);
		local Icon = [];
		local Random = RandomInt(1, 2);
		if(Random_HUD == 1)	Icon = "Stat_Most_Special_Kills";
		if(Random_HUD == 2)	Icon = "rating_5_stars";
		if(Random_HUD == 3)	Icon = "icon_360_controller_3";
		if(Num == null)
		{
			Player(player).PlaySound("Buttons.snd11");
			if(_GetGender(player) == "man")
			{
				Player(player).ShowHint("用法：!hud 0=关 1=开 2=女声", 8, "icon_info", "", HUD_RandomColor());
			}
			if(_GetGender(player) == "woman")
			{
				Player(player).ShowHint("用法：!hud 0=关 1=开", 8, "icon_info", "", HUD_RandomColor());
			}
			return;
		}
		Num = Num.tointeger();
		if(Num == 0)
		{
			Player(player).ShowHint("说明:杀/总杀[关]", 8, Icon, "", HUD_RandomColor());
			ResetStatKV(player, StatIdx.HudInfo);
			FileIO.SaveTable( "save_playerstats", ::SavedStats );
		}
		if(Num == 1)
		{
			Player(player).ShowHint("说明:杀/总杀[开]", 8, Icon, "", HUD_RandomColor());
			IncreaseOrDecrease_StatKV(player, StatIdx.HudInfo);
			FileIO.SaveTable( "save_playerstats", ::SavedStats );
		}
		if(Num == 2)
		{
			if(_GetGender(player) == "man")
			{
				if(GetStatKV(player, StatIdx.HudInfo) > 0)
				{
					IncreaseOrDecrease_StatKV(player, StatIdx.HudInfo);
					Player(player).ShowHint("开启击杀或爆头女声", 8, "TeenGirl", "", HUD_RandomColor());
					if(Random == 1)
					{
						Player(player).PlaySound("Player.TeenGirl_NiceShot15");
					}
					if(Random == 2)
					{
						Player(player).PlaySound("Producer_NiceShot03");
					}
				}
				else
				{
					ResetStatKV(player, StatIdx.HudInfo);
					FileIO.SaveTable( "save_playerstats", ::SavedStats );
					Player(player).ShowHint("关闭击杀或爆头女声以及杀敌提示", 8, "TeenGirl", "", HUD_RandomColor());
				}
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("仅限男幸存者使用", 8, "icon_info", "", HUD_RandomColor());
			}
		}
		if(Num > 2)
		{
			if(_GetGender(player) == "man")
			{
				Player(player).ShowHint("用法：!hud 0=关 1=开 2=女声", 8, "icon_info", "", HUD_RandomColor());
			}
			if(_GetGender(player) == "woman")
			{
				Player(player).ShowHint("用法：!hud 0=关 1=开", 8, "icon_info", "", HUD_RandomColor());
			}
			Player(player).PlaySound("Buttons.snd11");
		}
	}
}
/* 丧尸死亡射线 */
function ChatTriggers::baohu ( player, args, text )
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		if(Player(player).GetName() == SetUseName)
		{
			if(DebugDrawLine_ParticleMap == 1)
			{
				if(IsOfficialMaps() == 1)
				{
					Timers.AddTimer(1.0, true, Timer_BaoHu, player);
					Player(player).ShowHint("启动丧尸死亡射线", 8, "icon_skull", "", HUD_RandomColor());
					Player(player).PlaySound("Christmas.GiftDrop");
				}
				else
				{
					Player(player).ShowHint("禁止丧尸死亡射线", 8, "icon_no", "", HUD_RandomColor());
					Player(player).PlaySound("Vote.Failed");
				}
			}
			if(DebugDrawLine_ParticleMap == 2)
			{
				Timers.AddTimer(1.0, true, Timer_BaoHu, player);
				Player(player).ShowHint("启动丧尸死亡射线", 8, "icon_skull", "", HUD_RandomColor());
				Player(player).PlaySound("Christmas.GiftDrop");
			}
		}
		else
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("仅限指定玩家使用", 8, "icon_no", "", HUD_RandomColor());
		}
	}
}
::Timer_BaoHu <- function(client)
{
	if(ClientIsAlive(client) == 1 && Get_UserIdTeam(client) == 2 && !IsPlayerABot(client))
	{
		local Infected = null;
		local Dist = 0;
		local red = RandomInt(0, 255);
		local green = RandomInt(0, 255);
		local blue = RandomInt(0, 255);
		while (Infected = Entities.FindByClassname(Infected, "infected"))
		{
			if (ZombieIsAlive(Infected) == 1 && Infected.IsValid())
			{
				Dist = GetCalculateDistance(client, Infected);
				if(Dist.tointeger() <= _DamageFrom)
				{
					DebugDrawLine(Entity(client).GetEyePosition(), Entity(Infected).GetEyePosition(), red, green, blue, false, 1.0);
					Entity(Infected).Damage(_Damage);
					Player(client).PlaySound("Breakable.Computer");
				}
			}
		}
	}
	else
	{
		Timers.RemoveTimer(Timer_BaoHu);
	}
}
function VSLib::EasyLogic::Update::ShowRescueTime()
{
	local RescueRank = null;
	
	/* 显示幸存者重生时间 */
	if(IsFinaleWin == 0)
	{
		local Count = 0;
		SurvivorsIndex <- {};
		for(local i = 0; i < 15; i++)
		{
			_ShowRescueTime[i]<-"";
		}
		foreach(surmodel in ::SurvivorsModel)
		{
			playerindex <- null;
			while ((playerindex = Entities.FindByModel(playerindex, surmodel)) != null)
			{			
				if(playerindex.IsValid() && playerindex.IsPlayer() && !Player(playerindex).IsAlive())
				{			
					SurvivorsIndex[Count] <- playerindex.GetEntityIndex();
					Count++;	
				}		
			}
			RescueTime_RankingList(SurvivorsIndex);
			for(local i = 0; i < SurvivorsIndex.len(); i++)
			{
				if(SurvivorsIndex[i] != null)
				{
					local NO = i+1;
					if(GetRescueTime[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
					{
						_ShowRescueTime[i] = PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+"-"+GetRescueTime[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+"秒后重生";
					}
					if(GetRescueTime[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] <= 0)
					{
						if(SurvivorCallForHelp[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] == 1)
						{
							_ShowRescueTime[i] = PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+" 即将重生";
						}
						if(SurvivorCallForHelp[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] == 2)
						{
							_ShowRescueTime[i] = PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+" 需要救援";
						}
					}
				}
				if(Time() > 0)
				{
					if(GetRescueTime[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
					{
						RescueRank = HUD.Item("{Rescue01}\n{Rescue02}\n{Rescue03}\n{Rescue04}");
						RescueRank.SetValue("Rescue01", Rescue01);
						RescueRank.SetValue("Rescue02", Rescue02);
						RescueRank.SetValue("Rescue03", Rescue03);
						RescueRank.SetValue("Rescue04", Rescue04);
						RescueRank.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						RescueRank.ChangeHUDNative(0, 40, 1024, 240, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						RescueRank.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						RescueRank.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer(1.0, false, CloseHud, RescueRank); //添加计时器关闭HUD
					}
					else
					{
						if(SurvivorCallForHelp[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
						{
							RescueRank = HUD.Item("{Rescue01}\n{Rescue02}\n{Rescue03}\n{Rescue04}");
							RescueRank.SetValue("Rescue01", Rescue01);
							RescueRank.SetValue("Rescue02", Rescue02);
							RescueRank.SetValue("Rescue03", Rescue03);
							RescueRank.SetValue("Rescue04", Rescue04);
							RescueRank.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
							RescueRank.ChangeHUDNative(0, 40, 1024, 240, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
							RescueRank.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
							RescueRank.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
							Timers.AddTimer(1.0, false, CloseHud, RescueRank); //添加计时器关闭HUD
						}
					}
				}
			}
		}
	}
	/* 幸存者成功逃离救援关，显示信息 */
	if(IsFinaleWin > 0 && ShowFinaleVehicleInfo_Off == 1)
	{
		local SurvivorIsAlive = 0;
		local InfectedIsAlive = 0;
		local GetDealthNum = 0;
		local GetAliveNum = 0;
		local GetHasMapRestarted = [];
		local GetFinaleInfo = [];
		local Info = [];
		if(IsFinaleWin == 1)
		{
			GetFinaleInfo = "救援正赶来";
		}
		if(IsFinaleWin == 2)
		{
			GetFinaleInfo = "救援已到达";
		}
		if(IsFinaleWin == 3)
		{
			GetFinaleInfo = "已成功逃离";
		}
		foreach (p in Players.All())
		{
			if(Player(p).GetTeam() == SURVIVORS)
			{
				if(Player(p).IsAlive())
				{
					SurvivorIsAlive++;
				}
			}
			if(Player(p).GetTeam() == INFECTED)
			{
				if(Player(p).IsAlive())
				{
					InfectedIsAlive++;
				}
			}
		}
		if(Utils.HasMapRestarted())
		{
			GetHasMapRestarted = "✔✔✔✔✔✔,总"+TotalGameRestart+"次";
		}
		else
		{
			GetHasMapRestarted = "✘✘✘✘✘✘,总"+TotalGameRestart+"次";
		}
		
		GetDealthNum = IsSurvivorsDeathCount + IsInfectedDeathCount;
		GetAliveNum = SurvivorIsAlive + InfectedIsAlive;
		Info = GetAliveNum+"活,"+GetDealthNum+"死";
		
		RescueRank = HUD.Item("{Rescue01}\n{Rescue02}\n{Rescue03}\n{Rescue04}\n{Rescue05}");
		RescueRank.SetValue("Rescue01", GetFinaleInfo);
		RescueRank.SetValue("Rescue02", "求生:"+SurvivorIsAlive+"活,"+IsSurvivorsDeathCount+"死");
		RescueRank.SetValue("Rescue03", "特感:"+InfectedIsAlive+"活,"+IsInfectedDeathCount+"死");
		RescueRank.SetValue("Rescue04", "总计:"+Info);
		RescueRank.SetValue("Rescue05", "重启:"+GetHasMapRestarted);
		RescueRank.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		RescueRank.ChangeHUDNative(0, 40, 1024, 240, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		RescueRank.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		RescueRank.AddFlag(g_ModeScript.HUD_FLAG_BLINK|HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer(1.0, false, CloseHud, RescueRank); //添加计时器关闭HUD
	}
}
::Rescue01 <- function()
{
	return _ShowRescueTime[0];
}
::Rescue02 <- function ()
{
	return _ShowRescueTime[1];
}
::Rescue03 <- function ()
{
	return _ShowRescueTime[2];
}
::Rescue04 <- function ()
{
	return _ShowRescueTime[3];
}
::RescueTime_RankingList <- function(Survivor)
{
    for (local S = 0; S < Survivor.len() - 1; S++)
    {
		for (local C = 0; C < Survivor.len() - 1 - S; C++)
		{
			if (GetRescueTime[Survivor[C]] < GetRescueTime[Survivor[C+1]])
			{
				local P = Survivor[C + 1];
				Survivor[C + 1] = Survivor[C];
				Survivor[C] = P;
			}
		}
	}
}
::RandomColor<-function()
{
	local Color = {};
	local C = RandomInt(1, 42);
	
	if(C == 1)	Color = "255 128 128";
	if(C == 2)	Color = "255 255 128";
	if(C == 3)	Color = "128 255 128";
	if(C == 4)	Color = "128 255 255";
	if(C == 5)	Color = "0 128 255";
	if(C == 6)	Color = "255 128 192";
	if(C == 7)	Color = "255 128 255";
	if(C == 8)	Color = "255 0 0";
	if(C == 9)	Color = "255 255 0";
	if(C == 10)	Color = "128 255 0";
	if(C == 11)	Color = "0 255 64";
	if(C == 12)	Color = "0 255 255";
	if(C == 13)	Color = "0 128 192";
	if(C == 14)	Color = "128 128 192";
	if(C == 15)	Color = "255 0 255";
	if(C == 16)	Color = "128 128 64";
	if(C == 17)	Color = "255 128 64";
	if(C == 18)	Color = "0 255 0";
	if(C == 19)	Color = "0 128 128";
	if(C == 20)	Color = "0 64 128";
	if(C == 21)	Color = "128 128 255";
	if(C == 22)	Color = "128 0 64";
	if(C == 23)	Color = "255 0 128";
	if(C == 24)	Color = "128 0 0";
	if(C == 25)	Color = "0 128 0";
	if(C == 26)	Color = "0 0 255";
	if(C == 27)	Color = "128 0 128";
	if(C == 28)	Color = "128 0 255";
	if(C == 29)	Color = "0 128 64";
	if(C == 30)	Color = "64 0 0";
	if(C == 31)	Color = "128 64 0";
	if(C == 32)	Color = "0 64 0";
	if(C == 33)	Color = "0 64 64";
	if(C == 34)	Color = "0 0 128";
	if(C == 35)	Color = "0 0 64";
	if(C == 36)	Color = "64 0 64";
	if(C == 37)	Color = "64 0 128";
	if(C == 38)	Color = "0 0 0";
	if(C == 39)	Color = "128 128 0";
	if(C == 40)	Color = "128 128 64";
	if(C == 41)	Color = "64 128 128";
	if(C == 42)	Color = "64 0 64";
	
	return Color;
}

function VSLib::EasyLogic::Update::Run()
{
	/* 设置丧尸大小 */
	if(ModelOption == 0 || ModelOption == 1 || ModelOption == 2 || ModelOption == 3 || 
		ModelOption == 5 || ModelOption == 6 || ModelOption == 7 || ModelOption == 8)
	{
		if(_Scale <= 0.5)
		{
			_Scale = 0.5;
		}
		if(_Scale >= 2.5)
		{
			_Scale = 2.5;
		}
	}
	if(ModelOption == 4)
	{
		_Scale = 1.0;
	}
	if(ModelOption == 9)
	{
		if(ModelRandom == 1 || ModelRandom == 2 || ModelRandom == 3 || ModelRandom == 5 
		   || ModelRandom == 6 || ModelRandom == 7 || ModelRandom == 8)
		{
			if(_Scale <= 0.5)
			{
				_Scale = 0.5;
			}
			if(_Scale >= 2.5)
			{
				_Scale = 2.5;
			}
		}
		else
		{
			_Scale = 1.0;
		}
	}
	
	local Infected = null;
	while (Infected = Entities.FindByClassname(Infected, "infected"))
	{
		Entity(Infected).SetModelScale(_Scale);
	}
	/* 影子参数 */
	foreach (shadowcontrol in Objects.OfClassname("shadow_control"))
	{
		shadowcontrol.Input("color", RandomColor());
		shadowcontrol.Input("setdistance", "1000.0");
	}
	/* 太阳参数 */
	foreach (envsun in Objects.OfClassname("env_sun"))
	{
		envsun.Input("setcolor", RandomColor());
	}
	/* 获取有效幸存者数量 */
	local GetSurvivorLimit = 0;
	foreach (client in Players.All())
	{
		if(Player(client).GetTeam() == SURVIVORS && Player(client).IsAlive() && !Player(client).IsIncapacitated() && !Player(client).IsHangingFromLedge()) // && !IsPlayerABot(P)
		{
			GetSurvivorLimit++;
			PlayerLimit = GetSurvivorLimit;
		}
	}
	/* 自动更改挣脱时间 */
	local GetPlayerLimit = 0;
	foreach (p in Players.All())
	{
		if((p.GetTeam() == SURVIVORS || p.GetTeam() == INFECTED) && !Entity(p).IsBot())
		{
			GetPlayerLimit++;
		}
	}
	/* 一名玩家 */
	if(GetPlayerLimit == 1)
	{
		_FlounceTime = 1.0;
	}
	/* 多名玩家 */
	if(GetPlayerLimit > 1)
	{
		_FlounceTime = 5.0;
	}
	if(Time() > 0)
	{
		FileIO.SaveTable( "save_upgradedata", ::SavedUpgrade );
		if(MedicalSupplies_Off == 1)
		{
			if(Time_MedicalSupplies < 1)
			{
				Time_MedicalSupplies++;
				Timers.AddTimer ( 1.0, false, Time_MedicalSuppliesNum );
			}
		}
	}
	/* 检查玩家与安全门之间距离 */
	if(SaferoomLocation_Off == 1)
	{
		if(IsValidMap() != 1)
		{
			local SafeDoor = null;
			local Distance = 0;
			local D = 0;
			local NewD = 0;
			local P_Distance = 0;
			local P_D = 0;
			local P_NewD = 0;
			local client = null;
			local Info = [];
			if(FirstPlayer == 0)
			{
				foreach (P in Players.All())
				{
					if(P.GetTeam() == SURVIVORS && ClientIsAlive(P) == 1)
					{
						P_Distance = Utils.CalculateDistance(Utils.GetSaferoomLocation(), Entity(P).GetLocation())
						P_D = _GetSaferoomLocation - P_Distance;
						P_NewD = P_D / _GetSaferoomLocation * 100;
						if(P_NewD.tointeger() >= 95)
						{
							FirstPlayer++;
							ProtectOff = 1;
							GetFirstPlayerName = Player(P).GetName();
						}
					}
				}
				while (client = Entities.FindByClassname(client, "player"))
				{
					if (Get_UserIdTeam(client) == 2 && ClientIsAlive(client) == 1) // && !IsPlayerABot(client)
					{
						if(Time() >= last_set + 1 && GetSaferoomNum < 5)
						{
							GetSaferoomNum++;
							last_set = Time();
							_GetSaferoomLocation = Utils.CalculateDistance(Utils.GetSaferoomLocation(), Entity(client).GetLocation());
						}
						Distance = Utils.CalculateDistance(Utils.GetSaferoomLocation(), Entity(client).GetLocation())
						D = _GetSaferoomLocation - Distance;
						NewD = D / _GetSaferoomLocation * 100;
						if(Distance > 0)
						{
							if(NewD.tointeger() >= 0)
							{
								Info = "安全门："+Distance.tointeger()+"m,已完成"+NewD.tointeger()+"%路程";
								SafeDoor = HUD.Item(Info);
								SafeDoor.AttachTo(HUD_LEFT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								SafeDoor.ChangeHUDNative(270, 620, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								SafeDoor.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								SafeDoor.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 1.0, false, CloseHud, SafeDoor ); //添加计时器关闭HUD
							}
							if(NewD.tointeger() < 0)
							{
								Info = "安全门："+Distance.tointeger()+"m,已偏离"+NewD.tointeger()+"%路程";
								SafeDoor = HUD.Item(Info);
								SafeDoor.AttachTo(HUD_LEFT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								SafeDoor.ChangeHUDNative(270, 620, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								SafeDoor.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								SafeDoor.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 1.0, false, CloseHud, SafeDoor ); //添加计时器关闭HUD
							}
						}
						if(Distance <= 0)
						{
							SafeDoor = HUD.Item("无法检测到安全门");
							SafeDoor.AttachTo(HUD_LEFT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
							SafeDoor.ChangeHUDNative(300, 620, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
							SafeDoor.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
							SafeDoor.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
							Timers.AddTimer( 1.0, false, CloseHud, SafeDoor ); //添加计时器关闭HUD
						}
					}
				}
			}
			if(FirstPlayer >= 1)
			{
				while (client = Entities.FindByClassname(client, "player"))
				{
					if (Get_UserIdTeam(client) == 2 && ClientIsAlive(client) == 1)
					{
						Distance = Utils.CalculateDistance(Utils.GetSaferoomLocation(), Entity(client).GetLocation());
					}
				}
				Info = "安全门："+Distance.tointeger()+"m,已完成100%路程,已进"+Utils.GetNumberInSafeSpot()+"/"+Utils.GetNumberOutsideSafeSpot();
				SafeDoor = HUD.Item("{info01}\n{info02}");
				SafeDoor.SetValue("info01", Info);
				SafeDoor.SetValue("info02", "最先到达："+GetFirstPlayerName);
				SafeDoor.AttachTo(HUD_LEFT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
				SafeDoor.ChangeHUDNative(180, 610, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
				SafeDoor.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
				SafeDoor.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
				Timers.AddTimer( 1.0, false, CloseHud, SafeDoor ); //添加计时器关闭HUD
			}
		}
	}
	/* 设置模式 */
	if(ModelOption == 1)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 30;
		DirectorOptions.cm_MaxSpecials = 3;
		DirectorOptions.DominatorLimit = 3;
		DirectorOptions.cm_BaseSpecialLimit = 3;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.SmokerLimit = 2;
		DirectorOptions.BoomerLimit = 2;
		DirectorOptions.HunterLimit = 2;
		DirectorOptions.SpitterLimit = 2;
		DirectorOptions.JockeyLimit = 2;
		DirectorOptions.ChargerLimit = 2;
		DirectorOptions.SpecialInitialSpawnDelayMin = 5;
		DirectorOptions.SpecialInitialSpawnDelayMax = 30;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 30;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 0;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 2)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_CommonLimit = 0;
		DirectorOptions.DominatorLimit = 8;
		DirectorOptions.cm_MaxSpecials = 8;
		DirectorOptions.cm_BaseSpecialLimit = 8;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.cm_ProhibitBosses = true;
		DirectorOptions.cm_HeadshotOnly = 0;
		DirectorOptions.cm_SpecialRespawnInterval = 0;
		DirectorOptions.SpecialInitialSpawnDelayMin = 0;
		DirectorOptions.SpecialInitialSpawnDelayMax = 5;
		DirectorOptions.ShouldAllowSpecialsWithTank = true;
		DirectorOptions.EscapeSpawnTanks = false;
		DirectorOptions.SmokerLimit = 2;
		DirectorOptions.BoomerLimit = 2;
		DirectorOptions.HunterLimit = 2;
		DirectorOptions.SpitterLimit = 2;
		DirectorOptions.JockeyLimit = 2;
		DirectorOptions.ChargerLimit = 2;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "100" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "100" );
			Convars.SetValue( "z_spitter_health", "100" );
			Convars.SetValue( "z_jockey_health", "100" );
			Convars.SetValue( "z_charger_health", "100" );
		}
	}
	if(ModelOption == 3)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "1" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "0"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 30;
		DirectorOptions.cm_MaxSpecials = 3;
		DirectorOptions.DominatorLimit = 3;
		DirectorOptions.cm_BaseSpecialLimit = 3;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.SmokerLimit = 2;
		DirectorOptions.BoomerLimit = 2;
		DirectorOptions.HunterLimit = 2;
		DirectorOptions.SpitterLimit = 2;
		DirectorOptions.JockeyLimit = 2;
		DirectorOptions.ChargerLimit = 2;
		DirectorOptions.SpecialInitialSpawnDelayMin = 5;
		DirectorOptions.SpecialInitialSpawnDelayMax = 30;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 30;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 0;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 4)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "0"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 30;
		DirectorOptions.cm_MaxSpecials = 3;
		DirectorOptions.DominatorLimit = 3;
		DirectorOptions.cm_BaseSpecialLimit = 3;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.SmokerLimit = 2;
		DirectorOptions.BoomerLimit = 2;
		DirectorOptions.HunterLimit = 2;
		DirectorOptions.SpitterLimit = 2;
		DirectorOptions.JockeyLimit = 2;
		DirectorOptions.ChargerLimit = 2;
		DirectorOptions.SpecialInitialSpawnDelayMin = 5;
		DirectorOptions.SpecialInitialSpawnDelayMax = 30;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 30;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 1;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 5)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 1;
		DirectorOptions.cm_MaxSpecials = 4;
		DirectorOptions.DominatorLimit = 4;
		DirectorOptions.cm_BaseSpecialLimit = 4;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.SmokerLimit = 0;
		DirectorOptions.BoomerLimit = 0;
		DirectorOptions.HunterLimit = 4;
		DirectorOptions.SpitterLimit = 0;
		DirectorOptions.JockeyLimit = 0;
		DirectorOptions.ChargerLimit = 0;
		DirectorOptions.SpecialInitialSpawnDelayMin = 1;
		DirectorOptions.SpecialInitialSpawnDelayMax = 10;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 30;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 0;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 6)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 1;
		DirectorOptions.cm_SpecialSlotCountdownTime = 5;
		DirectorOptions.cm_MaxSpecials = 4;
		DirectorOptions.DominatorLimit = 4;
		DirectorOptions.cm_BaseSpecialLimit = 4;
		DirectorOptions.SmokerLimit = 0;
		DirectorOptions.BoomerLimit = 0;
		DirectorOptions.HunterLimit = 0;
		DirectorOptions.SpitterLimit = 0;
		DirectorOptions.JockeyLimit = 4;
		DirectorOptions.ChargerLimit = 0;
		DirectorOptions.SpecialInitialSpawnDelayMin = 1;
		DirectorOptions.SpecialInitialSpawnDelayMax = 10;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 0;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 0;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_jockey_speed", "400" );
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 7)
	{
		Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
		Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
		Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
		DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
		DirectorOptions.cm_SpecialRespawnInterval = 15;
		DirectorOptions.cm_MaxSpecials = 8;
		DirectorOptions.DominatorLimit = 8;
		DirectorOptions.cm_BaseSpecialLimit = 2;
		DirectorOptions.cm_SpecialSlotCountdownTime = 15;
		DirectorOptions.SmokerLimit = 1;
		DirectorOptions.BoomerLimit = 1;
		DirectorOptions.HunterLimit = 1;
		DirectorOptions.SpitterLimit = 1;
		DirectorOptions.JockeyLimit = 1;
		DirectorOptions.ChargerLimit = 1;
		DirectorOptions.SpecialInitialSpawnDelayMin = 5;
		DirectorOptions.SpecialInitialSpawnDelayMax = 15;
		DirectorOptions.ZombieSpawnRange = 1500;
		DirectorOptions.cm_CommonLimit = 30;
		DirectorOptions.cm_ProhibitBosses = false;
		DirectorOptions.cm_HeadshotOnly = 0;
		if(UpgradeOff == 0)
		{
			Convars.SetValue( "z_gas_health", "250" );
			Convars.SetValue( "z_exploding_health", "50" );
			Convars.SetValue( "z_hunter_health", "250" );
			Convars.SetValue( "z_spitter_health", "50" );
			Convars.SetValue( "z_jockey_health", "325" );
			Convars.SetValue( "z_charger_health", "600" );
		}
	}
	if(ModelOption == 8)
	{
		if(IsOfficialMaps() == 1)
		{
			if(MapIsValid(SessionState.MapName.tolower()) == 0)
			{
				Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
				Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
				Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
				DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
				DirectorOptions.cm_SpecialRespawnInterval = 5;
				DirectorOptions.cm_MaxSpecials = 4;
				DirectorOptions.DominatorLimit = 4;
				DirectorOptions.cm_BaseSpecialLimit = 3;
				DirectorOptions.cm_SpecialSlotCountdownTime = 15;
				DirectorOptions.SmokerLimit = 0;
				DirectorOptions.BoomerLimit = 2;
				DirectorOptions.HunterLimit = 0;
				DirectorOptions.SpitterLimit = 2;
				DirectorOptions.JockeyLimit = 0;
				DirectorOptions.ChargerLimit = 0;
				DirectorOptions.SpecialInitialSpawnDelayMin = 1;
				DirectorOptions.SpecialInitialSpawnDelayMax = 5;
				DirectorOptions.ZombieSpawnRange = 1500;
				DirectorOptions.cm_CommonLimit = 30;
				DirectorOptions.cm_ProhibitBosses = true;
				DirectorOptions.cm_HeadshotOnly = 0;
				if(UpgradeOff == 0)
				{
					Convars.SetValue( "z_gas_health", "250" );
					Convars.SetValue( "z_exploding_health", "50" );
					Convars.SetValue( "z_hunter_health", "250" );
					Convars.SetValue( "z_spitter_health", "50" );
					Convars.SetValue( "z_jockey_health", "325" );
					Convars.SetValue( "z_charger_health", "600" );
				}
				if(ZombieIncoming_Off == 1)
				{
					if(Time() >= _Timer + ZombieIncoming_Time)
					{
						_Timer = Time();
						Utils.TriggerStage(STAGE_PANIC);
					}
				}
			}
			else
			{
				Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
				Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
				Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
				DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
				DirectorOptions.cm_SpecialRespawnInterval = 30;
				DirectorOptions.cm_MaxSpecials = 3;
				DirectorOptions.DominatorLimit = 3;
				DirectorOptions.cm_BaseSpecialLimit = 3;
				DirectorOptions.cm_SpecialSlotCountdownTime = 15;
				DirectorOptions.SmokerLimit = 2;
				DirectorOptions.BoomerLimit = 2;
				DirectorOptions.HunterLimit = 2;
				DirectorOptions.SpitterLimit = 2;
				DirectorOptions.JockeyLimit = 2;
				DirectorOptions.ChargerLimit = 2;
				DirectorOptions.SpecialInitialSpawnDelayMin = 5;
				DirectorOptions.SpecialInitialSpawnDelayMax = 30;
				DirectorOptions.ZombieSpawnRange = 1500;
				DirectorOptions.cm_CommonLimit = 30;
				DirectorOptions.cm_ProhibitBosses = false;
				DirectorOptions.cm_HeadshotOnly = 0;
				if(UpgradeOff == 0)
				{
					Convars.SetValue( "z_gas_health", "250" );
					Convars.SetValue( "z_exploding_health", "50" );
					Convars.SetValue( "z_hunter_health", "250" );
					Convars.SetValue( "z_spitter_health", "50" );
					Convars.SetValue( "z_jockey_health", "325" );
					Convars.SetValue( "z_charger_health", "600" );
				}
			}
		}
		else
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 30;
			DirectorOptions.cm_MaxSpecials = 3;
			DirectorOptions.DominatorLimit = 3;
			DirectorOptions.cm_BaseSpecialLimit = 3;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 2;
			DirectorOptions.BoomerLimit = 2;
			DirectorOptions.HunterLimit = 2;
			DirectorOptions.SpitterLimit = 2;
			DirectorOptions.JockeyLimit = 2;
			DirectorOptions.ChargerLimit = 2;
			DirectorOptions.SpecialInitialSpawnDelayMin = 5;
			DirectorOptions.SpecialInitialSpawnDelayMax = 30;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 0;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
	}
	if(ModelOption == 9)
	{
		if(ModelRandom == 1)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 30;
			DirectorOptions.cm_MaxSpecials = 3;
			DirectorOptions.DominatorLimit = 3;
			DirectorOptions.cm_BaseSpecialLimit = 3;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 2;
			DirectorOptions.BoomerLimit = 2;
			DirectorOptions.HunterLimit = 2;
			DirectorOptions.SpitterLimit = 2;
			DirectorOptions.JockeyLimit = 2;
			DirectorOptions.ChargerLimit = 2;
			DirectorOptions.SpecialInitialSpawnDelayMin = 5;
			DirectorOptions.SpecialInitialSpawnDelayMax = 30;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 0;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 2)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_CommonLimit = 0;
			DirectorOptions.DominatorLimit = 8;
			DirectorOptions.cm_MaxSpecials = 8;
			DirectorOptions.cm_BaseSpecialLimit = 8;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.cm_ProhibitBosses = true;
			DirectorOptions.cm_HeadshotOnly = 0;
			DirectorOptions.cm_SpecialRespawnInterval = 0;
			DirectorOptions.SpecialInitialSpawnDelayMin = 0;
			DirectorOptions.SpecialInitialSpawnDelayMax = 5;
			DirectorOptions.ShouldAllowSpecialsWithTank = true;
			DirectorOptions.EscapeSpawnTanks = false;
			DirectorOptions.SmokerLimit = 2;
			DirectorOptions.BoomerLimit = 2;
			DirectorOptions.HunterLimit = 2;
			DirectorOptions.SpitterLimit = 2;
			DirectorOptions.JockeyLimit = 2;
			DirectorOptions.ChargerLimit = 2;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "100" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "100" );
				Convars.SetValue( "z_spitter_health", "100" );
				Convars.SetValue( "z_jockey_health", "100" );
				Convars.SetValue( "z_charger_health", "100" );
			}
		}
		if(ModelRandom == 3)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "1" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "0"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 30;
			DirectorOptions.cm_MaxSpecials = 3;
			DirectorOptions.DominatorLimit = 3;
			DirectorOptions.cm_BaseSpecialLimit = 3;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 2;
			DirectorOptions.BoomerLimit = 2;
			DirectorOptions.HunterLimit = 2;
			DirectorOptions.SpitterLimit = 2;
			DirectorOptions.JockeyLimit = 2;
			DirectorOptions.ChargerLimit = 2;
			DirectorOptions.SpecialInitialSpawnDelayMin = 5;
			DirectorOptions.SpecialInitialSpawnDelayMax = 30;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_HeadshotOnly = 0;
			DirectorOptions.cm_ProhibitBosses = false;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 4)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 30;
			DirectorOptions.cm_MaxSpecials = 3;
			DirectorOptions.DominatorLimit = 3;
			DirectorOptions.cm_BaseSpecialLimit = 3;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 2;
			DirectorOptions.BoomerLimit = 2;
			DirectorOptions.HunterLimit = 2;
			DirectorOptions.SpitterLimit = 2;
			DirectorOptions.JockeyLimit = 2;
			DirectorOptions.ChargerLimit = 2;
			DirectorOptions.SpecialInitialSpawnDelayMin = 5;
			DirectorOptions.SpecialInitialSpawnDelayMax = 30;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 1;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 5)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 1;
			DirectorOptions.cm_MaxSpecials = 4;
			DirectorOptions.DominatorLimit = 4;
			DirectorOptions.cm_BaseSpecialLimit = 4;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 0;
			DirectorOptions.BoomerLimit = 0;
			DirectorOptions.HunterLimit = 4;
			DirectorOptions.SpitterLimit = 0;
			DirectorOptions.JockeyLimit = 0;
			DirectorOptions.ChargerLimit = 0;
			DirectorOptions.SpecialInitialSpawnDelayMin = 1;
			DirectorOptions.SpecialInitialSpawnDelayMax = 10;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 0;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 6)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 1;
			DirectorOptions.cm_SpecialSlotCountdownTime = 5;
			DirectorOptions.cm_MaxSpecials = 4;
			DirectorOptions.DominatorLimit = 4;
			DirectorOptions.cm_BaseSpecialLimit = 4;
			DirectorOptions.SmokerLimit = 0;
			DirectorOptions.BoomerLimit = 0;
			DirectorOptions.HunterLimit = 0;
			DirectorOptions.SpitterLimit = 0;
			DirectorOptions.JockeyLimit = 4;
			DirectorOptions.ChargerLimit = 0;
			DirectorOptions.SpecialInitialSpawnDelayMin = 1;
			DirectorOptions.SpecialInitialSpawnDelayMax = 10;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 0;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 0;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_jockey_speed", "400" );
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 7)
		{
			Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
			Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
			Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
			DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
			DirectorOptions.cm_SpecialRespawnInterval = 15;
			DirectorOptions.cm_MaxSpecials = 8;
			DirectorOptions.DominatorLimit = 8;
			DirectorOptions.cm_BaseSpecialLimit = 2;
			DirectorOptions.cm_SpecialSlotCountdownTime = 15;
			DirectorOptions.SmokerLimit = 1;
			DirectorOptions.BoomerLimit = 1;
			DirectorOptions.HunterLimit = 1;
			DirectorOptions.SpitterLimit = 1;
			DirectorOptions.JockeyLimit = 1;
			DirectorOptions.ChargerLimit = 1;
			DirectorOptions.SpecialInitialSpawnDelayMin = 5;
			DirectorOptions.SpecialInitialSpawnDelayMax = 15;
			DirectorOptions.ZombieSpawnRange = 1500;
			DirectorOptions.cm_CommonLimit = 30;
			DirectorOptions.cm_ProhibitBosses = false;
			DirectorOptions.cm_HeadshotOnly = 0;
			if(UpgradeOff == 0)
			{
				Convars.SetValue( "z_gas_health", "250" );
				Convars.SetValue( "z_exploding_health", "50" );
				Convars.SetValue( "z_hunter_health", "250" );
				Convars.SetValue( "z_spitter_health", "50" );
				Convars.SetValue( "z_jockey_health", "325" );
				Convars.SetValue( "z_charger_health", "600" );
			}
		}
		if(ModelRandom == 8)
		{
			if(IsOfficialMaps() == 1)
			{
				if(MapIsValid(SessionState.MapName.tolower()) == 0)
				{
					Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
					Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
					Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
					DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
					DirectorOptions.cm_SpecialRespawnInterval = 5;
					DirectorOptions.cm_MaxSpecials = 4;
					DirectorOptions.DominatorLimit = 4;
					DirectorOptions.cm_BaseSpecialLimit = 3;
					DirectorOptions.cm_SpecialSlotCountdownTime = 15;
					DirectorOptions.SmokerLimit = 0;
					DirectorOptions.BoomerLimit = 2;
					DirectorOptions.HunterLimit = 0;
					DirectorOptions.SpitterLimit = 2;
					DirectorOptions.JockeyLimit = 0;
					DirectorOptions.ChargerLimit = 0;
					DirectorOptions.SpecialInitialSpawnDelayMin = 1;
					DirectorOptions.SpecialInitialSpawnDelayMax = 5;
					DirectorOptions.ZombieSpawnRange = 1500;
					DirectorOptions.cm_CommonLimit = 30;
					DirectorOptions.cm_ProhibitBosses = true;
					DirectorOptions.cm_HeadshotOnly = 0;
					if(UpgradeOff == 0)
					{
						Convars.SetValue( "z_gas_health", "250" );
						Convars.SetValue( "z_exploding_health", "50" );
						Convars.SetValue( "z_hunter_health", "250" );
						Convars.SetValue( "z_spitter_health", "50" );
						Convars.SetValue( "z_jockey_health", "325" );
						Convars.SetValue( "z_charger_health", "600" );
					}
					if(ZombieIncoming_Off == 1)
					{
						if(Time() >= _Timer + ZombieIncoming_Time)
						{
							_Timer = Time();
							Utils.TriggerStage(STAGE_PANIC);
						}
					}
				}
				else
				{
					Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
					Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
					Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
					DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
					DirectorOptions.cm_SpecialRespawnInterval = 30;
					DirectorOptions.cm_MaxSpecials = 3;
					DirectorOptions.DominatorLimit = 3;
					DirectorOptions.cm_BaseSpecialLimit = 3;
					DirectorOptions.cm_SpecialSlotCountdownTime = 15;
					DirectorOptions.SmokerLimit = 2;
					DirectorOptions.BoomerLimit = 2;
					DirectorOptions.HunterLimit = 2;
					DirectorOptions.SpitterLimit = 2;
					DirectorOptions.JockeyLimit = 2;
					DirectorOptions.ChargerLimit = 2;
					DirectorOptions.SpecialInitialSpawnDelayMin = 5;
					DirectorOptions.SpecialInitialSpawnDelayMax = 30;
					DirectorOptions.ZombieSpawnRange = 1500;
					DirectorOptions.cm_CommonLimit = 30;
					DirectorOptions.cm_ProhibitBosses = false;
					DirectorOptions.cm_HeadshotOnly = 0;
					if(UpgradeOff == 0)
					{
						Convars.SetValue( "z_gas_health", "250" );
						Convars.SetValue( "z_exploding_health", "50" );
						Convars.SetValue( "z_hunter_health", "250" );
						Convars.SetValue( "z_spitter_health", "50" );
						Convars.SetValue( "z_jockey_health", "325" );
						Convars.SetValue( "z_charger_health", "600" );
					}
				}
			}
			else
			{
				Convars.SetValue("rescue_min_dead_time", "60"); //死后重生时间，默认60秒
				Convars.SetValue( "z_witch_always_kills", "0" ); //无论什么难度，WItch都一击必杀 0=关闭 1=开启
				Convars.SetValue("cl_glow_brightness", "1"); //轮廓发光 0=关闭 1=开启，如果关闭将是写实模式
				DirectorOptions.PreferredSpecialDirection = SPAWN_SPECIALS_IN_FRONT_OF_SURVIVORS;
				DirectorOptions.cm_SpecialRespawnInterval = 30;
				DirectorOptions.cm_MaxSpecials = 3;
				DirectorOptions.DominatorLimit = 3;
				DirectorOptions.cm_BaseSpecialLimit = 3;
				DirectorOptions.cm_SpecialSlotCountdownTime = 15;
				DirectorOptions.SmokerLimit = 2;
				DirectorOptions.BoomerLimit = 2;
				DirectorOptions.HunterLimit = 2;
				DirectorOptions.SpitterLimit = 2;
				DirectorOptions.JockeyLimit = 2;
				DirectorOptions.ChargerLimit = 2;
				DirectorOptions.SpecialInitialSpawnDelayMin = 5;
				DirectorOptions.SpecialInitialSpawnDelayMax = 30;
				DirectorOptions.ZombieSpawnRange = 1500;
				DirectorOptions.cm_CommonLimit = 30;
				DirectorOptions.cm_ProhibitBosses = false;
				DirectorOptions.cm_HeadshotOnly = 0;
				if(UpgradeOff == 0)
				{
					Convars.SetValue( "z_gas_health", "250" );
					Convars.SetValue( "z_exploding_health", "50" );
					Convars.SetValue( "z_hunter_health", "250" );
					Convars.SetValue( "z_spitter_health", "50" );
					Convars.SetValue( "z_jockey_health", "325" );
					Convars.SetValue( "z_charger_health", "600" );
				}
			}
		}
	}
	/* 设置房名 */
	local NameInfo = [];
	if(Utils.GetBaseMode() == "coop")
	{
		GetBaseModeName = "战役";
	}
	if(Utils.GetBaseMode() == "realism")
	{
		GetBaseModeName = "写实";
	}
	if(Utils.GetBaseMode() == "versus")
	{
		GetBaseModeName = "对抗";
	}
	if(Utils.GetBaseMode() == "survival")
	{
		GetBaseModeName = "生存";
	}
	if(Utils.GetBaseMode() == "scavenge")
	{
		GetBaseModeName = "清道夫";
	}
	if(Utils.GetBaseMode() == "mutation1")
	{
		GetBaseModeName = "孤身一人";
	}
	if(Utils.GetBaseMode() == "mutation2")
	{
		GetBaseModeName = "猎头者";
	}
	if(Utils.GetBaseMode() == "mutation3")
	{
		GetBaseModeName = "流血不止";
	}
	if(Utils.GetBaseMode() == "mutation4")
	{
		GetBaseModeName = "绝境求生";
	}
	if(Utils.GetBaseMode() == "mutation5")
	{
		GetBaseModeName = "四剑客";
	}
	if(Utils.GetBaseMode() == "mutation7")
	{
		GetBaseModeName = "肢解大屠杀";
	}
	if(Utils.GetBaseMode() == "mutation8")
	{
		GetBaseModeName = "钢铁侠";
	}
	if(Utils.GetBaseMode() == "mutation9")
	{
		GetBaseModeName = "侏儒卫队";
	}
	if(Utils.GetBaseMode() == "mutation10")
	{
		GetBaseModeName = "单人房间";
	}
	if(Utils.GetBaseMode() == "mutation11")
	{
		GetBaseModeName = "没有救赎";
	}
	if(Utils.GetBaseMode() == "mutation12")
	{
		GetBaseModeName = "写实对抗";
	}
	if(Utils.GetBaseMode() == "mutation13")
	{
		GetBaseModeName = "限量发放";
	}
	if(Utils.GetBaseMode() == "mutation14")
	{
		GetBaseModeName = "四分五裂";
	}
	if(Utils.GetBaseMode() == "mutation15")
	{
		GetBaseModeName = "生还者对抗";
	}
	if(Utils.GetBaseMode() == "mutation16")
	{
		GetBaseModeName = "狩猎盛宴";
	}
	if(Utils.GetBaseMode() == "mutation17")
	{
		GetBaseModeName = "孤胆枪手";
	}
	if(Utils.GetBaseMode() == "mutation18")
	{
		GetBaseModeName = "溢血抗争";
	}
	if(Utils.GetBaseMode() == "mutation19")
	{
		GetBaseModeName = "TAANNK";
	}
	if(Utils.GetBaseMode() == "mutation20")
	{
		GetBaseModeName = "疗伤小侏儒";
	}
	if(Utils.GetBaseMode() == "community1")
	{
		GetBaseModeName = "特感速递";
	}
	if(Utils.GetBaseMode() == "community2")
	{
		GetBaseModeName = "感染季节";
	}
	if(Utils.GetBaseMode() == "community3")
	{
		GetBaseModeName = "骑乘派对";
	}
	if(Utils.GetBaseMode() == "community4")
	{
		GetBaseModeName = "梦魔";
	}
	if(Utils.GetBaseMode() == "community5")
	{
		GetBaseModeName = "死亡之门";
	}
	if(Utils.GetBaseMode() == "community6")
	{
		GetBaseModeName = "Confogl";
	}
	if(SetHostName_Off == 1)
	{
		if(ModelOption == 1)
		{
			NameInfo = "固定房名"+"("+GetBaseModeName+")";
		}
		if(ModelOption == 2)
		{
			NameInfo = "固定房名(特感速递)";
		}
		if(ModelOption == 3)
		{
			NameInfo = "固定房名(写实)";
		}
		if(ModelOption == 4)
		{
			NameInfo = "固定房名(猎头者)";
		}
		if(ModelOption == 5)
		{
			NameInfo = "固定房名(狩猎盛宴)";
		}
		if(ModelOption == 6)
		{
			NameInfo = "固定房名(骑乘派对)";
		}
		if(ModelOption == 7)
		{
			NameInfo = "固定房名(绝境求生)";
		}
		if(ModelOption == 8)
		{
			if(IsOfficialMaps() == 1)
			{
				if(MapIsValid(SessionState.MapName.tolower()) == 0)
				{
					NameInfo = "固定房名(尸潮来袭)";
				}
				else
				{
					NameInfo = "固定房名(战役)";
				}
			}
			else
			{
				NameInfo = "固定房名(战役)";
			}
		}
		if(ModelOption == 9)
		{
			if(ModelRandom == 1)
			{
				NameInfo = "固定房名"+"("+GetBaseModeName+")";
			}
			if(ModelRandom == 2)
			{
				NameInfo = "固定房名(特感速递)";
			}
			if(ModelRandom == 3)
			{
				NameInfo = "固定房名(写实)";
			}
			if(ModelRandom == 4)
			{
				NameInfo = "固定房名(猎头者)";
			}
			if(ModelRandom == 5)
			{
				NameInfo = "固定房名(狩猎盛宴)";
			}
			if(ModelRandom == 6)
			{
				NameInfo = "固定房名(骑乘派对)";
			}
			if(ModelRandom == 7)
			{
				NameInfo = "固定房名(绝境求生)";
			}
			if(ModelRandom == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						NameInfo = "固定房名(尸潮来袭)";
					}
					else
					{
						NameInfo = "固定房名(战役)";
					}
				}
				else
				{
					NameInfo = "固定房名(战役)";
				}
			}
		}
		Convars.SetValue("hostname", NameInfo);
	}
	if(SetHostName_Off == 2)
	{
		if(ModelOption == 1)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"("+GetBaseModeName+")";
		}
		if(ModelOption == 2)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(特感速递)";
		}
		if(ModelOption == 3)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(写实)";
		}
		if(ModelOption == 4)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(猎头者)";
		}
		if(ModelOption == 5)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(狩猎盛宴)";
		}
		if(ModelOption == 6)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(骑乘派对)";
		}
		if(ModelOption == 7)
		{
			NameInfo = Set_MapName(SessionState.MapName.tolower())+"(绝境求生)";
		}
		if(ModelOption == 8)
		{
			if(IsOfficialMaps() == 1)
			{
				if(MapIsValid(SessionState.MapName.tolower()) == 0)
				{
					NameInfo = Set_MapName(SessionState.MapName.tolower())+"(尸潮来袭)";
				}
				else
				{
					NameInfo = Set_MapName(SessionState.MapName.tolower())+"(战役)";
				}
			}
			else
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(战役)";
			}
		}
		if(ModelOption == 9)
		{
			if(ModelRandom == 1)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"("+GetBaseModeName+")";
			}
			if(ModelRandom == 2)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(特感速递)";
			}
			if(ModelRandom == 3)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(写实)";
			}
			if(ModelRandom == 4)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(猎头者)";
			}
			if(ModelRandom == 5)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(狩猎盛宴)";
			}
			if(ModelRandom == 6)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(骑乘派对)";
			}
			if(ModelRandom == 7)
			{
				NameInfo = Set_MapName(SessionState.MapName.tolower())+"(绝境求生)";
			}
			if(ModelRandom == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						NameInfo = Set_MapName(SessionState.MapName.tolower())+"(尸潮来袭)";
					}
					else
					{
						NameInfo = Set_MapName(SessionState.MapName.tolower())+"(战役)";
					}
				}
				else
				{
					NameInfo = Set_MapName(SessionState.MapName.tolower())+"(战役)";
				}
			}
		}
		
		Convars.SetValue("hostname", NameInfo);
	}
	if(SetHostName_Off == 3)
	{
		local Player = null;
		local Num = 0;
		while (Player = Entities.FindByClassname(Player, "player"))
		{
			if (Get_UserIdTeam(Player) == 2 && !IsPlayerABot(Player))
			{
				Num++;
			}
		}
		if(ModelOption == 1)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"("+GetBaseModeName+")";
		}
		if(ModelOption == 2)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(特感速递)";
		}
		if(ModelOption == 3)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(写实)";
		}
		if(ModelOption == 4)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(猎头者)";
		}
		if(ModelOption == 5)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(狩猎盛宴)";
		}
		if(ModelOption == 6)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(骑乘派对)";
		}
		if(ModelOption == 7)
		{
			NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(绝境求生)";
		}
		if(ModelOption == 8)
		{
			if(IsOfficialMaps() == 1)
			{
				if(MapIsValid(SessionState.MapName.tolower()) == 0)
				{
					NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(尸潮来袭)";
				}
				else
				{
					NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(战役)";
				}
			}
			else
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(战役)";
			}
		}
		if(ModelOption == 9)
		{
			if(ModelRandom == 1)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"("+GetBaseModeName+")";
			}
			if(ModelRandom == 2)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(特感速递)";
			}
			if(ModelRandom == 3)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(写实)";
			}
			if(ModelRandom == 4)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(猎头者)";
			}
			if(ModelRandom == 5)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(狩猎盛宴)";
			}
			if(ModelRandom == 6)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(骑乘派对)";
			}
			if(ModelRandom == 7)
			{
				NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(绝境求生)";
			}
			if(ModelRandom == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(尸潮来袭)";
					}
					else
					{
						NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(战役)";
					}
				}
				else
				{
					NameInfo = Num+"人在玩"+Set_MapName(SessionState.MapName.tolower())+"(战役)";
				}
			}
		}
		Convars.SetValue("hostname", NameInfo);
	}
	if(SetHostName_Off == 4)
	{
		Convars.SetValue("hostname", RandomHostName());
	}
	/* 循环广告 */
	if(Simple_Advertising_Off == 1)
	{
		if(Time() > 0)
		{
			Simple_Advertising_AdsTime++;
			if(Simple_Advertising_AdsTime >= Simple_Advertising_Time)
			{
				Simple_Advertising_AdsTime = 0;
				Utils.SayToAll("[-]"+SimpleAdvertising());
			}
		}
	}
	/* 换图提醒 */
	if(IsValidMap() == 1 && AutoChangeMap_Off == 1)
	{
		local GetNextMapName = [];
		local HUDItem = [];
		if(AutoChange == 1)
		{
			if(Time() > 0)
			{
				TimerMax++;
				local Num = 6-TimerMax;
				if(TimerMax >= 6)
				{
					TimerMax = 0;
					AutoChange = 0;
					local ServerCommand = "changelevel "+GetNextMap();
					SendToServerConsole(ServerCommand);
				}
				else
				{
					GetNextMapName = "随机换图:"+NextMapName()+"，即将开始-"+Num+"秒";
					HUDItem = HUD.Item(GetNextMapName);
					HUDItem.AttachTo(HUD_LEFT_TOP);
					HUDItem.ChangeHUDNative(300, 620, 1024, 80, 1024, 768);
					HUDItem.SetTextPosition(TextAlign.Left);
					HUDItem.AddFlag(g_ModeScript.HUD_FLAG_NOBG);
					Timers.AddTimer( 1.0, false, CloseMenu, HUDItem );
				}
			}
		}
		if(AutoChange == 2)
		{
			if(Time() > 0)
			{
				TimerMax++;
				local Num = 6-TimerMax;
				if(TimerMax >= 6)
				{
					TimerMax = 0;
					AutoChange = 0;
					local ServerCommand = "changelevel "+GetNextMap();
					SendToServerConsole(ServerCommand);
				}
				else
				{
					GetNextMapName = "随机换图:"+NextMapName()+"，即将开始-"+Num;
					HUDItem = HUD.Item(GetNextMapName);
					HUDItem.AttachTo(HUD_LEFT_TOP);
					HUDItem.ChangeHUDNative(300, 620, 1024, 80, 1024, 768);
					HUDItem.SetTextPosition(TextAlign.Left);
					HUDItem.AddFlag(g_ModeScript.HUD_FLAG_NOBG);
					Timers.AddTimer( 1.0, false, CloseMenu, HUDItem );
				}
			}
		}
		if(AutoChange == 0)
		{
			GetNextMapName = "随机换图:"+NextMapName();
			HUDItem = HUD.Item(GetNextMapName);
			HUDItem.AttachTo(HUD_LEFT_TOP);
			HUDItem.ChangeHUDNative(300, 620, 1024, 80, 1024, 768);
			HUDItem.SetTextPosition(TextAlign.Left);
			HUDItem.AddFlag(g_ModeScript.HUD_FLAG_NOBG);
			Timers.AddTimer( 1.0, false, CloseMenu, HUDItem );
		}
	}
	/* 排行榜 */
	local Count = 0;
	SurvivorsIndex <- {};
	for(local i = 0; i < 15; i++)
	{
		DmgTank_PlayerRank[i]<-"";
		KillNum_PlayerRank[i]<-"";
	}
	foreach(surmodel in ::SurvivorsModel)
	{
		playerindex <- null;
		while ((playerindex = Entities.FindByModel(playerindex, surmodel)) != null)
		{			
			if(playerindex.IsValid() && playerindex.IsPlayer())
			{			
				SurvivorsIndex[Count] <- playerindex.GetEntityIndex();
				Count++;	
			}		
		}
		DmgTank_RankingList(SurvivorsIndex); 
		if(KillRank_Off == 1)
		{
			KillNum_RankingList(SurvivorsIndex);
		}
		for(local i = 0; i < SurvivorsIndex.len(); i++)
		{
			if(SurvivorsIndex[i] != null)
			{
				local NO = i+1;
				if(DmgTankHealth[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
				{
					if(!IsPlayerABot(PlayerInstanceFromIndex(SurvivorsIndex[i])) && UpgradeOff == 1)
					{
						DmgTank_PlayerRank[i] = GetUpgradeKV(SurvivorsIndex[i], UpgradeIdx.Lv)+"级."+PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+",伤害:"+DmgTankHealth[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+"Hp";
					}
					else
					{
						DmgTank_PlayerRank[i] = PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+",伤害:"+DmgTankHealth[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+"Hp";
					}
				}
				if(KillRank_Off == 1)
				{
					if(KillRank_Type == 1)
					{
						ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] = KillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+HeadShotNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()];
						GetKillRankType = "杀特";
					}
					if(KillRank_Type == 2)
					{
						ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] = Kill_InfectedNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()];
						GetKillRankType = "杀尸";
					}
					if(KillRank_Type == 3)
					{
						ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] = Kill_InfectedNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+KillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+HeadShotNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()];
						GetKillRankType = "杀敌";
					}
					if(ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
					{
						if(!IsPlayerABot(PlayerInstanceFromIndex(SurvivorsIndex[i])) && UpgradeOff == 1)
						{
							KillNum_PlayerRank[i] = "第"+NO+"名:"+GetUpgradeKV(SurvivorsIndex[i], UpgradeIdx.Lv)+"级."+PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+"，"+GetKillRankType+ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+"只"
						}
						else
						{
							KillNum_PlayerRank[i] = "第"+NO+"名:"+PlayerInstanceFromIndex(SurvivorsIndex[i]).GetPlayerName()+"，"+GetKillRankType+ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()]+"只"
						}
					}
					if(Show_TankRank == 0 && RoundStart_ShowInfo == 0)
					{
						local KillRank = null;
						if(Time() > 0)
						{
							if(ClientKillNum[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
							{
								KillRank = HUD.Item("{Kill01}\n{Kill02}\n{Kill03}");
								KillRank.SetValue("Kill01", KillRank01);
								KillRank.SetValue("Kill02", KillRank02);
								KillRank.SetValue("Kill03", KillRank03);
								KillRank.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								KillRank.ChangeHUDNative(190, 80, 1024, 768, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								KillRank.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								KillRank.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer(1.0, false, Kill_CloseHud, KillRank); //添加计时器关闭HUD
							}
						}
					}
				}
			}
		}
	}
	local GetSurvivorsCount = [];
	local GetInfectedCount = [];
	local GetCountInfected = [];
	local GetSurvivorsDeath = [];
	local GetInfectedDeathCount = [];
	local GetInfectedCountDeath = [];
	local hudtip = null;
	local ent = null;
	local T = Utils.GetTimeTable ( Time() );
	GetRunTime_Seconds = T.seconds+1;
	GetRunTime_Minutes = T.minutes;
	GetRunTime_Hours = T.hours;
	local SurvivorsCount = 0;
	local InfectedCount = 0;
	local CountInfected = 0;
	
	while (ent = Entities.FindByClassname(ent, "infected"))
	{
		if (ZombieIsAlive(ent) == 1)
		{
			CountInfected++;
		}
	}
	foreach (p in Players.All())
	{
		if(p.GetTeam() == SURVIVORS && ClientIsAlive(p) == 1)
		{
			SurvivorsCount++;
		}
		if(p.GetTeam() == INFECTED && ClientIsAlive(p) == 1)
		{
			InfectedCount++;
		}
	}
	if(SurvivorsCount == 0)		GetSurvivorsCount = "人类0";
	else GetSurvivorsCount = "人类"+SurvivorsCount;
	if(InfectedCount == 0)		GetInfectedCount = "特感0";
	else GetInfectedCount = "特感"+InfectedCount;
	if(CountInfected == 0)		GetCountInfected = "丧尸0";
	else GetCountInfected = "丧尸"+CountInfected;
	
	if(IsSurvivorsDeathCount == 0)		GetSurvivorsDeath = "人类0";
	else GetSurvivorsDeath = "人类"+IsSurvivorsDeathCount;
	if(IsInfectedDeathCount == 0)		GetInfectedDeathCount = "特感0";
	else GetInfectedDeathCount = "特感"+IsInfectedDeathCount;
	if(IsZombieDeathCount == 0)		GetInfectedCountDeath = "丧尸0";
	else GetInfectedCountDeath = "丧尸"+IsZombieDeathCount;
	
	local Info01 = [];
	local Info02 = [];
	if(::TotalGameTime == null)
	{
		Info01 = "回合："+T.hours+"时"+T.minutes+"分"+T.seconds+"秒";
		Info02 = "总回合：0时0分0秒";
	}
	if(::TotalGameTime != null)
	{
		
		TotalGameTimeHours = ::TotalGameTime.hours;
		TotalGameTimeMinutes = ::TotalGameTime.minutes;
		TotalGameTimeSeconds = ::TotalGameTime.seconds++;
		TotalGameRestart = ::TotalGameTime.restart;
		if(TotalGameTimeSeconds >= 60)
		{
			::TotalGameTime.seconds = 0;
			::TotalGameTime.minutes++;
		}
		if(TotalGameTimeMinutes >= 60)
		{
			::TotalGameTime.hours++;
			::TotalGameTime.minutes = 0;
		}
		if(TotalGameTimeHours >= 24)
		{
			::TotalGameTime.hours = 0;
		}
		
		/*			获取地图时间段 
		*	此参数控制某些特感产卵行为，如女巫
		*/
		local GetTimePeriod = [];
		if(Utils.GetTimeOfDay() == 0)
		{
			GetTimePeriod = "深夜";
		}
		if(Utils.GetTimeOfDay() == 1)
		{
			GetTimePeriod = "清晨";
		}
		if(Utils.GetTimeOfDay() == 2)
		{
			GetTimePeriod = "早上";
		}
		if(Utils.GetTimeOfDay() == 3)
		{
			GetTimePeriod = "下午";
		}
		if(Utils.GetTimeOfDay() == 4)
		{
			GetTimePeriod = "黄昏";
		}
		if(Utils.GetTimeOfDay() == 5)
		{
			GetTimePeriod = "晚上";
		}
		Info01 = "回合"+T.hours+"时"+T.minutes+"分"+T.seconds+"秒,"+GetTimePeriod;
		Info02 = "总回合"+TotalGameTimeHours+"时"+TotalGameTimeMinutes+"分"+TotalGameTimeSeconds+"秒,总重启"+TotalGameRestart+"次";
		if(Time() >= last_set + 1)
		{
			last_set = Time();
			FileIO.SaveTable( "total_gametime", _SaveTotalGameTime());
		}
	}
	hudtip = HUD.Item("{info01}\n{info02}");
	hudtip.SetValue("info01", Info01);
	hudtip.SetValue("info02", Info02);
	hudtip.AttachTo(HUD_MID_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
	hudtip.ChangeHUDNative(604, 493, 300, 200, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
	hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
	hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
	Timers.AddTimer( 1.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
	
	/* 获取难度 */
	local Difficulty = [];
	if(Utils.GetDifficulty() == "easy")
	{
		Difficulty = "简单,"+GetModelOptionName;
	}
	if(Utils.GetDifficulty() == "normal")
	{
		Difficulty = "普通,"+GetModelOptionName;
	}
	if(Utils.GetDifficulty() == "hard")
	{
		Difficulty = "高级,"+GetModelOptionName;
	}
	if(Utils.GetDifficulty() == "impossible")
	{
		Difficulty = "专家,"+GetModelOptionName;
	}
	/* 获取死亡总数 */
	local DeathInfo = [];
	if(::TotalDeathNum != null)
	{
		TotalDeathNum_Survivors = ::TotalDeathNum.survivorsdeath;
		TotalDeathNum_Infection = ::TotalDeathNum.infectiondeath;
		TotalDeathNum_Zombie = ::TotalDeathNum.zombiedeath;
		DeathInfo = "☠:"+GetSurvivorsDeath+"/"+TotalDeathNum_Survivors+"|"+GetInfectedDeathCount+"/"+TotalDeathNum_Infection+"|"+GetInfectedCountDeath+"/"+TotalDeathNum_Zombie;
	}
	if(::TotalDeathNum == null)
	{
		DeathInfo = "☠:"+GetSurvivorsDeath+"|"+GetInfectedDeathCount+"|"+GetInfectedCountDeath;
	}
	local NewHud = HUD.Item("{info01}\n{info02}\n{info03}");
	NewHud.SetValue("info01", Set_MapName(SessionState.MapName.tolower())+",共"+GetCheckpoint()+"站,"+Difficulty);
	NewHud.SetValue("info02", "✚:"+GetSurvivorsCount+"|"+GetInfectedCount+"|"+GetCountInfected);
	NewHud.SetValue("info03", DeathInfo);
	NewHud.AttachTo(HUD_FAR_RIGHT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
	NewHud.ChangeHUDNative(600, 554, 400, 200, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
	NewHud.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
	NewHud.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
	Timers.AddTimer( 1.0, false, CloseHud, NewHud ); //添加计时器关闭HUD

	/* 游戏运行时间 */
	local TotalTimeInfo = [];
	if(::GetRunTime == null)
	{
		TotalTimeInfo = "运行：0年0月0天0时0分0秒";
	}
	if(::GetRunTime != null)
	{
		NewYear = ::GetRunTime.year;
		NewMonth = ::GetRunTime.month;
		NewDay = ::GetRunTime.day;
		NewHours = ::GetRunTime.hours;
		NewMinutes = ::GetRunTime.minutes;
		NewSeconds = ::GetRunTime.seconds++;
		if(NewSeconds >= 60)
		{
			::GetRunTime.seconds = 0;
			::GetRunTime.minutes++;
		}
		if(NewMinutes >= 60)
		{
			::GetRunTime.hours++;
			::GetRunTime.minutes = 0;
		}
		if(NewHours >= 24)
		{
			::GetRunTime.day++;
			::GetRunTime.hours = 0;
		}
		if(NewDay >= 30)
		{
			::GetRunTime.month++;
			::GetRunTime.day = 0;
		}
		if(NewMonth > 12)
		{
			::GetRunTime.year++;
			::GetRunTime.month = 0;
		}
		if(Time() >= last_set + 1)
		{
			last_set = Time();
			FileIO.SaveTable( "Save_RunTime", _SaveGemeRunTime() );
		}
		TotalTimeInfo = "运行："+NewYear+"年"+NewMonth+"月"+NewDay+"天"+NewHours+"时"+NewMinutes+"分"+NewSeconds+"秒";
	}
	if(SetGameRunTimeShow == 1)
	{
		local TotalTime = HUD.Item(TotalTimeInfo);
		TotalTime.AttachTo(HUD_TICKER); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		TotalTime.ChangeHUDNative(280, 570, 300, 90, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		TotalTime.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		TotalTime.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer( 1.0, false, CloseHud, TotalTime ); //添加计时器关闭HUD
	}
	if(SetGameRunTimeShow == 2)
	{
		if(Time() >= last_set + SetInterval)
		{
			last_set = Time();
			local TotalTime = HUD.Item(TotalTimeInfo);
			TotalTime.AttachTo(HUD_TICKER); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			TotalTime.ChangeHUDNative(280, 570, 300, 90, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			TotalTime.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			TotalTime.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, TotalTime ); //添加计时器关闭HUD
		}
	}
}
::Kill_CloseHud <- function(hud)
{
	hud.Detach();
}
::KillRank01 <- function()
{
	return KillNum_PlayerRank[0];
}
::KillRank02 <- function ()
{
	return KillNum_PlayerRank[1];
}
::KillRank03 <- function ()
{
	return KillNum_PlayerRank[2];
}
function OnGameEvent_map_transition(params)
{
	FileIO.SaveTable( "Save_RunTime", _SaveGemeRunTime() );
	FileIO.SaveTable( "total_gametime", _SaveTotalGameTime());
	FileIO.SaveTable( "save_playerstats", ::SavedStats );
	if(UpgradeOff == 1)
	{
		FileIO.SaveTable( "save_upgradedata", ::SavedUpgrade );
	}
}
function Notifications::OnEnterSaferoom::EventEnter ( player, params )
{
	if(Entity(player).GetClassname().tolower() == "player")
	{
		if (GetFlowPercentForPosition(player.GetLocation(), false) > 50 && Player(player).GetPlayerType() == 9)
		{
			saferached = true;
		}
		else if(Player(player).GetPlayerType() == 9)
		{
			saferached = false;
			::GetRunTime = FileIO.LoadTable("Save_RunTime");
			::TotalGameTime = FileIO.LoadTable("total_gametime");
			::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
		}
	}
}
function ChatTriggers::jg ( player, args, text )
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		if(UpgradeLaserSight_Off == 1)
		{
			local weapon = player.GetActiveWeapon().GetClassname();
			if(weapon == "weapon_rifle_sg552" || weapon == "weapon_rifle" || 
				weapon == "weapon_rifle_ak47" || weapon == "weapon_rifle_m60" || 
				weapon == "weapon_rifle_desert" || weapon == "weapon_sniper_awp" || 
				weapon == "weapon_sniper_scout" || weapon == "weapon_sniper_military" || 
				weapon == "weapon_hunting_rifle" || weapon == "weapon_autoshotgun" || 
				weapon == "weapon_shotgun_spas" || weapon == "weapon_grenade_launcher" ||
				weapon == "weapon_smg" || weapon == "weapon_smg_silenced" || weapon == "weapon_smg_mp5" || 
				weapon == "weapon_pumpshotgun" || weapon == "weapon_shotgun_chrome" )
			{
				player.GiveUpgrade( UPGRADE_LASER_SIGHT );
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("无效主武器", 8, "icon_no", "", HUD_RandomColor());
			}
		}
		else
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("禁止使用该指令", 8, "icon_no", "", HUD_RandomColor());
		}
	}
}
/* 播放歌曲快捷键指令 */
function ChatTriggers::b( player, args, text)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		SendToServerConsole("exec bing.cfg");
		Player(player).ShowHint("小键盘：0=停止 1=随机  2=循坏 3-6=单曲", 8, "icon_button", "", HUD_RandomColor());
	}
}
::Time_StartRandomPlayingSongs <- function(player)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		local GetSongsName = [];
		local Random = RandomInt(1, 4);
		if(Random == 1)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Bad Man";
			Player(player).PlaySound("Jukebox.BadMan1");
			Timers.AddTimer(197.0, false, Article_Time, player);
		}
		if(Random == 2)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Dark Carnival";
			Player(player).PlaySound("c2m4.Ridin1");
			Timers.AddTimer(191.0, false, Article_Time, player);
		}
		if(Random == 3)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Portal Still Alive";
			Player(player).PlaySound("Jukebox.still_alive");
			Timers.AddTimer(189.0, false, Article_Time, player);
		}
		if(Random == 4)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Re Your Brains";
			Player(player).PlaySound("Jukebox.re_your_brains");
			Timers.AddTimer(283.0, false, Article_Time, player);
		}
		local Info = "随机播放："+GetSongsName;
		Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
		Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
	}
}
/* 播放游戏内置歌曲——指令 */
function ChatTriggers::ge( player, args, text)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		local Num = GetArgument(1);
		local Info = [];
		local GetSongsName = [];
		if(Num == null)
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("用法：!ge 0=停止 1=随机 2=循环 3-6=单曲，快捷键 !b", 8, "icon_info", "", HUD_RandomColor());
			return;
		}
		Num = Num.tointeger();
		if(Num == 0)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 1)
			{
				Player(player).PlaySound("WAM.StartUp");
				Timers.AddTimer(2.5, false, Time_StopPlayingSongs, player);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲已停止播放....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 1)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				Player(player).PlaySound("WAM.StartUp");
				Timers.AddTimer(2.5, false, Time_StartRandomPlayingSongs, player);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 2)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				Player(player).PlaySound("WAM.StartUp");
				Timers.AddTimer(2.5, false, Time_StartCirculatePlayingSongs, player);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 3)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				StartPlaying[Entity(player).GetBaseIndex()] = 1;
				GetSongsName = "Bad Man";
				Player(player).PlaySound("Jukebox.BadMan1");
				Timers.AddTimer(197.0, false, Article_Time, player);
				Info = "单曲播放："+GetSongsName;
				Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
				Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 4)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				StartPlaying[Entity(player).GetBaseIndex()] = 1;
				GetSongsName = "Dark Carnival";
				Player(player).PlaySound("c2m4.Ridin1");
				Timers.AddTimer(191.0, false, Article_Time, player);
				Info = "单曲播放："+GetSongsName;
				Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
				Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 5)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				StartPlaying[Entity(player).GetBaseIndex()] = 1;
				GetSongsName = "Portal Still Alive";
				Player(player).PlaySound("Jukebox.still_alive");
				Timers.AddTimer(189.0, false, Article_Time, player);
				Info = "单曲播放："+GetSongsName;
				Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
				Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num == 6)
		{
			if(StartPlaying[Entity(player).GetBaseIndex()] == 0)
			{
				StartPlaying[Entity(player).GetBaseIndex()] = 1;
				GetSongsName = "Re Your Brains";
				Player(player).PlaySound("Jukebox.re_your_brains");
				Timers.AddTimer(283.0, false, Article_Time, player);
				Info = "单曲播放："+GetSongsName;
				Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
				Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
			}
			else
			{
				Player(player).PlaySound("Buttons.snd11");
				Player(player).ShowHint("歌曲正在播放中....", 1, "icon_no", "", HUD_RandomColor());
			}
		}
		if(Num.tointeger() > 6)
		{
			Player(player).PlaySound("Buttons.snd11");
			Player(player).ShowHint("用法：!ge 0=停止 1=随机 2=循环 3-6=单曲，快捷键 !b", 8, "icon_info", "", HUD_RandomColor());
		}
	}
}
::Time_StopPlayingSongs <- function(player)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		Entity(player).StopSound("Jukebox.re_your_brains");
		Entity(player).StopSound("Jukebox.still_alive");
		Entity(player).StopSound("c2m4.Ridin1");
		Entity(player).StopSound("Jukebox.BadMan1");
		StartPlaying[Entity(player).GetBaseIndex()] = 0;
		Player(player).ShowHint("停止播放歌曲....", 3, "icon_info", "", HUD_RandomColor());
	}
}
::Time_StartCirculatePlayingSongs <- function(player)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		local GetSongsName = [];
		CirculatePlay[Entity(player).GetBaseIndex()]++;
		if(CirculatePlay[Entity(player).GetBaseIndex()] == 1)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Bad Man";
			Player(player).PlaySound("Jukebox.BadMan1");
			Timers.AddTimer(197.0, false, Article_Time, player);
		}
		if(CirculatePlay[Entity(player).GetBaseIndex()] == 2)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Dark Carnival";
			Player(player).PlaySound("c2m4.Ridin1");
			Timers.AddTimer(191.0, false, Article_Time, player);
		}
		if(CirculatePlay[Entity(player).GetBaseIndex()] == 3)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Portal Still Alive";
			Player(player).PlaySound("Jukebox.still_alive");
			Timers.AddTimer(189.0, false, Article_Time, player);
		}
		if(CirculatePlay[Entity(player).GetBaseIndex()] == 4)
		{
			CirculatePlay[Entity(player).GetBaseIndex()] = 0;
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Re Your Brains";
			Player(player).PlaySound("Jukebox.re_your_brains");
			Timers.AddTimer(283.0, false, Article_Time, player);
		}
		local Info = "循环播放："+GetSongsName;
		Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
		Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
	}
}
::Time_StartRandomPlayingSongs <- function(player)
{
	if(ClientIsAlive(player) == 1 && Get_UserIdTeam(player) == 2 && !IsPlayerABot(player))
	{
		local GetSongsName = [];
		local Random = RandomInt(1, 4);
		if(Random == 1)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Bad Man";
			Player(player).PlaySound("Jukebox.BadMan1");
			Timers.AddTimer(197.0, false, Article_Time, player);
		}
		if(Random == 2)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Dark Carnival";
			Player(player).PlaySound("c2m4.Ridin1");
			Timers.AddTimer(191.0, false, Article_Time, player);
		}
		if(Random == 3)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Portal Still Alive";
			Player(player).PlaySound("Jukebox.still_alive");
			Timers.AddTimer(189.0, false, Article_Time, player);
		}
		if(Random == 4)
		{
			StartPlaying[Entity(player).GetBaseIndex()] = 1;
			GetSongsName = "Re Your Brains";
			Player(player).PlaySound("Jukebox.re_your_brains");
			Timers.AddTimer(283.0, false, Article_Time, player);
		}
		local Info = "随机播放："+GetSongsName;
		Player(player).ShowHint(Info, 8, "icon_info", "", HUD_RandomColor());
		Player(player).Say("(玩家)我播放歌曲："+GetSongsName);
	}
}
::Article_Time <- function(player)
{
	if(!IsPlayerABot(player))
	{
		StartPlaying[Entity(player).GetBaseIndex()] = 0;
		Player(player).Say("(玩家)我的歌曲已播放完了，如需听歌请输入指令：!ge 1=随机 2=循环");
	}
}
function OnGameEvent_infected_death(params)
{
	if(Utils.GetBaseMode() != "community1")
	{
		IsZombieDeathCount++;
		::TotalDeathNum.zombiedeath++;
		FileIO.SaveTable( "total_DeathNum", _SaveDeathNum());
	}
	
	local Attacker = null;
	local AttackerId = null;
	if(params.rawin("attacker"))
	{
		Attacker = params["attacker"];
		AttackerId = GetPlayerFromUserID(Attacker);
		if(Attacker > 0 && Get_UserIdTeam(AttackerId) == 2)
		{
			if(!IsPlayerABot(AttackerId))
			{
				if(UpgradeOff == 1)
				{
					AddZombieExpKV(AttackerId);
				}
				IncreaseOrDecrease_StatKV(AttackerId, StatIdx.KillZombie);
				FileIO.SaveTable( "save_playerstats", ::SavedStats );
			}
			if(KillRank_Type > 1)
			{
				Kill_InfectedNum[AttackerId.GetEntityIndex()]++;
			}
		}
	}
}
function OnGameEvent_infected_hurt(params)
{
	if(JZDebugDrawText_Off == 1)
	{
		local DrawText = [];
		local Entityid = null;
		if(params.rawin("entityid"))
		{
			Entityid = params["entityid"];
			if(Entity(Entityid).GetClassname() == "infected")
			{
				if(Entity(Entityid).GetGender() == MALE)
				{
					DrawText = "(男)"+Entity(Entityid).GetActorName()+"-"+Entity(Entityid).GetHealth();
				}
				if(Entity(Entityid).GetGender() == FEMALE)
				{
					DrawText = "(女)"+Entity(Entityid).GetActorName()+"-"+Entity(Entityid).GetHealth();
				}
				DebugDrawText(Get_EyePosition(Entityid), DrawText, true, 1);
			}
			if(Entity(Entityid).GetClassname() == "witch")
			{
				if(JZDebugDrawText_Off == 1)
				{
					DrawText = Entity(Entityid).GetActorName()+"-"+Entity(Entityid).GetHealth();
					DebugDrawText(Get_EyePosition(Entityid), DrawText, true, 1);
				}
			}
		}
	}
}

function OnGameEvent_player_connect_full(params)
{
	local Userid = null;
	local User = null;
    if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if(Userid > 0 && !IsPlayerABot(User))
		{
			printf(User.GetPlayerName()+" 已连接，用户ID("+User.GetPlayerUserId()+")");
			Player(User).Say("(玩家)我已连接，用户ID("+User.GetPlayerUserId()+")");
		}
	}
}
function OnGameEvent_round_end(params)
{
	IsSurvivorsDeathCount = 0;
	IsInfectedDeathCount = 0;
	IsZombieDeathCount = 0;
	Show_TankRank = 0;
	RoundStart_ShowInfo = 0;
	FileIO.SaveTable( "Save_RunTime", _SaveGemeRunTime() );
	FileIO.SaveTable( "total_gametime", _SaveTotalGameTime());
	FileIO.SaveTable( "save_playerstats", ::SavedStats );
	if(UpgradeOff == 1)
	{
		FileIO.SaveTable( "save_upgradedata", ::SavedUpgrade );
	}
	if(IsValidMap() == 1)
	{
		if(IsRoundEnd == 1)
		{
			AutoChange = 2;
		}
	}
}
::Timer_AutoChangeMap <- function(params)
{
	if(IsValidMap() == 1 && AutoChangeMap_Off == 1)
	{
		if(AutoChange == 0)
		{
			Map_Data();
			Timers.AddTimer(0.5, false, Timer_AutoChangeMap);
		}
	}
}
function OnGameEvent_finale_vehicle_incoming(params)
{
	IsFinaleWin = 1;
}
function OnGameEvent_finale_vehicle_ready(params)
{
	IsFinaleWin = 2;
}
function OnGameEvent_finale_vehicle_leaving(params)
{
	IsFinaleWin = 3;
}
function OnGameEvent_finale_win(params)
{
	if(IsValidMap() == 1)
	{
		AutoChange = 1;
	}
	if(Win_ResetGameRunTime == 1)
	{
		FileIO.SaveTable( "Save_RunTime", _ResetGameRunTime());
		::GetRunTime = FileIO.LoadTable("Save_RunTime");
	}
	FileIO.SaveTable( "total_gametime", _ResetGameTime1());
	::TotalGameTime = FileIO.LoadTable("total_gametime");
	
	FileIO.SaveTable( "total_DeathNum", _ResetDeathNum1());
	::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
	
	ProtectOff = 1;
}
::_ResetGameRunTime <- function()
{
	return { year = 0, month = 0, day = 0, hours = 0, minutes = 0, seconds = 0 };
}
::_SaveDeathNum <- function()
{
	return { survivorsdeath = TotalDeathNum_Survivors, infectiondeath = TotalDeathNum_Infection, zombiedeath = TotalDeathNum_Zombie };
}
::_ResetGameTime <- function()
{
	return { hours = GetRunTime_Hours, minutes = GetRunTime_Minutes, seconds = GetRunTime_Seconds, restart = 0};
}
::_SaveTotalGameTime <- function()
{
	return { hours = TotalGameTimeHours, minutes = TotalGameTimeMinutes, seconds = TotalGameTimeSeconds, restart = TotalGameRestart};
}

::_SaveGemeRunTime <- function()
{
	return { year = NewYear, month = NewMonth, day = NewDay, hours = NewHours, minutes = NewMinutes, seconds = NewSeconds };
}
::Timer_Zoom1 <- function(client)
{
	if(Player(client).GetTeam() == SURVIVORS && !IsPlayerABot(client) && Player(client).IsAlive())
	{
		Entity(client).SetNetProp( "m_iFOV", 0);
		Entity(client).SetNetProp( "m_bDrawViewmodel", 0);
	}
}
::Timer_Zoom <- function(client)
{
	if(Player(client).GetTeam() == SURVIVORS && !IsPlayerABot(client) && Player(client).IsAlive())
	{
		Timers.AddTimer(0.1, false, Timer_Zoom, client);
		local GetButtons = Entity(client).GetPressedButtons();
		if(GetButtons == 524288)
		{
			Fov[Entity(client).GetBaseIndex()] = Entity(client).GetNetProp("m_iFOV");
			Fov[Entity(client).GetBaseIndex()] += 10;
			if(Fov[Entity(client).GetBaseIndex()] >= 90)
			{
				Fov[Entity(client).GetBaseIndex()] = 0;
				Entity(client).SetNetProp( "m_bDrawViewmodel",  1);
			}
			else
			{
				Entity(client).SetNetProp( "m_bDrawViewmodel",  0);
			}
			Entity(client).SetNetProp( "m_iFOV",  Fov[Entity(client).GetBaseIndex()]);
		}
		if(GetButtons == 2 || GetButtons == 8 || GetButtons == 16 || GetButtons == 512 || GetButtons == 1024 || GetButtons == 8192 || GetButtons == 2048)
		{
			Entity(client).SetNetProp( "m_bDrawViewmodel", 0);
			Entity(client).SetNetProp( "m_iFOV", 0 );
		}
	}
}
::Timer_ShowInfo <- function(client)
{
	if(Get_UserIdTeam(client) == 2 && !IsPlayerABot(client))
	{
		if(_SetHealth[Entity(client).GetBaseIndex()] == 0)
		{
			_SetHealth[Entity(client).GetBaseIndex()]++;
			/* 获取模式 */
			local GetIconName = [];
			if(ModelOption == 1)
			{
				if(Utils.GetBaseMode() == "coop")
				{
					GetModelOptionName = "战役";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "realism")
				{
					GetModelOptionName = "写实";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "versus")
				{
					GetModelOptionName = "对抗";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "survival")
				{
					GetModelOptionName = "生存";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "scavenge")
				{
					GetModelOptionName = "清道夫";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation1")
				{
					GetModelOptionName = "孤身一人";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation2")
				{
					GetModelOptionName = "猎头者";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation3")
				{
					GetModelOptionName = "流血不止";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation4")
				{
					GetModelOptionName = "绝境求生";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation5")
				{
					GetModelOptionName = "四剑客";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation7")
				{
					GetModelOptionName = "肢解大屠杀";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation8")
				{
					GetModelOptionName = "钢铁侠";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation9")
				{
					GetModelOptionName = "侏儒卫队";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation10")
				{
					GetModelOptionName = "单人房间";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation11")
				{
					GetModelOptionName = "没有救赎";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation12")
				{
					GetModelOptionName = "写实对抗";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation13")
				{
					GetModelOptionName = "限量发放";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation14")
				{
					GetModelOptionName = "四分五裂";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation15")
				{
					GetModelOptionName = "生还者对抗";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation16")
				{
					GetModelOptionName = "狩猎盛宴";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation17")
				{
					GetModelOptionName = "孤胆枪手";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation18")
				{
					GetModelOptionName = "溢血抗争";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation19")
				{
					GetModelOptionName = "TAANNK";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "mutation20")
				{
					GetModelOptionName = "疗伤小侏儒";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community1")
				{
					GetModelOptionName = "特感速递";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community2")
				{
					GetModelOptionName = "感染季节";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community3")
				{
					GetModelOptionName = "骑乘派对";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community4")
				{
					GetModelOptionName = "梦魔";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community5")
				{
					GetModelOptionName = "死亡之门";
					GetIconName = "icon_info";
				}
				if(Utils.GetBaseMode() == "community6")
				{
					GetModelOptionName = "Confogl";
					GetIconName = "icon_info";
				}
			}
			if(ModelOption == 2)
			{
				GetModelOptionName = "特感速递";
				GetIconName = "Stat_Most_Special_Kills";
			}
			if(ModelOption == 3)
			{
				GetModelOptionName = "写实";
				GetIconName = "Stat_Most_Infected_Kills";
			}
			if(ModelOption == 4)
			{
				GetModelOptionName = "猎头者";
				GetIconName = "Stat_Most_Headshots";
			}
			if(ModelOption == 5)
			{
				GetModelOptionName = "狩猎盛宴";
				GetIconName = "Stat_vs_Most_Hunter_Pounces";
			}
			if(ModelOption == 6)
			{
				GetModelOptionName = "骑乘派对";
				GetIconName = "Stat_vs_Most_Jockey_Rides";
			}
			if(ModelOption == 7)
			{
				GetModelOptionName = "绝境求生";
				GetIconName = "Stat_Most_Infected_Kills";
			}
			if(ModelOption == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						GetModelOptionName = "尸潮来袭";
						GetIconName = "Stat_Most_Infected_Kills";
					}
					else
					{
						GetModelOptionName = "战役";
						GetIconName = "icon_info";
					}
				}
				else
				{
					GetModelOptionName = "战役";
					GetIconName = "icon_info";
				}
			}
			if(ModelOption == 9)
			{
				if(ModelRandom == 1)
				{
					if(Utils.GetBaseMode() == "coop")
					{
						GetModelOptionName = "战役";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "realism")
					{
						GetModelOptionName = "写实";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "versus")
					{
						GetModelOptionName = "对抗";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "survival")
					{
						GetModelOptionName = "生存";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "scavenge")
					{
						GetModelOptionName = "清道夫";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation1")
					{
						GetModelOptionName = "孤身一人";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation2")
					{
						GetModelOptionName = "猎头者";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation3")
					{
						GetModelOptionName = "流血不止";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation4")
					{
						GetModelOptionName = "绝境求生";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation5")
					{
						GetModelOptionName = "四剑客";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation7")
					{
						GetModelOptionName = "肢解大屠杀";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation8")
					{
						GetModelOptionName = "钢铁侠";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation9")
					{
						GetModelOptionName = "侏儒卫队";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation10")
					{
						GetModelOptionName = "单人房间";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation11")
					{
						GetModelOptionName = "没有救赎";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation12")
					{
						GetModelOptionName = "写实对抗";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation13")
					{
						GetModelOptionName = "限量发放";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation14")
					{
						GetModelOptionName = "四分五裂";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation15")
					{
						GetModelOptionName = "生还者对抗";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation16")
					{
						GetModelOptionName = "狩猎盛宴";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation17")
					{
						GetModelOptionName = "孤胆枪手";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation18")
					{
						GetModelOptionName = "溢血抗争";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation19")
					{
						GetModelOptionName = "TAANNK";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "mutation20")
					{
						GetModelOptionName = "疗伤小侏儒";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community1")
					{
						GetModelOptionName = "特感速递";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community2")
					{
						GetModelOptionName = "感染季节";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community3")
					{
						GetModelOptionName = "骑乘派对";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community4")
					{
						GetModelOptionName = "梦魔";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community5")
					{
						GetModelOptionName = "死亡之门";
						GetIconName = "icon_info";
					}
					if(Utils.GetBaseMode() == "community6")
					{
						GetModelOptionName = "Confogl";
						GetIconName = "icon_info";
					}
				}
				if(ModelRandom == 2)
				{
					GetModelOptionName = "特感速递";
					GetIconName = "Stat_Most_Special_Kills";
				}
				if(ModelRandom == 3)
				{
					GetModelOptionName = "写实";
					GetIconName = "Stat_Most_Infected_Kills";
				}
				if(ModelRandom == 4)
				{
					GetModelOptionName = "猎头者";
					GetIconName = "Stat_Most_Headshots";
				}
				if(ModelRandom == 5)
				{
					GetModelOptionName = "狩猎盛宴";
					GetIconName = "Stat_vs_Most_Hunter_Pounces";
				}
				if(ModelRandom == 6)
				{
					GetModelOptionName = "骑乘派对";
					GetIconName = "Stat_vs_Most_Jockey_Rides";
				}
				if(ModelRandom == 7)
				{
					GetModelOptionName = "绝境求生";
					GetIconName = "Stat_Most_Infected_Kills";
				}
				if(ModelRandom == 8)
				{
					if(IsOfficialMaps() == 1)
					{
						if(MapIsValid(SessionState.MapName.tolower()) == 0)
						{
							GetModelOptionName = "尸潮来袭";
							GetIconName = "Stat_Most_Infected_Kills";
						}
						else
						{
							GetModelOptionName = "战役";
							GetIconName = "icon_info";
						}
					}
					else
					{
						GetModelOptionName = "战役";
						GetIconName = "icon_info";
					}
				}
			}
			Player(client).ShowHint("按鼠标中键可使用瞄准器", 10, GetIconName, "", HUD_RandomColor());
			if(UpgradeOff == 1)
			{
				local NewHealth = GetUpgradeKV(client, UpgradeIdx.Hp)+100;
				Entity(client).SetMaxHealth(NewHealth);
			}
			Player(client).Give("health");
			if(ModelOption == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						Player(client).Give("baseball_bat");
					}
				}
			}
			if(ModelOption == 9)
			{
				if(ModelRandom == 8)
				{
					if(IsOfficialMaps() == 1)
					{
						if(MapIsValid(SessionState.MapName.tolower()) == 0)
						{
							Player(client).Give("baseball_bat");
						}
					}
				}
			}
		}
	}
}
function OnGameEvent_round_end(params)
{
	IsSurvivorsDeathCount = 0;
	IsInfectedDeathCount = 0;
	IsZombieDeathCount = 0;
	Show_TankRank = 0;
	RoundStart_ShowInfo = 0;
	TotalGameRestart = ::TotalGameTime.restart++;
	FileIO.SaveTable( "Save_RunTime", _SaveGemeRunTime() );
	FileIO.SaveTable( "total_gametime", _SaveTotalGameTime());
	FileIO.SaveTable( "save_playerstats", ::SavedStats );
	if(UpgradeOff == 1)
	{
		FileIO.SaveTable( "save_upgradedata", ::SavedUpgrade );
	}
	if(IsValidMap() == 1)
	{
		if(IsRoundEnd == 1)
		{
			AutoChange = 2;
		}
	}
}
::Timer_AutoChangeMap <- function(params)
{
	if(IsValidMap() == 1 && AutoChangeMap_Off == 1)
	{
		if(AutoChange == 0)
		{
			Map_Data();
			Timers.AddTimer(0.5, false, Timer_AutoChangeMap);
		}
	}
}
::_ResetDeathNum <- function()
{
	return { survivorsdeath = IsSurvivorsDeathCount, infectiondeath = IsInfectedDeathCount, zombiedeath = IsZombieDeathCount };
}
::_ResetDeathNum1 <- function()
{
	return { survivorsdeath = 0, infectiondeath = 0, zombiedeath = 0};
}
::_ResetGameTime1 <- function()
{
	return { hours = 0, minutes = 0, seconds = 0 restart = 0};
}
::Time_ShowInfo <- function(params)
{
	local hudtip = null;
	local GetHasMapRestarted = [];
	
	if(Utils.HasMapRestarted())
	{
		GetHasMapRestarted = "✔✔✔✔✔✔✔✔✔,"+Utils.GetMapRestarts()+"次";
	}
	else
	{
		GetHasMapRestarted = "✘✘✘✘✘✘✘✘✘,"+Utils.GetMapRestarts()+"次";
	}
	
	hudtip = HUD.Item("{info01}\n{info02}\n{info03}");
	hudtip.SetValue("info01", "模式："+GetModelOptionName);
	hudtip.SetValue("info02", "重启："+GetHasMapRestarted);
	hudtip.SetValue("info03", "指令：!hud杀敌,!jg激光,!b音乐");
	hudtip.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
	hudtip.ChangeHUDNative(250, 230, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
	hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
	hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
	Timers.AddTimer( 20.0, false, Close_ShowInfo, hudtip ); //添加计时器关闭HUD
	RoundStart_ShowInfo = 1;
}
::Close_ShowInfo <- function(hud)
{
	hud.Detach();
	RoundStart_ShowInfo = 0
}
::Time_MeleeSpawnNum<- function(params)
{
	SetMedicalCount("weapon_melee_spawn", 2);
}
::Time_MedicalSuppliesNum<- function(params)
{
	SetMedicalCount("weapon_pain_pills_spawn", _MedicalCount);
	SetMedicalCount("weapon_adrenaline_spawn", _MedicalCount);
	SetMedicalCount("weapon_first_aid_kit_spawn", _MedicalCount);
}
::SetMedicalCount <- function(Class,num)
{
	weaponindex <- null;
	while ((weaponindex = Entities.FindByClassname(weaponindex, Class)) != null)
	{
		weaponindex.__KeyValueFromInt("count", num);	
		weaponindex.__KeyValueFromInt("spawnflags", 0);				
	}			
}
function OnGameEvent_round_start_post_nav(params)
{
	::GetRunTime = FileIO.LoadTable("Save_RunTime");
	::TotalGameTime = FileIO.LoadTable("total_gametime");
	::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
	::SavedStats = FileIO.LoadTable("save_playerstats");
	if (::SavedStats == null)
		::SavedStats <- {};
		
	if(UpgradeOff == 1)
	{
		::SavedUpgrade = FileIO.LoadTable( "save_upgradedata");
		if (::SavedUpgrade == null)
			::SavedUpgrade <- {};
	}
	if(ModelOption == 8)
	{
		if(IsOfficialMaps() == 1)
		{
			if(MapIsValid(SessionState.MapName.tolower()) == 0)
			{
				Timers.AddTimer ( 1.0, false, Time_MeleeSpawnNum );
			}
		}
	}
	if(ModelOption == 9)
	{
		if(ModelRandom == 8)
		{
			if(IsOfficialMaps() == 1)
			{
				if(MapIsValid(SessionState.MapName.tolower()) == 0)
				{
					Timers.AddTimer ( 1.0, false, Time_MeleeSpawnNum );
				}
			}
		}
	}
}
function Notifications::OnFirstSpawn::SetSteamID ( player, params )
{
	if (!player.IsBot())
		Timers.AddTimer( 2.0, false, ModifyStatsTable, player );
}
::ModifyStatsTable <- function ( player )
{
	if (Player(player).IsPlayerEntityValid() && !(Player(player).GetUserID() in ::SavedStats))
		GetStatKV(player, StatIdx.KillInfection);
		GetUpgradeKV(player, UpgradeIdx.Exp);
}

/* 新地图开始重置数据 */
function OnGameEvent_gameinstructor_nodraw(params)
{
	FileIO.SaveTable( "total_gametime", _ResetGameTime());
	::TotalGameTime = FileIO.LoadTable("total_gametime");
	
	FileIO.SaveTable( "total_DeathNum", _ResetDeathNum());
	::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
}
/*function OnGameEvent_gameinstructor_draw(params)
{
	FileIO.SaveTable( "total_gametime", _ResetGameTime());
	::TotalGameTime = FileIO.LoadTable("total_gametime");
	
	FileIO.SaveTable( "total_DeathNum", _ResetDeathNum());
	::TotalDeathNum = FileIO.LoadTable("total_DeathNum");
}*/
/* 雾 */
::envfogcontroller <- function ()
{
	local fogcontroller = null;
	while ((fogcontroller = Entities.FindByClassname(fogcontroller, "env_fog_controller")) != null)
	{
		printl( fogcontroller.__KeyValueFromString("fogcolor","192 192 192"));
		printl( fogcontroller.__KeyValueFromString("fogcolor2","182 182 100"));
		printl( fogcontroller.__KeyValueFromString("fogmaxdensity","1"));
		printl( fogcontroller.__KeyValueFromString("farz","1000000"));
		printl( fogcontroller.__KeyValueFromString("fogstart","1"));
		printl( fogcontroller.__KeyValueFromString("fogend ","1"));
		printl( fogcontroller.__KeyValueFromString("use_angles","1"));
		printl( fogcontroller.__KeyValueFromString("fogenable","1"));
		printl( fogcontroller.__KeyValueFromString("angles", "-45"));
		printl( fogcontroller.__KeyValueFromString("fogdir", "-1 -1 1"));
		printl( fogcontroller.__KeyValueFromString("fogblend", "1"));
	}
}
function OnGameEvent_round_start(params)
{
	IsSurvivorsDeathCount = 0;
	IsInfectedDeathCount = 0;
	IsZombieDeathCount = 0;
	Show_TankRank = 0;
	RoundStart_ShowInfo = 0;
	Timers.AddTimer( 60.0, false, Time_ShowInfo );
	Skyboxes_Type = RandomInt(0,Skyboxes.len()-1);
	printl( worldspawn.__KeyValueFromString("skyname",Skyboxes[Skyboxes_Type]));
	
	/* 太阳参数 */
	local envsun = null;
	while ((envsun = Entities.FindByClassname(envsun, "env_sun")) != null)
	{
		printl( envsun.__KeyValueFromString("size","10")); //太阳大小，16很小 256巨大		
	}
	/* 环境参数 */
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_c2m1_hdr")
	{
		GetSkyname = "阴天";
	}
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_night02_hdr")
	{
		GetSkyname = "夜晚";
		envfogcontroller();
	}
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_c4m1_hdr")
	{
		GetSkyname = "阴";
	}
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_c4m4_hdr")
	{
		GetSkyname = "暴雨";
		envfogcontroller();
	}
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_c6m1_hdr")
	{
		GetSkyname = "乌云";
	}
	if(Skyboxes[Skyboxes_Type] == "river_hdr")
	{
		GetSkyname = "多云转阴";
	}
	if(Skyboxes[Skyboxes_Type] == "docks_hdr")
	{
		GetSkyname = "多云转阴";
	}
	if(Skyboxes[Skyboxes_Type] == "sky_l4d_urban01_hdr")
	{
		GetSkyname = "夜晚";
		envfogcontroller();
	}
	if(Skyboxes[Skyboxes_Type] == "test_moon_hdr")
	{
		GetSkyname = "夜晚";
		envfogcontroller();
	}
	if(Skyboxes[Skyboxes_Type] == "sky_day01_09_hdr")
	{
		GetSkyname = "夜晚月亮";
		envfogcontroller();
	}
	if(Skyboxes[Skyboxes_Type] == "urbannightburning_hdr")
	{
		GetSkyname = "彩霞";
	}
	
	if(KillOrHeadShot_HUD == 4)
	{
		Random_HUD = RandomInt(1, 3);
	}
	if(MapIsValid(SessionState.MapName.tolower()) == 1)
	{
		Map_Data();
		Timers.AddTimer(0.5, false, Timer_AutoChangeMap);
	}
	if(CarAlarms_Off == 1)
	{
		Utils.DisableCarAlarms();
	}
	if(DelFootLockers_Off == 1)
	{
		Utils.RemoveFootLockers();
	}
	if(DelMiniguns_Off == 1)
	{
		Utils.SanitizeMiniguns();
	}
	if(DelZombieSpawns_Off == 1)
	{
		Utils.RemoveZombieSpawns();
	}
	if(DelUnheldMeds_Off == 1)
	{
		Utils.SanitizeUnheldMeds();
		Utils.SanitizeHeldMeds();
	}
	if(DelUnheldItems_Off == 1)
	{
		Utils.SanitizeUnheldItems();
		Utils.SanitizeHeldItems();
	}
	if(DelUnheldSecondary_Off == 1)
	{
		Utils.SanitizeUnheldSecondary();
		Utils.SanitizeHeldSecondary();
	}
	if(DelUnheldPrimary_Off == 1)
	{
		Utils.SanitizeUnheldPrimary();
		Utils.SanitizeHeldPrimary();
	}
	if(DelUnheldWeapons_Off == 1)
	{
		Utils.SanitizeUnheldWeapons();
		Utils.SanitizeHeldWeapons();
	}
	if(DelAllUnheldWeapons_Off == 1)
	{
		Utils.SanitizeAllUnheldWeapons();
		Utils.SanitizeWeapons();
	}
}
function OnGameEvent_player_ledge_grab(params)
{
	local Userid = null;
	local Useriddent = null;
	local Useriddent_BotOrPlayer = [];
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		Useriddent = GetPlayerFromUserID(Userid);
		if(Userid > 0)
		{
			if(!IsPlayerABot(Useriddent))
			{
				Useriddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Useriddent))
			{
				Useriddent_BotOrPlayer = "(电脑)";
			}
			LedgeGrabNum[Useriddent.GetEntityIndex()]++;
			Player(Useriddent).ShowHint("按蹲可放手", 10, "use_binding", "+duck", HUD_RandomColor());
			local Info = Useriddent_BotOrPlayer+Player(Useriddent).GetName()+" 抓墙"+LedgeGrabNum[Entity(Useriddent).GetBaseIndex()]+"次 >_<";
			local ent = Utils.SpawnInventoryItem( Info, Get_ZombieModels(Useriddent), Get_Position(Useriddent) );
			local hint = Utils.SetEntityHint(ent, Info, "icon_alert_red", 100000);
			hint.GetScriptScope()["hint"] <- hint;
			ent.GetScriptScope()["killinfo"] <- ent;
			Timers.AddTimer( 10.0, false, KillAttacker_Info, hint );
			Timers.AddTimer( 0.1, false, KillModels, ent );
		}
	}
}
function OnGameEvent_adrenaline_used(params)
{
	local subject = null;
	local subjectdent = null;
	local hudtip = null;
	local GetUseridTeam = null;
	local Subjectdent_BotOrPlayer = [];
	local GetSubjectModel = [];
	
	if(params.rawin("userid"))
	{
		subject = params["userid"];
		subjectdent = GetPlayerFromUserID(subject);
		GetUseridTeam = Get_UserIdTeam(subjectdent);
		if(subject > 0 && GetUseridTeam == 2)
		{
			AdrenalineUsed[subjectdent.GetEntityIndex()]++;
			GetSubjectModel = User_Model(subjectdent);
			if(!IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(电脑)";
			}
			Utils.SayToAll("[-]"+Subjectdent_BotOrPlayer+GetSubjectModel+":"+subjectdent.GetPlayerName()+"注射肾上腺素"+AdrenalineUsed[subjectdent.GetEntityIndex()]+"次，恢复少量生命");
		}
	}
}
function OnGameEvent_award_earned(params)
{
	if(ProtectInfo == 1)
	{
		local UserId = null;
		local UserIddent = null;
		local UserIddent_BotOrPlayer = [];
		local GetAwardInfo = [];
		local AwardInfo = null;
		local Info = [];
		if(params.rawin("userid") && params.rawin("award"))
		{
			UserId = params["userid"];
			UserIddent = GetPlayerFromUserID(UserId);
			local Award = EasyLogic.GetEventInt(params, "award");
			if(ProtectOff == 0)
			{
				if(!IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(玩家)";
				}
				if(IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(电脑)";
				}
				//	if(Award == 66) == 拉起队友		if(Award == 67) == 保护队友		if(Award == 87) == 攻击队友		
				//	if(Award == 70) == 治疗队友		if(Award == 98) == 杀死队友
				//	if(Award == 85) == 击倒队友		if(Award == 84) == 杀死队友
				if(Award == 67 || Award == 66 || Award == 70)
				{
					if(Award == 66)
					{
						GetAwardInfo = "拉起队友";
					}
					if(Award == 67)
					{
						GetAwardInfo = "保护队友";
					}
					if(Award == 70)
					{
						GetAwardInfo = "治疗队友";
					}
					if(UpgradeOff == 1)
					{
						if(!IsPlayerABot(UserIddent))
						{
							local GetPlayerHealth = (GetUpgradeKV(UserIddent, UpgradeIdx.Hp) + 100) - 1;
							if(Entity(UserIddent).GetHealth() <= GetPlayerHealth)
							{
								Entity(UserIddent).IncreaseHealth(Protect_AddHealth);
								Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+GetAwardInfo+"，奖励"+Protect_AddHealth+"点血");
								Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo+"，奖励"+Protect_AddHealth+"点血";
							}
							else
							{
								Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+GetAwardInfo);
								Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo;
							}
						}
						else
						{
							if(Entity(UserIddent).GetHealth() <= 99)
							{
								Entity(UserIddent).IncreaseHealth(Protect_AddHealth);
								Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+GetAwardInfo+"，奖励"+Protect_AddHealth+"点血");
								Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo+"，奖励"+Protect_AddHealth+"点血";
							}
							else
							{
								Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+GetAwardInfo);
								Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo;
							}
						}
					}
					else
					{
						if(Entity(UserIddent).GetHealth() <= 99)
						{
							Entity(UserIddent).IncreaseHealth(Protect_AddHealth); 
							Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo+"，奖励"+Protect_AddHealth+"点血";
						}
						else
						{
							Info = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+Player(UserIddent).GetName()+" "+GetAwardInfo;
						}
					}
					if(Protect_ShowHUD == 1)
					{
						AwardInfo = HUD.Item(Info);
						AwardInfo.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						AwardInfo.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						AwardInfo.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						AwardInfo.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 8.0, false, CloseHud, AwardInfo ); //添加计时器关闭HUD
					}
				}
			}
		}
	}
}
function OnGameEvent_pills_used(params)
{
	local subject = null;
	local subjectdent = null;
	local hudtip = null;
	local GetUseridTeam = null;
	local Subjectdent_BotOrPlayer = [];
	local GetSubjectModel = [];
	if(params.rawin("subject"))
	{
		subject = params["subject"];
		subjectdent = GetPlayerFromUserID(subject);
		GetUseridTeam = Get_UserIdTeam(subjectdent);
		if(subject > 0 && GetUseridTeam == 2)
		{
			PillsUsed[subjectdent.GetEntityIndex()]++;
			GetSubjectModel = User_Model(subjectdent);
			if(!IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(电脑)";
			}
			Utils.SayToAll("[-]"+Subjectdent_BotOrPlayer+GetSubjectModel+":"+subjectdent.GetPlayerName()+"口服止痛药"+PillsUsed[subjectdent.GetEntityIndex()]+"次，恢复少量生命");
		}
	}
}
function OnGameEvent_survivor_call_for_help(params)
{
	local Userid = null;
	local User = null;
    if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if(Userid > 0)
		{
			SurvivorCallForHelp[Entity(User).GetBaseIndex()] = 2;
		}
	}
}
function OnGameEvent_survivor_rescued(params)
{
    local Rescuer = null;
	local Victim = null;
    local RescuerId = null;
	local VictimId = null;
	local Dierent_BotOrPlayer = [];
	local Subjectdent_BotOrPlayer = [];
	local GetDierentModel = [];
	local GetSubjectModel = [];
    if(params.rawin("rescuer") && params.rawin("victim"))
	{
        Rescuer = params["rescuer"];
		Victim = params["victim"];
        RescuerId = GetPlayerFromUserID(Rescuer);
        VictimId = GetPlayerFromUserID(Victim);
		SurvivorCallForHelp[Entity(VictimId).GetBaseIndex()] = 0;
		if(Rescuer > 0 && Victim > 0 && Get_UserIdTeam(RescuerId) == 2)
		{
			GetSubjectModel = User_Model(VictimId);
			GetDierentModel = User_Model(RescuerId);
			if(!IsPlayerABot(RescuerId))
			{
				Dierent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(RescuerId))
			{
				Dierent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(VictimId))
			{
				Timers.AddTimer(0.1, false, Timer_Zoom, VictimId);
				Subjectdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(VictimId))
			{
				Subjectdent_BotOrPlayer = "(电脑)";
			}
			if(Rescuer != Victim)
			{
				if(!IsPlayerABot(VictimId) && _SetHealth[Entity(VictimId).GetBaseIndex()] == 1)
				{
					if(UpgradeOff == 1)
					{
						local NewHealth = GetUpgradeKV(VictimId, UpgradeIdx.Hp)+100;
						Entity(VictimId).SetMaxHealth(NewHealth);
						Player(VictimId).Give("health");
					}
					if(ModelOption == 8)
					{
						if(IsOfficialMaps() == 1)
						{
							if(MapIsValid(SessionState.MapName.tolower()) == 0)
							{
								Player(VictimId).GiveRandomMelee( );
							}
						}
					}
					if(ModelOption == 9)
					{
						if(ModelRandom == 8)
						{
							if(IsOfficialMaps() == 1)
							{
								if(MapIsValid(SessionState.MapName.tolower()) == 0)
								{
									Player(VictimId).GiveRandomMelee( );
								}
							}
						}
					}
				}
				Utils.SayToAll("[-]"+Dierent_BotOrPlayer+GetDierentModel+":"+Player(RescuerId).GetName()+"营救队友"+Subjectdent_BotOrPlayer+GetSubjectModel+":"+VictimId.GetPlayerName());
			}
		}
	}
}
function OnGameEvent_heal_success(params)
{
    local userid = null;
	local subject = null;
    local dierent = null;
	local subjectdent = null;
	local GetUserTeam = null;
	local Dierent_BotOrPlayer = [];
	local Subjectdent_BotOrPlayer = [];
	local GetDierentModel = [];
	local GetSubjectModel = [];
    if(params.rawin("userid") && params.rawin("subject"))
	{
        userid = params["userid"];
		subject = params["subject"];
        dierent = GetPlayerFromUserID(userid);
        subjectdent = GetPlayerFromUserID(subject);
		GetUserTeam = Get_UserIdTeam(dierent);
		if(userid > 0 && subject > 0 && GetUserTeam == 2)
		{
			GetSubjectModel = User_Model(subjectdent);
			GetDierentModel = User_Model(dierent);
			if(!IsPlayerABot(dierent))
			{
				Dierent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(dierent))
			{
				Dierent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(电脑)";
			}
			HealNum[dierent.GetEntityIndex()]++;
			if(userid != subject)
			{
				if(!IsPlayerABot(subjectdent) && _SetHealth[Entity(subjectdent).GetBaseIndex()] == 1 && UpgradeOff == 1)
				{
					local NewHealth = GetUpgradeKV(subjectdent, UpgradeIdx.Hp)+100;
					Entity(subjectdent).SetMaxHealth(NewHealth);
					Player(subjectdent).Give("health");
				}
				if(!IsPlayerABot(dierent) && dierent.IsValid() && Get_UserIdTeam(dierent) == 2 && UpgradeOff == 1)
				{
					AddExpKV(dierent, 4, subjectdent);
				}
				Utils.SayToAll("[-]"+Dierent_BotOrPlayer+GetDierentModel+":"+Player(dierent).GetName()+"治疗队友"+Subjectdent_BotOrPlayer+GetSubjectModel+":"+subjectdent.GetPlayerName()+"，总共治疗"+HealNum[dierent.GetEntityIndex()]+"次");
			}
			else
			{
				if(!IsPlayerABot(dierent) && _SetHealth[Entity(dierent).GetBaseIndex()] == 1 && UpgradeOff == 1)
				{
					local NewHealth = GetUpgradeKV(dierent, UpgradeIdx.Hp)+100;
					Entity(dierent).SetMaxHealth(NewHealth);
					Player(dierent).Give("health");
				}
				Utils.SayToAll("[-]"+Dierent_BotOrPlayer+GetDierentModel+":"+Player(dierent).GetName()+"治疗自己，总共治疗"+HealNum[dierent.GetEntityIndex()]+"次");
			}
		}
	}
}
function OnGameEvent_revive_success(params)
{
    local userid = null;
	local subject = null;
    local dierent = null;
	local subjectdent = null;
	local GetUserTeam = null;
	local GetSubjectTeam = null;
	local Dierent_BotOrPlayer = [];
	local Subjectdent_BotOrPlayer = [];
	local LastlifeBool = false;
    if(params.rawin("userid") && params.rawin("lastlife"))
	{
        userid = params["userid"];
		subject = params["subject"];
		LastlifeBool = params["lastlife"];
        dierent = GetPlayerFromUserID(userid);
        subjectdent = GetPlayerFromUserID(subject);
		GetUserTeam = Get_UserIdTeam(dierent);
		GetSubjectTeam = Get_UserIdTeam(subjectdent);
		if(userid > 0 && subject > 0 && (GetUserTeam == 2 || GetSubjectTeam == 2))
		{
			if(!IsPlayerABot(dierent))
			{
				Dierent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(dierent))
			{
				Dierent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(subjectdent))
			{
				Subjectdent_BotOrPlayer = "(电脑)";
			}
			if(userid != subject)
			{
				ReviveNum[dierent.GetEntityIndex()]++;
				if(LastlifeBool)
				{
					
					local Info = Subjectdent_BotOrPlayer+User_Model(subjectdent)+":"+subjectdent.GetPlayerName()+" 黑白状态";
					local ent = Utils.SpawnInventoryItem( Info, Get_ZombieModels(subjectdent), Get_Position(subjectdent) );
					local hint = Utils.SetEntityHint(ent, Info, "icon_defibrillator", 100000);
					hint.GetScriptScope()["hint"] <- hint;
					ent.GetScriptScope()["killinfo"] <- ent;
					Timers.AddTimer( 10.0, false, KillAttacker_Info, hint );
					Timers.AddTimer( 0.1, false, KillModels, ent );
				}
				if(!IsPlayerABot(dierent) && dierent.IsValid() && Get_UserIdTeam(dierent) == 2 && UpgradeOff == 1)
				{
					AddExpKV(dierent, 2, subjectdent);
				}
				Utils.SayToAll("[-]"+Dierent_BotOrPlayer+User_Model(dierent)+":"+Player(dierent).GetName()+"救起队友"+Subjectdent_BotOrPlayer+User_Model(subjectdent)+":"+subjectdent.GetPlayerName()+"，总共救起"+ReviveNum[dierent.GetEntityIndex()]+"次");
			}
			else
			{
				Utils.SayToAll("[-]"+Subjectdent_BotOrPlayer+User_Model(dierent)+":"+Player(subjectdent).GetName()+"自救");
			}
		}
	}
}
function OnGameEvent_player_spawn(params)
{
	local Userid = null;
	local User = null;
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if(Player(User).GetTeam() == SURVIVORS && !Entity(User).IsBot())
		{
			Timers.AddTimer(0.1, false, Timer_ShowInfo, User);
			Timers.AddTimer(0.1, false, Timer_Zoom, User);
		}
		if(Get_UserIdTeam(User) == 3 && NewTank == 0)
		{
			if(ModelOption == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						ZombieIncoming_Off = 1;
					}
					else
					{
						ZombieIncoming_Off = 0;
					}
				}
				else
				{
					ZombieIncoming_Off = 0;
				}
			}
			if(ModelOption == 9)
			{
				if(ModelRandom == 8)
				{
					if(IsOfficialMaps() == 1)
					{
						if(MapIsValid(SessionState.MapName.tolower()) == 0)
						{
							ZombieIncoming_Off = 1;
						}
						else
						{
							ZombieIncoming_Off = 0;
						}
					}
					else
					{
						ZombieIncoming_Off = 0;
					}
				}
			}
			/* 根据玩家力量大小而增减特感生命 */
			if(UpgradeOff == 1 && NewTank == 0)
			{
				local Random = 0;
				local NewHealth = 0;
				local AllHurt = 0;
				foreach (P in Players.All())
				{
					if(P.GetTeam() == SURVIVORS && ClientIsAlive(P) == 1 && !Entity(P).IsBot())
					{
						AllHurt += GetUpgradeKV(P, UpgradeIdx.Hurt)*HurtRandom;
					}
				}
				if(ModelOption == 0 || ModelOption == 1 || ModelOption == 3 || ModelOption == 4 || 
					ModelOption == 5 || ModelOption == 6 || ModelOption == 7 || ModelOption == 8)
				{
					if(Player(User).GetPlayerType() == Z_SPITTER)
					{
						Random = RandomInt(50, 100);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_HUNTER)
					{
						Random = RandomInt(200, 300);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_JOCKEY)
					{
						Random = RandomInt(300, 400);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_SMOKER)
					{
						Random = RandomInt(50, 100);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_BOOMER)
					{
						Random = RandomInt(50, 100);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_CHARGER)
					{
						Random = RandomInt(600, 700);
						NewHealth = AllHurt+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_TANK)
					{
						local Difficulty = Utils.GetDifficulty();
						if(Difficulty == "easy")
						{
							Random = RandomInt(1000, 2000)+2000;
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "normal")
						{
							Random = RandomInt(2000, 3000)+4000;
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "hard")
						{
							Random = RandomInt(3000, 4000)+6000;
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "impossible")
						{
							Random = RandomInt(4000, 5000)+8000;
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
					}
				}
				if(ModelOption == 2)
				{
					if(Player(User).GetPlayerType() == Z_SPITTER)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_HUNTER)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_JOCKEY)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_SMOKER)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_BOOMER)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_CHARGER)
					{
						Random = RandomInt(100, 100);
						NewHealth = 0+Random;
						Entity(User).SetMaxHealth(NewHealth);
						Player(User).Give("health");
					}
					if(Player(User).GetPlayerType() == Z_TANK)
					{
						local Difficulty = Utils.GetDifficulty();
						if(Difficulty == "easy")
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "normal")
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "hard")
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Difficulty == "impossible")
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
					}
				}
				if(ModelOption == 9)
				{
					if(ModelRandom != 2)
					{
						if(Player(User).GetPlayerType() == Z_SPITTER)
						{
							Random = RandomInt(50, 100);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_HUNTER)
						{
							Random = RandomInt(200, 300);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_JOCKEY)
						{
							Random = RandomInt(300, 400);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_SMOKER)
						{
							Random = RandomInt(50, 100);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_BOOMER)
						{
							Random = RandomInt(50, 100);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_CHARGER)
						{
							Random = RandomInt(600, 700);
							NewHealth = AllHurt+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_TANK)
						{
							local Difficulty = Utils.GetDifficulty();
							if(Difficulty == "easy")
							{
								Random = RandomInt(1000, 2000)+2000;
								NewHealth = AllHurt+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "normal")
							{
								Random = RandomInt(2000, 3000)+4000;
								NewHealth = AllHurt+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "hard")
							{
								Random = RandomInt(3000, 4000)+6000;
								NewHealth = AllHurt+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "impossible")
							{
								Random = RandomInt(4000, 5000)+8000;
								NewHealth = AllHurt+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
						}
					}
					else
					{
						if(Player(User).GetPlayerType() == Z_SPITTER)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_HUNTER)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_JOCKEY)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_SMOKER)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_BOOMER)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_CHARGER)
						{
							Random = RandomInt(100, 100);
							NewHealth = 0+Random;
							Entity(User).SetMaxHealth(NewHealth);
							Player(User).Give("health");
						}
						if(Player(User).GetPlayerType() == Z_TANK)
						{
							local Difficulty = Utils.GetDifficulty();
							if(Difficulty == "easy")
							{
								Random = RandomInt(1000, 2000)+2000;
								NewHealth = 0+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "normal")
							{
								Random = RandomInt(2000, 3000)+4000;
								NewHealth = 0+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "hard")
							{
								Random = RandomInt(3000, 4000)+6000;
								NewHealth = 0+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
							if(Difficulty == "impossible")
							{
								Random = RandomInt(4000, 5000)+8000;
								NewHealth = 0+Random;
								Entity(User).SetMaxHealth(NewHealth);
								Player(User).Give("health");
							}
						}
					}
				}
			}
			Timers.AddTimer(0.2, false, Timer_ZombieSpawn, User);
		}
	}
}
::Timer_ZombieSpawn <- function(User)
{
	local User_BotOrPlayer = [];
	if(!IsPlayerABot(User))
	{
		User_BotOrPlayer = "(玩家)";
	}
	if(IsPlayerABot(User))
	{
		User_BotOrPlayer = "(电脑)";
	}
	if(Get_ZombieName(User) == "坦克")
	{
		Timers.AddTimer(3.0, false, Timer_TankZero);
		foreach (p in Players.All())
		{
			if(!IsPlayerABot(p) && ClientIsAlive(p) == 1 && p.GetTeam() == SURVIVORS)
			{
				local TankDistance = Utils.CalculateDistance(Entity(p).GetLocation(), Entity(User).GetLocation())
				local TankInfo = "出现"+TankNum+"坦克，血量"+Entity(User).GetHealth()+"Hp，距离"+TankDistance.tointeger()+"m";
				Player(p).ShowHint(TankInfo, 8, "Stat_Most_Tank_Dmg", "", HUD_RandomColor());
			}
		}
	}
	else
	{
		local Info = User_BotOrPlayer+"出现，血量"+Entity(User).GetHealth()+"Hp";
		Player(User).Say(Info);
	}
}
::Timer_TankZero <- function(params)
{
	TankNum = 0;
}
function OnGameEvent_player_changename(params)
{
	local Userid = null;
	local User = null;
    if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if(Userid > 0 && !IsPlayerABot(User))
		{
			printf("踢出【"+User.GetPlayerName()+"】 原因：改名");
			Utils.SayToAll("[-]"+"踢出【"+User.GetPlayerName()+"】 原因：改名");
			local ServerCommand = "kickid "+User.GetPlayerUserId();
			SendToServerConsole(ServerCommand);
		}
	}
}

function OnGameEvent_hegrenade_detonate ( params )
{
	local Userid = null;
	local User = null;
	local GrenadeDetonateInfo = [];
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if (Player(User).GetPlayerType() == Z_SURVIVOR && !IsPlayerABot(User))
		{
			if (HeGrenadesType[Entity(User).GetBaseIndex()] > 0)
			{
				if (HeGrenadesType[Entity(User).GetBaseIndex()] == 1)
				{
					GrenadeDetonateInfo = "(玩家)"+User_Model(User)+":"+Player(User).GetName()+"的土制炸弹已爆炸";
				}
				if (HeGrenadesType[Entity(User).GetBaseIndex()] == 2)
				{
					GrenadeDetonateInfo = "(玩家)"+User_Model(User)+":"+Player(User).GetName()+"的燃烧瓶已摔碎燃烧";
				}
				local HegrenadeDetonate = HUD.Item(GrenadeDetonateInfo);
				HegrenadeDetonate.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
				HegrenadeDetonate.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
				HegrenadeDetonate.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
				HegrenadeDetonate.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
				Timers.AddTimer( 8.0, false, CloseHud, HegrenadeDetonate ); //添加计时器关闭HUD
				Timers.AddTimer( 0.5, false, Time_Resetting, User );
			}
		}
	}
}
::Time_Resetting <- function(client)
{
	if (!Entity(client).IsBot())
	{
		HeGrenadesType[Entity(client).GetBaseIndex()] = 0;
	}
}
function OnGameEvent_weapon_fire ( params )
{
	local Userid = null;
	local User = null;
	local ThrowGrenadesInfo = [];
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		if (Player(User).GetPlayerType() == Z_SURVIVOR && !IsPlayerABot(User))
		{
			if (Player(User).GetActiveWeapon().GetClassname() == "weapon_pipe_bomb" || Player(User).GetActiveWeapon().GetClassname() == "weapon_vomitjar" || Player(User).GetActiveWeapon().GetClassname() == "weapon_molotov")
			{
				if (Player(User).GetActiveWeapon().GetClassname() == "weapon_pipe_bomb")
				{
					ThrowGrenadesInfo = "(玩家)"+User_Model(User)+":"+Player(User).GetName()+" 扔出土制炸弹";
					HeGrenadesType[Entity(User).GetBaseIndex()] = 1;
				}
				if (Player(User).GetActiveWeapon().GetClassname() == "weapon_vomitjar")
				{
					ThrowGrenadesInfo = "(玩家)"+User_Model(User)+":"+Player(User).GetName()+" 扔出胆汁";
				}
				if (Player(User).GetActiveWeapon().GetClassname() == "weapon_molotov")
				{
					ThrowGrenadesInfo = "(玩家)"+User_Model(User)+":"+Player(User).GetName()+" 扔出燃烧瓶";
					HeGrenadesType[Entity(User).GetBaseIndex()] = 2;
				}
				local ThrowGrenades = HUD.Item(ThrowGrenadesInfo);
				ThrowGrenades.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
				ThrowGrenades.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
				ThrowGrenades.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
				ThrowGrenades.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
				Timers.AddTimer( 8.0, false, CloseHud, ThrowGrenades ); //添加计时器关闭HUD
			}
			if (Player(User).GetActiveWeapon().GetClassname() == "weapon_chainsaw")
			{
				local Clip = Entity(User).GetNetProp("m_iClip1");
				local ActiveWeapon = Entity(User).GetNetProp("m_hActiveWeapon");
				if(Mychainsaw[Entity(User).GetBaseIndex()] == 1)
				{
					if (Clip <= 0)
					{
						Entity(ActiveWeapon).SetNetProp( "m_iClip1", 30);
					}
				}
			}
		}
	}
}
function OnGameEvent_waiting_checkpoint_button_used(params)
{
	local Userid = null;
	local User = null;
	local hudtip = null;
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		local User_BotOrPlayer = [];
		if(!IsPlayerABot(User))
		{
			User_BotOrPlayer = "(玩家)";
			Player(User).PlaySound("Buttons.snd11");
		}
		if(IsPlayerABot(User))
		{
			User_BotOrPlayer = "(电脑)";
		}
		hudtip = HUD.Item(User_BotOrPlayer+User_Model(User)+":"+User.GetPlayerName()+" 启动失败，请等待所有人都准备好");
		hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
	}
}
function OnGameEvent_success_checkpoint_button_used(params)
{
	local Userid = null;
	local User = null;
	local hudtip = null;
	if(params.rawin("userid"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		local User_BotOrPlayer = [];
		if(!IsPlayerABot(User))
		{
			User_BotOrPlayer = "(玩家)";
		}
		if(IsPlayerABot(User))
		{
			User_BotOrPlayer = "(电脑)";
		}
		hudtip = HUD.Item(User_BotOrPlayer+User_Model(User)+":"+User.GetPlayerName()+" 成功启动检查点按钮");
		hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
	}
}
function OnGameEvent_player_use(params)
{
	if(PlayerTankInfo == 1)
	{
		local Userid = null;
		local User = null;
		local TargetId = null;
		local TargetIdInfo = [];
		local BotOrPlayer = [];
		if(params.rawin("userid") && params.rawin("targetid"))
		{
			Userid = params["userid"];
			User = GetPlayerFromUserID(Userid);
			TargetId = params["targetid"];
			TargetIdInfo = Entity(TargetId).GetClassname();
			if(PlayerTake[Entity(User).GetBaseIndex()] == 0)
			{
				Timers.AddTimer(5.0, false, Timer_PlayerTake, User);
				PlayerTake[Entity(User).GetBaseIndex()] = 1;
				if(!IsPlayerABot(User))
				{
					BotOrPlayer = "(玩家)";
				}
				if(IsPlayerABot(User))
				{
					BotOrPlayer = "(电脑)";
				}
				if(TargetIdInfo == "func_button" || TargetIdInfo == "func_button_timed")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 触发按钮");
					
				}
				else if(TargetIdInfo == "weapon_ammo_spawn" || TargetIdInfo == "weapon_ammo")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取弹药");
				}
				else if(TargetIdInfo == "upgrade_ammo_incendiary")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取燃烧弹");
				}
				else if(TargetIdInfo == "upgrade_ammo_explosive")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取高爆弹");
				}
				else if(TargetIdInfo == "weapon_chainsaw_spawn" || TargetIdInfo == "weapon_chainsaw")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取电锯");
				}
				else if(TargetIdInfo == "weapon_pain_pills_spawn" || TargetIdInfo == "weapon_pain_pills")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取止痛药");
				}
				else if(TargetIdInfo == "weapon_first_aid_kit_spawn" || TargetIdInfo == "weapon_first_aid_kit")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取医疗包");
				}
				else if(TargetIdInfo == "weapon_spawn")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取武器");
				}
				else if(TargetIdInfo == "weapon_adrenaline_spawn" || TargetIdInfo == "weapon_adrenaline")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取肾上腺素");
				}
				else if(TargetIdInfo == "upgrade_laser_sight")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取激光器并激活武器激光");
				}
				else if(TargetIdInfo == "weapon_upgradepack_explosive_spawn" || TargetIdInfo == "weapon_upgradepack_explosive")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取一盒高爆弹");
				}
				else if(TargetIdInfo == "weapon_upgradepack_incendiary_spawn" || TargetIdInfo == "weapon_upgradepack_incendiary")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取一盒燃烧弹");
				}
				else if(TargetIdInfo == "weapon_melee_spawn" || TargetIdInfo == "weapon_melee")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取近战");
				}
				else if(TargetIdInfo == "weapon_smg_spawn" || TargetIdInfo == "weapon_smg")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取冲锋枪");
				}
				else if(TargetIdInfo == "weapon_pistol_spawn" || TargetIdInfo == "weapon_pistol")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取手枪");
				}
				else if(TargetIdInfo == "weapon_pistol_magnum_spawn" || TargetIdInfo == "weapon_pistol_magnum")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取沙漠之鹰");
				}
				else if(TargetIdInfo == "weapon_pumpshotgun_spawn" || TargetIdInfo == "weapon_pumpshotgun")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取一代单喷");
				}
				else if(TargetIdInfo == "weapon_autoshotgun_spawn" || TargetIdInfo == "weapon_autoshotgun")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取一代连喷");
				}
				else if(TargetIdInfo == "weapon_rifle_spawn" || TargetIdInfo == "weapon_rifle")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取M16");
				}
				else if(TargetIdInfo == "weapon_hunting_rifle_spawn" || TargetIdInfo == "weapon_hunting_rifle")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取一代连阻");
				}
				else if(TargetIdInfo == "weapon_smg_silenced_spawn" || TargetIdInfo == "weapon_smg_silenced")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取消音冲锋枪");
				}
				else if(TargetIdInfo == "weapon_shotgun_chrome_spawn" || TargetIdInfo == "weapon_shotgun_chrome")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取二代单喷");
				}
				else if(TargetIdInfo == "weapon_sniper_military_spawn" || TargetIdInfo == "weapon_sniper_military")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取二代连阻");
				}
				else if(TargetIdInfo == "weapon_shotgun_spas_spawn" || TargetIdInfo == "weapon_shotgun_spas")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取二代连喷");
				}
				else if(TargetIdInfo == "weapon_rifle_ak47_spawn" || TargetIdInfo == "weapon_rifle_ak47")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取AK47步枪");
				}
				else if(TargetIdInfo == "weapon_rifle_desert_spawn" || TargetIdInfo == "weapon_rifle_desert")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取三连发步枪");
				}
				else if(TargetIdInfo == "weapon_smg_mp5" || TargetIdInfo == "weapon_smg_mp5_spawn")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取MP5冲锋枪");
				}
				else if(TargetIdInfo == "weapon_rifle_sg552" || TargetIdInfo == "weapon_rifle_sg552_spawn")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取SG552冲锋枪");
				}
				else if(TargetIdInfo == "weapon_sniper_awp" || TargetIdInfo == "weapon_sniper_awp_spawn")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取重狙击枪");
				}
				else if(TargetIdInfo == "weapon_sniper_scout" || TargetIdInfo == "weapon_sniper_scout_spawn")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取轻狙击枪");
				}
				else if(TargetIdInfo == "weapon_grenade_launcher_spawn" || TargetIdInfo == "weapon_grenade_launcher")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取榴弹枪");
				}
				else if(TargetIdInfo == "weapon_rifle_m60_spawn" || TargetIdInfo == "weapon_rifle_m60")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取M60机枪");
				}
				else if(TargetIdInfo == "prop_physics" || TargetIdInfo == "prop_dynamic")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取物品");
				}
				else if(TargetIdInfo == "weapon_molotov_spawn" || TargetIdInfo == "weapon_molotov")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取燃烧瓶");
				}
				else if(TargetIdInfo == "weapon_pipe_bomb_spawn" || TargetIdInfo == "weapon_pipe_bomb")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取土制炸弹");
				}
				else if(TargetIdInfo == "weapon_vomitjar_spawn" || TargetIdInfo == "weapon_vomitjar")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取胆汁");
				}
				else if(TargetIdInfo == "weapon_gascan_spawn" || TargetIdInfo == "weapon_gascan")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取汽油桶");
				}
				else if(TargetIdInfo == "weapon_defibrillator_spawn" || TargetIdInfo == "weapon_defibrillator")
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取电击器");
				}
				else
				{
					Utils.SayToAll("[-]"+BotOrPlayer+Player(User).GetName()+" 拾取未知物品 "+TargetIdInfo);
				}
			}
		}
	}
}
::Timer_PlayerTake <- function(client)
{
	PlayerTake[Entity(client).GetBaseIndex()] = 0;
}
function OnGameEvent_player_team(params)
{
	local Userid = null;
	local User = null;
	local Team = null;
	local Oldteam = null;
	local hudtip = null;
	local TeamInfo = [];
	local GetOldteamInfo = [];
	local disconnect = false;
    if(params.rawin("userid") && params.rawin("team") && params.rawin("oldteam"))
	{
		Userid = params["userid"];
		User = GetPlayerFromUserID(Userid);
		Team = params["team"];
		Oldteam = params["oldteam"];
		disconnect = params["disconnect"];
		if(disconnect)
		{
			RescueTimer[User.GetEntityIndex()] = 0;
			GetRescueTime[User.GetEntityIndex()] = 0;
			SurvivorCallForHelp[User.GetEntityIndex()] = 0;
			if(!IsPlayerABot(User))
			{
				HeadShotNum[User.GetEntityIndex()] = 0;
				KillNum[User.GetEntityIndex()] = 0;
				KillCount[User.GetEntityIndex()] = 0;
				_HeadShot[User.GetEntityIndex()] = 0;
				Kill_InfectedNum[User.GetEntityIndex()] = 0;
				TongueGrab[User.GetEntityIndex()] = 0;
				LungePounce[User.GetEntityIndex()] = 0;
				DmgTankHealth[User.GetEntityIndex()] = 0;
				ClientKillNum[User.GetEntityIndex()] = 0;
				LedgeGrabNum[User.GetEntityIndex()] = 0;
				JockeyRide[User.GetEntityIndex()] = 0;
				ChargerPummel[User.GetEntityIndex()] = 0;
				DeathNum[User.GetEntityIndex()] = 0;
				ReviveNum[User.GetEntityIndex()] = 0;
				DefibrillatorNum[User.GetEntityIndex()] = 0;
				GetTankHealth[User.GetEntityIndex()] = 0;
				DoorOpenNum[User.GetEntityIndex()] = 0;
				DoorCloseNum[User.GetEntityIndex()] = 0;
				PillsUsed[User.GetEntityIndex()] = 0;
				HealNum[User.GetEntityIndex()] = 0;
				AdrenalineUsed[User.GetEntityIndex()] = 0;
				ClientDmgHealth[User.GetEntityIndex()] = 0;
				WarningClient[User.GetEntityIndex()] = 0;
				ClientkillMax[User.GetEntityIndex()] = 0;
				StartPlaying[User.GetEntityIndex()] = 0;
				CirculatePlay[User.GetEntityIndex()] = 0;
				RegeneratesHP[User.GetEntityIndex()] = 0;
				_SetHealth[User.GetEntityIndex()] = 0;
				PlayerTake[User.GetEntityIndex()] = 0;
				ExperiencePercent[User.GetEntityIndex()] = 0;
				HeGrenadesType[User.GetEntityIndex()] = 0;
				Fov[User.GetEntityIndex()] = 0;
				Mychainsaw[User.GetEntityIndex()] = 0;
			}
		}
		if(User.GetClassname() == "player" && !IsPlayerABot(User) && IsFinaleWin == 0)
		{
			if(Oldteam == 1)
			{
				GetOldteamInfo = " 从旁观者成为 ";
			}
			if(Oldteam == 2)
			{
				GetOldteamInfo = " 从幸存者成为 ";
			}
			if(Oldteam == 3)
			{
				GetOldteamInfo = " 从感染者成为 ";
			}
			if(Oldteam == 0)
			{
				GetOldteamInfo = " 成为 ";
			}
			if(Team > 0)
			{
				if(Team == 1)
				{
					TeamInfo = GetOldteamInfo+"旁观者，用户ID("+User.GetPlayerUserId()+")";
				}
				if(Team == 2)
				{
					Timers.AddTimer(0.1, false, Timer_Zoom, User);
					TeamInfo = GetOldteamInfo+"幸存者，用户ID("+User.GetPlayerUserId()+")";
					Timers.AddTimer(0.1, false, Timer_ShowInfo, User);
				}
				if(Team == 3)	TeamInfo = GetOldteamInfo+"感染者，用户ID("+User.GetPlayerUserId()+")";
				hudtip = HUD.Item(User.GetPlayerName()+TeamInfo);
				hudtip.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
				hudtip.ChangeHUDNative(10, 40, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
				hudtip.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
				hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
				Timers.AddTimer( 8.0, false, Close_TeamHud, hudtip ); //添加计时器关闭HUD
			}
		}
	}
}
function OnGameEvent_player_hurt(params)
{
    local VictimId = null;
	local Victim = null;
	local AttackerId = null;
	local Attacker = null;
	local _GetHealth = 0;
	local _DamHealth = 0;
	local HitGroup = 0;
	local TankHealthPP = 0;
	local hudtip = null;
	local TankHealthBar = [];
	local HitgroupInfo = [];
	local Victim_BotOrPlayer = [];
	local Attacker_BotOrPlayer = [];
	local GetSurvivorModel = [];
	local GetVictimTeam = [];
	local ZombieType = [];
	local SetHint = [];
	local DrawText = [];
	if(params.rawin("userid") && params.rawin("attacker") && params.rawin("health") && params.rawin("dmg_health") && params.rawin("hitgroup"))
	{
		VictimId = params["userid"];
		AttackerId = params["attacker"];
		_DamHealth = params["dmg_health"];
		_GetHealth = params["health"];
		HitGroup = params["hitgroup"];
		if(HitGroup == 0)
		{
			HitgroupInfo = " 受伤";
		}
		if(HitGroup == 1)
		{
			HitgroupInfo = " 头部受伤";
		}
		if(HitGroup == 2)
		{
			HitgroupInfo = " 胸部受伤";
		}
		if(HitGroup == 3)
		{
			HitgroupInfo = " 腹部受伤";
		}
		if(HitGroup == 4)
		{
			HitgroupInfo = " 左手受伤";
		}
		if(HitGroup == 5)
		{
			HitgroupInfo = " 右手受伤";
		}
		if(HitGroup == 6)
		{
			HitgroupInfo = " 左脚受伤";
		}
		if(HitGroup == 7)
		{
			HitgroupInfo = " 右脚受伤";
		}
		Victim = GetPlayerFromUserID(VictimId);
		Attacker = GetPlayerFromUserID(AttackerId);
		if(_GetHealth > 0 && VictimId > 0 && AttackerId > 0 && VictimId != AttackerId && !Player(Victim).IsIncapacitated() && !Player(Victim).IsHangingFromLedge())
		{
			if(Get_UserIdTeam(Attacker) == 2 && ClientIsAlive(Attacker) == 1 && GetUpgradeKV(Attacker, UpgradeIdx.Hurt) > 0 && !IsPlayerABot(Attacker))
			{
				if(Entity(Victim).GetHealth() >= (_DamHealth + GetUpgradeKV(Attacker, UpgradeIdx.Hurt)) && Get_UserIdTeam(Victim) == 3 && ClientIsAlive(Victim) == 1)
				{
					if(UpgradeOff == 1)
					{
						if(Attacker.GetActiveWeapon().GetClassname() != "weapon_melee")
						{
							local NewDam = Entity(Victim).GetHealth() - (_DamHealth + GetUpgradeKV(Attacker, UpgradeIdx.Hurt));
							Entity(Victim).SetHealth(NewDam);
						}
					}
				}
			}
			if(Get_UserIdTeam(Victim) == 2 && Get_UserIdTeam(Attacker) > 1 && !Player(Attacker).IsIncapacitated() && !Player(Attacker).IsHangingFromLedge() && !IsPlayerABot(Attacker) && !IsPlayerABot(Victim))
			{
				if(UpgradeOff == 1)
				{
					if(GetUpgradeKV(Attacker, UpgradeIdx.Hurt) > 0)
					{
						ClientDmgHealth[Attacker.GetEntityIndex()] += _DamHealth + GetUpgradeKV(Attacker, UpgradeIdx.Hurt);
					}
					else
					{
						ClientDmgHealth[Attacker.GetEntityIndex()] += _DamHealth;
					}
				}
				else
				{
					ClientDmgHealth[Attacker.GetEntityIndex()] += _DamHealth;
				}
				if(FadeScreen_Off == 1)
				{
					Utils.FadeScreen(Player(Attacker), 0, 0, 0, 255, 0.5, 0.0, false, true);
				}
				if(ClientDmgHealth[Attacker.GetEntityIndex()] >= _SetDmgMax)
				{
					if(!IsPlayerABot(Attacker))
					{
						Attacker_BotOrPlayer = "(玩家)";
					}
					if(IsPlayerABot(Attacker))
					{
						Attacker_BotOrPlayer = "(电脑)";
					}
					WarningClient[Attacker.GetEntityIndex()]++;
					if(WarningClient[Attacker.GetEntityIndex()] >= _SetWarningMax)
					{
						printf("踢出【"+Attacker.GetPlayerName()+"】 原因：故意射击玩家");
						Utils.SayToAll("[-]"+"踢出【"+Attacker.GetPlayerName()+"】 原因：故意射击玩家");
						local ServerCommand = "kickid "+Attacker.GetPlayerUserId();
						SendToServerConsole(ServerCommand);
					}
					else
					{
						Utils.SayToAll("-"+"踢人：故意射击队友>>>"+Attacker.GetPlayerName()+"受到警告"+WarningClient[Attacker.GetEntityIndex()]+"/"+_SetWarningMax+"次");
					}
				}
			}
			GetSurvivorModel = User_Model(Victim);
			ZombieType = Get_ZombieName(Victim);
			GetVictimTeam = Get_UserIdTeam(Victim);
			if(TRDebugDrawText_Off == 1)
			{
				if(ZombieType == "坦克")
				{
					TankHealthBar = Utils.BuildProgressBar(28, _GetHealth, GetTankHealth[Victim.GetEntityIndex()], "|", " ")
					DrawText = "          "+Entity(Victim).GetActorName()+"\nHp-"+_GetHealth+TankHealthBar;
					DebugDrawText(Get_EyePosition(Victim), DrawText, true, 1);
					SetNewTankHealth = Entity(Victim).GetHealth();
				}
				else	
				{
					DrawText = Entity(Victim).GetActorName()+"-"+_GetHealth+" Hp"
					DebugDrawText(Get_EyePosition(Victim), DrawText, true, 1);
				}
			}
			if(!IsPlayerABot(Victim))
			{
				Victim_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Victim))
			{
				Victim_BotOrPlayer = "(电脑)";
			}
			hudtip = HUD.Item("{info01}\n{info02}");
			if(GetVictimTeam == 2)
			{
				hudtip.SetValue("info01", Victim_BotOrPlayer+GetSurvivorModel+":"+Victim.GetPlayerName()+HitgroupInfo);
			}
			if(GetVictimTeam == 3)
			{
				if(ZombieType == "坦克")
				{
					if(AttackerId > 0 && Get_UserIdTeam(Attacker) == 2)
					{
						if(UpgradeOff == 1)
						{
							if(GetUpgradeKV(Attacker, UpgradeIdx.Hurt) > 0)
							{
								DmgTankHealth[Attacker.GetEntityIndex()] += _DamHealth + GetUpgradeKV(Attacker, UpgradeIdx.Hurt);
							}
							else
							{
								DmgTankHealth[Attacker.GetEntityIndex()] += _DamHealth;
							}
						}
						else
						{
							DmgTankHealth[Attacker.GetEntityIndex()] += _DamHealth;
						}
					}
				}
				hudtip.SetValue("info01", Victim_BotOrPlayer+ZombieType+":"+Victim.GetPlayerName()+HitgroupInfo);
			}
			if(ZombieType == "坦克")
			{
				TankHealthPP = _GetHealth / GetTankHealth[Victim.GetEntityIndex()] * 100;
				TankHealthBar = Utils.BuildProgressBar(28, _GetHealth, GetTankHealth[Victim.GetEntityIndex()], "|", " ")
				hudtip.SetValue("info02", TankHealthPP.tointeger()+"%HP "+TankHealthBar);
			}
			else
			{
				if(UpgradeOff == 1)
				{
					if(GetUpgradeKV(Attacker, UpgradeIdx.Hurt) > 0 && !IsPlayerABot(Attacker))
					{
						local NewDam = _DamHealth + GetUpgradeKV(Attacker, UpgradeIdx.Hurt);
						hudtip.SetValue("info02", "伤害["+NewDam+"]Hp，剩余["+_GetHealth+"]Hp");
					}
					else
					{
						hudtip.SetValue("info02", "伤害["+_DamHealth+"]Hp，剩余["+_GetHealth+"]Hp");
					}
				}
				else
				{
					hudtip.SetValue("info02", "伤害["+_DamHealth+"]Hp，剩余["+_GetHealth+"]Hp");
				}
			}
			hudtip.AttachTo(HUD_RIGHT_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			hudtip.ChangeHUDNative(250, 397, 1024, 300, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG|HUD_FLAG_BLINK); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
		}
	}
}
function OnActivate()
{
	for(local P=0;P<=32;P+=1)
	{
		HeadShotNum[P] <- 0;
		KillNum[P] <- 0;
		KillCount[P] <- 0;
		_HeadShot[P] <- 0;
		Kill_InfectedNum[P] <- 0;
		DeathNum[P] <- 0;
		DmgTankHealth[P] <- 0;
		ClientKillNum[P] <- 0;
		TongueGrab[P] <- 0;
		LungePounce[P] <- 0;
		LedgeGrabNum[P] <- 0;
		JockeyRide[P] <- 0;
		ChargerPummel[P] <- 0;
		ReviveNum[P] <- 0;
		DefibrillatorNum[P] <- 0;
		GetTankHealth[P] <- 0;
		DoorOpenNum[P] <- 0;
		DoorCloseNum[P] <- 0;
		HealNum[P] <- 0;
		PillsUsed[P] <- 0;
		AdrenalineUsed[P] <- 0;
		ClientDmgHealth[P] <- 0;
		WarningClient[P] <- 0;
		ClientkillMax[P] <- 0;
		StartPlaying[P] <- 0;
		CirculatePlay[P] <- 0;
		RegeneratesHP[P] <- 0;
		_SetHealth[P] <- 0;
		PlayerTake[P] <- 0;
		RescueTimer[P] <- 0;
		GetRescueTime[P] <- 0;
		SurvivorCallForHelp[P] <- 0;
		ExperiencePercent[P] <- 0;
		HeGrenadesType[P] <- 0;
		Fov[P] <- 0;
		Mychainsaw[P] <- 0;
	}
}
::KillModels <- function(info)
{
	local Getkillinfo = info.GetScriptScope();
	if ("killinfo" in Getkillinfo)
		Getkillinfo["killinfo"].Kill();
}
::KillAttacker_Info <- function(hud)
{
	local GetHud = hud.GetScriptScope();
	if ("hint" in GetHud)
		GetHud["hint"].Kill();
}
::TimeRescue <- function(client)
{
	if (Player(client).GetTeam() == SURVIVORS && !Player(client).IsAlive())
	{
		RescueTimer[Entity(client).GetBaseIndex()]++;
		local _GetFloat = Convars.GetFloat("rescue_min_dead_time");
		if((_GetFloat > GetRescueTime[Entity(client).GetBaseIndex()]) && GetRescueTime[Entity(client).GetBaseIndex()] >= 0)
		{
			GetRescueTime[Entity(client).GetBaseIndex()] = _GetFloat - RescueTimer[Entity(client).GetBaseIndex()];
			Timers.AddTimer(1.0, false, TimeRescue, client);
		}
		else
		{
			if(AotoRescue_Off == 1)
			{
				Timers.AddTimer(5.0, false, Timer_AotoRescue, client);
			}
			GetRescueTime[Entity(client).GetBaseIndex()] = 0;
			RescueTimer[Entity(client).GetBaseIndex()] = 0;
		}
	}
	else
	{
		GetRescueTime[Entity(client).GetBaseIndex()] = 0;
		RescueTimer[Entity(client).GetBaseIndex()] = 0;
	}
}
::Timer_AotoRescue <- function(client)
{
	if (Player(client).IsDead() || Player(client).IsDying())
	{
		Player(client).Defib();
		Timers.AddTimer(2.0, false, Timer_SetLocation, client);
	}
}
::Timer_SetLocation <- function(client)
{
	Entity(client).SetLocation(Entity(GetRandomSurvivor()).GetLocation());
}
::GetRandomSurvivor <- function()
{
	local t = {};
	local ent = null;
	local i = -1;
	while (ent = Entities.FindByClassname(ent, "player"))
	{
		if (ent.IsValid())
		{
			local libObj = ::VSLib.Player(ent);
			if (libObj.GetTeam() == SURVIVORS && libObj.IsAlive() && !Player(libObj).IsHangingFromLedge())
				t[++i] <- libObj;
		}
	}
	
	return Utils.GetRandValueFromArray(t);
}
/* 创建补给 */
::CreateSpawn <- function(target)
{
	if(Player(target).GetTeam() == INFECTED && !Player(target).IsAlive())
	{
		local duration = 20; //设置多少秒后删除补给
		local R = 5; //设置补给产卵概率
		local spawnkey = {};
		local GetModel = [];
		local name = [];
		local _class = [];
		local icon = [];
		local Random = RandomInt(1, 2);
		if(RandomInt(1, 100) <= R)
		{
			if(Random == 1) //产卵弹药堆
			{
				name = "弹药";
				_class = "weapon_ammo_spawn";
				icon = "icon_ammo";
				local Random_Model = RandomInt(1, 6);
				if(Random_Model == 1)
				{
					GetModel = "models/props_urban/plastic_flamingo001.mdl"; //粉红色鸟
				}
				if(Random_Model == 2)
				{
					GetModel = "models/deadbodies/dead_male_sittingchair.mdl"; //坐在转椅上男尸体
				}
				if(Random_Model == 3)
				{
					GetModel = "models/props_junk/gnome.mdl"; //圣诞老人
				}
				if(Random_Model == 4)
				{
					GetModel = "models/props_placeable/chopper_gas_trophy.mdl"; //装饰黄色直升机
				}
				if(Random_Model == 5)
				{
					GetModel = "models/props_placeable/mine_trophy.mdl"; //装饰黄色轮盘
				}
				if(Random_Model == 6)
				{
					GetModel = "models/props_placeable/tier1_guns_trophy.mdl"; //装饰黄色武器
				}
				spawnkey =
				{
					angles = Entity(target).GetAngles(),
					model = GetModel,
					skin = "0",
					body = "0",
					Shadows = "No",
					solid = "Use VPhysics",
					count = "999",
				};
			}
			if(Random == 2) //产卵随机补给
			{
				local R = RandomInt(1, 19);
				if(R == 1)
				{
					name = "M16";
					_class = "weapon_rifle_spawn";
				}
				if(R == 2)
				{
					name = "AK47";
					_class = "weapon_rifle_ak47_spawn";
				}
				if(R == 3)
				{
					name = "沙漠步枪";
					_class = "weapon_rifle_desert_spawn";
				}
				if(R == 4)
				{
					name = "二代单喷";
					_class = "weapon_shotgun_chrome_spawn";
				}
				if(R == 5)
				{
					name = "二代连喷";
					_class = "weapon_shotgun_spas_spawn";
				}
				if(R == 6)
				{
					name = "SMG";
					_class = "weapon_smg_silenced_spawn";
				}
				if(R == 7)
				{
					name = "二代连狙";
					_class = "weapon_sniper_military_spawn";
				}
				if(R == 8)
				{
					name = "高爆弹升级包";
					_class = "weapon_upgradepack_explosive_spawn";
				}
				if(R == 9)
				{
					name = "燃烧弹升级包";
					_class = "weapon_upgradepack_incendiary_spawn";
				}
				if(R == 10)
				{
					name = "胆汁";
					_class = "weapon_vomitjar_spawn";
				}
				if(R == 11)
				{
					name = "燃烧瓶";
					_class = "weapon_molotov_spawn";
				}
				if(R == 12)
				{
					name = "土制炸弹";
					_class = "weapon_pipe_bomb_spawn";
				}
				if(R == 13)
				{
					name = "沙漠之鹰";
					_class = "weapon_pistol_magnum_spawn";
				}
				if(R == 14)
				{
					name = "一代连狙";
					_class = "weapon_hunting_rifle_spawn";
				}
				if(R == 15)
				{
					name = "榴弹枪";
					_class = "weapon_grenade_launcher_spawn";
				}
				if(R == 16)
				{
					name = "医疗包";
					_class = "weapon_first_aid_kit_spawn";
				}
				if(R == 17)
				{
					name = "电锯";
					_class = "weapon_chainsaw_spawn";
				}
				if(R == 18)
				{
					name = "一代连喷";
					_class = "weapon_autoshotgun_spawn";
				}
				if(R == 19)
				{
					name = "肾上腺素";
					_class = "weapon_adrenaline_spawn";
				}
				icon = "icon_upgrade";
				spawnkey =
				{
					angles = Entity(target).GetAngles(),
					skin = "0",
					body = "0",
					disableshadows = "No",
					solid = "Use VPhysics",
					count = "1",
				};
			}
			local spawn = Utils.SpawnEntity(_class, "vslib_spawn", Entity(target).GetPosition(), Entity(target).GetAngles(), spawnkey);

			if ( duration > 0 )
				spawn.Input("Kill", "", duration);

			local ent = Utils.SpawnInventoryItem( name, "models/infected/spitter.mdl", Entity(target).GetPosition() );
			local hint = Utils.SetEntityHint(ent, name, icon, 1000);
			hint.GetScriptScope()["hint"] <- hint;
			ent.GetScriptScope()["killinfo"] <- ent;
			Timers.AddTimer( duration, false, KillAttacker_Info, hint );
			Timers.AddTimer( 0.1, false, KillModels, ent );
		}
	}
}
/* 特感死亡辉光 */
::L4D2_SetEntGlow <- function(client)
{
	if(Player(client).GetTeam() == INFECTED && !Player(client).IsAlive())
	{
		local red = RandomInt(0, 255);
		local green = RandomInt(0, 255);
		local blue = RandomInt(0, 255);
		
		Entity(client).SetNetProp("m_Glow.m_iGlowType", 2);
		Entity(client).SetNetProp("m_Glow.m_nGlowRange", 0);
		Entity(client).SetNetProp("m_Glow.m_nGlowRangeMin", 0);
		Entity(client).SetNetProp("m_Glow.m_glowColorOverride", Utils.SetColor32( red, green, blue, 255 ));
		Entity(client).SetNetProp("m_Glow.m_bFlashing", true);
		Entity(client).SetNetProp("m_Glow.m_iTeamNum", 3);
		Entity(client).SetNetProp("m_Glow.m_CollisionGroup", 1);
	}
}
function OnGameEvent_player_death(params)
{
	local dier = null;
	local Attacker = null;
    local dierent = null;
	local Attackerdent = null;
	local HeadShot = false;
	local hudtip = null;
	local dierent_BotOrPlayer = [];
	local attackerdent_BotOrPlayer = [];
	local GetAttackerWeapon = [];
	local GetAttackerTeam = null;
	local GetDierentTeam = null;
	local Dist = 0;
	local GetAttackerModel = [];
	local GetDierentModel = [];
	local ZombieType = [];
	local Zombie_Type = [];
	local DropItem = [];
	local GetType = [];
	local KillInfo = [];
	local HeadShotInfo = [];
    if(params.rawin("userid") && params.rawin("headshot") && params.rawin("attacker"))
	{
        dier = params["userid"];
		Attacker = params["attacker"];
		HeadShot = params["headshot"];
        dierent = GetPlayerFromUserID(dier);
        Attackerdent = GetPlayerFromUserID(Attacker);
		GetDierentTeam = Get_UserIdTeam(dierent);
		if(Player(dierent).GetTeam() == SURVIVORS && RescueTimer[Entity(dierent).GetBaseIndex()] == 0 && ShowRescueTime_Off == 1)
		{
			SurvivorCallForHelp[Entity(dierent).GetBaseIndex()] = 1;
			local origin = Entity(dierent).GetLocation();
			foreach ( death_model in Objects.OfClassnameWithin( "survivor_death_model", origin, 1 ) )
			{
				Entity(death_model).SetLocation(Entity(GetRandomSurvivor()).GetLocation());
			}
			Timers.AddTimer(1.0, false, TimeRescue, dierent);
		}
		if(!IsPlayerABot(Attackerdent))
		{
			attackerdent_BotOrPlayer = "(玩家)";
		}
		if(IsPlayerABot(Attackerdent))
		{
			attackerdent_BotOrPlayer = "(电脑)";
		}
		if(!IsPlayerABot(dierent))
		{
			dierent_BotOrPlayer = "(玩家)";
		}
		if(IsPlayerABot(dierent))
		{
			dierent_BotOrPlayer = "(电脑)";
		}
		if(Get_UserIdTeam(dierent) == 2 && !IsPlayerABot(dierent) && dier != Attacker && ClientIsAlive(Attackerdent) == 1)
		{
			ClientkillMax[Entity(Attackerdent).GetBaseIndex()]++;
			if(ClientkillMax[Entity(Attackerdent).GetBaseIndex()] >= _SetkillNum)
			{
				printf("踢出【"+Attackerdent.GetPlayerName()+"】 原因：故意杀死玩家");
				Utils.SayToAll("[-]"+"踢出【"+Attackerdent.GetPlayerName()+"】 原因：故意杀死玩家");
				local ServerCommand = "kickid "+Attackerdent.GetPlayerUserId();
				SendToServerConsole(ServerCommand);
			}
			else
			{
				Utils.SayToAll("-"+"踢人：故意杀死队友>>>"+Attackerdent.GetPlayerName()+"受到警告"+ClientkillMax[Attackerdent.GetEntityIndex()]+"/"+_SetkillNum+"次");
			}
		}
		if(GetDierentTeam == 2 && dierent.IsValid())
		{
			IsSurvivorsDeathCount++;
			::TotalDeathNum.survivorsdeath++;
			FileIO.SaveTable( "total_DeathNum", _SaveDeathNum());
		}
		if(GetDierentTeam == 3 && dierent.IsValid())
		{
			IsInfectedDeathCount++;
			::TotalDeathNum.infectiondeath++;
			FileIO.SaveTable( "total_DeathNum", _SaveDeathNum());
		}
		if((GetDierentTeam == 3 || GetDierentTeam == 2) && dierent.IsValid())
		{
			/* 杀手留名 */
			if(Player(dierent).GetPlayerType() == Z_SURVIVOR)
			{
				local GetIcon = [];
				local GetAttacker_Info = [];
				local GetDistance = GetCalculateDistance(Attackerdent, dierent);
				GetIcon = "icon_skull";
				if(Get_UserIdTeam(Attackerdent) > 1)
				{
					GetAttacker_Info = "杀手:"+attackerdent_BotOrPlayer+Player(Attackerdent).GetName()+"，距离:"+GetDistance.tointeger()+"m";
				}
				else
				{
					GetAttacker_Info = "杀手:无名";
				}
				
				local ent = Utils.SpawnInventoryItem( GetAttacker_Info, Get_ZombieModels(dierent), Get_Position(dierent) );
				local hint = Utils.SetEntityHint(ent, GetAttacker_Info, GetIcon, 200);
				hint.GetScriptScope()["hint"] <- hint;
				ent.GetScriptScope()["killinfo"] <- ent;
				Timers.AddTimer( 10.0, false, KillAttacker_Info, hint );
				Timers.AddTimer( 0.1, false, KillModels, ent );
			}
			
			
			
			if(Get_UserIdTeam(Attackerdent) == 2 && !IsPlayerABot(Attackerdent) && UpgradeOff == 1)
			{
				AddExpKV(Attackerdent, 1, dierent);
			}
		}
		if(GetDierentTeam == 2)
		{
			if(SpawnCommentaryDummy_Off == 1)
			{
				local Probability = RandomInt(1, 100);
				if(Probability <= SpawnCommentaryDummy_Probability)
				{
					local GetModels = _GetSurvivorModel(dierent);
					local Random = RandomInt(1, 7);
					if(Random == 1)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_rifle", "Idle_Calm_Rifle", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 2)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_pistol", "Idle_Calm_Pistol", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 3)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_pumpshotgun", "Idle_Calm_Pumpshotgun", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 4)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_sniper_military", "Idle_Calm_Sniper_Military", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 5)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_chainsaw", "Idle_Calm_Chainsaw", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 6)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_gascan", "Idle_Calm_Gascan", Get_Position(dierent), GetIdAngles(dierent));
					}
					if(Random == 7)
					{
						Utils.SpawnCommentaryDummy(GetModels, "weapon_gnome", "Idle_Calm_Gnome", Get_Position(dierent), GetIdAngles(dierent));
					}
				}
			}
		}
		if(dier > 0 && Attacker > 0)
		{
			GetAttackerTeam = Get_UserIdTeam(Attackerdent);
			ZombieType = Get_ZombieName(dierent);
			Zombie_Type = Get_ZombieName(Attackerdent);
			Dist = GetCalculateDistance(Attackerdent, dierent);
			if(GiveOrSpawnOff == 1)
			{
				if(GetDierentTeam == 3 && GetAttackerTeam == 2 && ClientIsAlive(Attackerdent) == 1)
				{
					local Probability = RandomInt(1, 100);
					DropItem = RandomItem();
					if(Probability <= GiveOrSpawnProbability)
					{
						Attackerdent.GiveItem(DropItem);
						GetAttackerModel = User_Model(Attackerdent);
						Utils.SayToAll("[-]"+"("+GetAttackerModel+")"+Player(Attackerdent).GetName()+"击杀"+ZombieType+"，获得"+GetGiveItemsName);
					}
				}
			}
			if(GiveOrSpawnOff == 2)
			{
				if(GetDierentTeam == 3 && GetAttackerTeam == 2 && ClientIsAlive(Attackerdent) == 1)
				{
					local Probability = RandomInt(1, 100);
					if(Probability <= GiveOrSpawnProbability)
					{
						Utils.SpawnWeapon(GetSpawnItem(), 1, 500, Get_EyePosition(dierent), GetIdAngles(dierent));
						Utils.SayToAll("[-]"+"(特感)"+ZombieType+":"+Player(dierent).GetName()+"死亡，掉落"+GetSpawnItemName);
					}
				}
			}
			if(GiveOrSpawnOff == 3)
			{
				local Random = RandomInt(1, 2);
				if(Random == 1)
				{
					if(GetDierentTeam == 3 && GetAttackerTeam == 2 && ClientIsAlive(Attackerdent) == 1)
					{
						local Probability = RandomInt(1, 100);
						DropItem = RandomItem();
						if(Probability <= GiveOrSpawnProbability)
						{
							Attackerdent.GiveItem(DropItem);
							GetAttackerModel = User_Model(Attackerdent);
							Utils.SayToAll("[-]"+"("+GetAttackerModel+")"+Player(Attackerdent).GetName()+"击杀"+ZombieType+"，获得"+GetGiveItemsName);
						}
					}
				}
				if(Random == 2)
				{
					if(GetDierentTeam == 3 && GetAttackerTeam == 2 && ClientIsAlive(Attackerdent) == 1)
					{
						local Probability = RandomInt(1, 100);
						if(Probability <= GiveOrSpawnProbability)
						{
							Utils.SpawnWeapon(GetSpawnItem(), 1, 500, Get_EyePosition(dierent), GetIdAngles(dierent));
							GetAttackerModel = User_Model(Attackerdent);
							Utils.SayToAll("[-]"+"(特感)"+ZombieType+":"+Player(dierent).GetName()+"死亡，掉落"+GetSpawnItemName);
						}
					}
				}
			}
			if(dier != Attacker && dier > 0 && Attacker > 0)
			{
				if(GetAttackerTeam == 2 && !IsPlayerABot(Attackerdent))
				{
					if(GetDierentTeam == 2 && !IsPlayerABot(dierent) && UpgradeOff == 1)
					{
						ReduceExpKV(Attackerdent, 1);
					}
				}
				if(ClientIsAlive(Attackerdent) == 1)
				{
					local red = RandomInt(0, 255);
					local green = RandomInt(0, 255);
					local blue = RandomInt(0, 255);
					CreateSpawn(dierent);
					L4D2_SetEntGlow(dierent);
					if(DebugDrawLine_AddParticleMap == 1)
					{
						if(IsOfficialMaps() == 1)
						{
							DebugDrawLine(Entity(Attackerdent).GetEyePosition(), Entity(dierent).GetEyePosition(), red, green, blue, false, ShowDebugDrawLine_Time);
						}
					}
					if(DebugDrawLine_AddParticleMap == 2)
					{
						DebugDrawLine(Entity(Attackerdent).GetEyePosition(), Entity(dierent).GetEyePosition(), red, green, blue, false, ShowDebugDrawLine_Time);
					}
					if(HeadShot)
					{
						if(GetAttackerTeam == 2)
						{
							HeadShotNum[Attackerdent.GetEntityIndex()]++;
							IncreaseOrDecrease_StatKV(Attackerdent, StatIdx.HeadshotInfection);
							FileIO.SaveTable( "save_playerstats", ::SavedStats );
							GetAttackerWeapon = Attacker_Weapon(Attackerdent);
							GetAttackerModel = User_Model(Attackerdent);
							if(!IsPlayerABot(Attackerdent) && ClientIsAlive(Attackerdent) == 1)
							{
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) > 0)
								{
									Entity(Attackerdent).SetNetProp( "m_iFOV", 10);
									Entity(Attackerdent).SetNetProp( "m_bDrawViewmodel", 1);
									Timers.AddTimer(0.2, false, Timer_Zoom1, Attackerdent);
									if(UpgradeOff == 1)
									{
										HeadShotInfo = "+"+HeadShotNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.HeadshotInfection).tofloat()+" 爆头"+ZombieType+".获得"+GetExp+"Exp("+ExperiencePercent[Entity(Attackerdent).GetBaseIndex()].tointeger()+"%%)."+GetUpgradeKV(Attackerdent, UpgradeIdx.Lv)+"级.丧尸"+Kill_InfectedNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillZombie);
									}
									if(UpgradeOff == 0)
									{
										HeadShotInfo = "+"+HeadShotNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.HeadshotInfection).tofloat()+" 爆头"+ZombieType+"."+Dist.tointeger()+"m.丧尸"+Kill_InfectedNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillZombie);
									}
									if(KillOrHeadShot_HUD == 1)
									{
										Player(Attackerdent).ShowHint(HeadShotInfo, 10, "Stat_Most_Headshots", "", HUD_RandomColor());
									}
									if(KillOrHeadShot_HUD == 2)
									{
										_HeadShot[Attackerdent.GetEntityIndex()]++;
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 1)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_1_stars", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 2)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_2_stars", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 3)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_3_stars", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 4)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_4_stars", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 5)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_5_stars", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 6)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_1_stars", "", HUD_RandomColor());
											_HeadShot[Attackerdent.GetEntityIndex()] = 0;
										}
									}
									if(KillOrHeadShot_HUD == 3)
									{
										_HeadShot[Attackerdent.GetEntityIndex()]++;
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 1)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 2)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_2", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 3)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_4", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 4)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_3", "", HUD_RandomColor());
										}
										if(_HeadShot[Attackerdent.GetEntityIndex()] == 5)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
											_HeadShot[Attackerdent.GetEntityIndex()] = 0;
										}
									}
									if(KillOrHeadShot_HUD == 4)
									{
										_HeadShot[Attackerdent.GetEntityIndex()]++;
										if(Random_HUD == 1)
										{
											Player(Attackerdent).ShowHint(HeadShotInfo, 8, "Stat_Most_Headshots", "", HUD_RandomColor());
										}
										if(Random_HUD == 2)
										{
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 1)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_1_stars", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 2)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_2_stars", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 3)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_3_stars", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 4)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_4_stars", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 5)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_5_stars", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 6)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "rating_1_stars", "", HUD_RandomColor());
												_HeadShot[Attackerdent.GetEntityIndex()] = 0;
											}
										}
										if(Random_HUD == 3)
										{
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 1)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 2)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_2", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 3)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_4", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 4)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_3", "", HUD_RandomColor());
											}
											if(_HeadShot[Attackerdent.GetEntityIndex()] == 5)
											{
												Player(Attackerdent).ShowHint(HeadShotInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
												_HeadShot[Attackerdent.GetEntityIndex()] = 0;
											}
										}
									}
								}
							}
							if(HeadShotSound == 1 && !IsPlayerABot(Attackerdent) && ClientIsAlive(Attackerdent) == 1)
							{
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) == 0)
								{
									if(GetAttackerModel == "教练")
									{
										Player(Attackerdent).PlaySound("Coach_NiceShot01");
									}
									if(GetAttackerModel == "技工")
									{
										Player(Attackerdent).PlaySound("Mechanic_NiceShot02");
									}
									if(GetAttackerModel == "赌徒")
									{
										Player(Attackerdent).PlaySound("Gambler_NiceShot01");
									}
									if(GetAttackerModel == "女记者")
									{
										Player(Attackerdent).PlaySound("Producer_NiceShot03");
									}
									if(GetAttackerModel == "女学生")
									{
										Player(Attackerdent).PlaySound("Player.TeenGirl_NiceShot15");
									}
									if(GetAttackerModel == "摩托党")
									{
										Player(Attackerdent).PlaySound("npc.Biker_NiceShot07");
									}
									if(GetAttackerModel == "职员")
									{
										Player(Attackerdent).PlaySound("npc.Manager_NiceShot08");
									}
									if(GetAttackerModel == "老兵")
									{
										Player(Attackerdent).PlaySound("Player.NamVet_NiceShot04");
									}
								}
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) > 0)
								{
									if(_GetGender(Attackerdent) == "man")
									{
										local Random = RandomInt(1, 2);
										if(Random == 1)
										{
											Player(Attackerdent).PlaySound("Player.TeenGirl_NiceShot15");
										}
										if(Random == 2)
										{
											Player(Attackerdent).PlaySound("Producer_NiceShot03");
										}
									}
								}
							}
							if(ShowInfo_Type == 1)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+GetAttackerModel+":"+Player(Attackerdent).GetName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总爆"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
							}
							if(ShowInfo_Type == 2)
							{
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+GetAttackerModel+":"+Attackerdent.GetPlayerName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共爆头"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
							if(ShowInfo_Type == 3)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+GetAttackerModel+":"+Player(Attackerdent).GetName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总爆"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+GetAttackerModel+":"+Attackerdent.GetPlayerName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共爆头"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
						}
						else
						{
							if(ShowInfo_Type == 1)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+dierent.GetPlayerName()+"，总爆"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
							}
							if(ShowInfo_Type == 2)
							{
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共爆头"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
							if(ShowInfo_Type == 3)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+dierent.GetPlayerName()+"，总爆"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处爆头"+dierent_BotOrPlayer+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共爆头"+HeadShotNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
						}
					}
					else 
					{
						KillNum[Attackerdent.GetEntityIndex()]++;
						IncreaseOrDecrease_StatKV(Attackerdent, StatIdx.KillInfection);
						FileIO.SaveTable( "save_playerstats", ::SavedStats );
						if(GetAttackerTeam == 2)
						{
							GetAttackerWeapon = Attacker_Weapon(Attackerdent);
							GetAttackerModel = User_Model(Attackerdent);
							if(!IsPlayerABot(Attackerdent) && ClientIsAlive(Attackerdent) == 1)
							{
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) > 0)
								{
									if(UpgradeOff == 1)
									{
										KillInfo = "+"+KillNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillInfection).tofloat()+" 击杀"+ZombieType+".获得"+GetExp+"Exp("+ExperiencePercent[Entity(Attackerdent).GetBaseIndex()].tointeger()+"%%)."+GetUpgradeKV(Attackerdent, UpgradeIdx.Lv)+"级.丧尸"+Kill_InfectedNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillZombie);
									}
									if(UpgradeOff == 0)
									{
										KillInfo = "+"+KillNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillInfection).tofloat()+" 击杀"+ZombieType+"."+Dist.tointeger()+"m.丧尸"+Kill_InfectedNum[Attackerdent.GetEntityIndex()]+"/"+GetStatKV(Attackerdent, StatIdx.KillZombie);
									}
									if(KillOrHeadShot_HUD == 1)
									{
										Player(Attackerdent).ShowHint(KillInfo, 15, "Stat_Most_Special_Kills", "", HUD_RandomColor());
									}
									if(KillOrHeadShot_HUD == 2)
									{
										KillCount[Attackerdent.GetEntityIndex()]++;
										if(KillCount[Attackerdent.GetEntityIndex()] == 1)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_1_stars", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 2)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_2_stars", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 3)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_3_stars", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 4)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_4_stars", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 5)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_5_stars", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 6)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "rating_1_stars", "", HUD_RandomColor());
											KillCount[Attackerdent.GetEntityIndex()] = 0;
										}
									}
									if(KillOrHeadShot_HUD == 3)
									{
										KillCount[Attackerdent.GetEntityIndex()]++;
										if(KillCount[Attackerdent.GetEntityIndex()] == 1)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 2)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_2", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 3)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_4", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 4)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_3", "", HUD_RandomColor());
										}
										if(KillCount[Attackerdent.GetEntityIndex()] == 5)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
											KillCount[Attackerdent.GetEntityIndex()] = 0;
										}
									}
									if(KillOrHeadShot_HUD == 4)
									{
										KillCount[Attackerdent.GetEntityIndex()]++;
										if(Random_HUD == 1)
										{
											Player(Attackerdent).ShowHint(KillInfo, 8, "Stat_Most_Special_Kills", "", HUD_RandomColor());
										}
										if(Random_HUD == 2)
										{
											if(KillCount[Attackerdent.GetEntityIndex()] == 1)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_1_stars", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 2)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_2_stars", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 3)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_3_stars", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 4)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_4_stars", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 5)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_5_stars", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 6)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "rating_1_stars", "", HUD_RandomColor());
												KillCount[Attackerdent.GetEntityIndex()] = 0;
											}
										}
										if(Random_HUD == 3)
										{
											if(KillCount[Attackerdent.GetEntityIndex()] == 1)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 2)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_2", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 3)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_4", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 4)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_3", "", HUD_RandomColor());
											}
											if(KillCount[Attackerdent.GetEntityIndex()] == 5)
											{
												Player(Attackerdent).ShowHint(KillInfo, 8, "icon_360_controller_1", "", HUD_RandomColor());
												KillCount[Attackerdent.GetEntityIndex()] = 0;
											}
										}
									}
								}
							}
							if(KillSound == 1 && !IsPlayerABot(Attackerdent) && ClientIsAlive(Attackerdent) == 1)
							{
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) == 0)
								{
									if(GetAttackerModel == "教练")
									{
										Player(Attackerdent).PlaySound("Coach_NiceShot03");
									}
									if(GetAttackerModel == "技工")
									{
										Player(Attackerdent).PlaySound("Mechanic_NiceShot01");
									}
									if(GetAttackerModel == "赌徒")
									{
										Player(Attackerdent).PlaySound("Gambler_NiceShot06");
									}
									if(GetAttackerModel == "女记者")
									{
										Player(Attackerdent).PlaySound("Producer_NiceShot05");
									}
									if(GetAttackerModel == "女学生")
									{
										Player(Attackerdent).PlaySound("Player.TeenGirl_NiceShot14");
									}
									if(GetAttackerModel == "摩托党")
									{
										Player(Attackerdent).PlaySound("npc.Biker_NiceShot10");
									}
									if(GetAttackerModel == "职员")
									{
										Player(Attackerdent).PlaySound("npc.Manager_NiceShot05");
									}
									if(GetAttackerModel == "老兵")
									{
										Player(Attackerdent).PlaySound("Player.NamVet_NiceShot08");
									}
								}
								if(GetStatKV(Attackerdent, StatIdx.HudInfo) > 0)
								{
									if(_GetGender(Attackerdent) == "man")
									{
										local Random = RandomInt(1, 2);
										if(Random == 1)
										{
											Player(Attackerdent).PlaySound("Player.TeenGirl_NiceShot14");
										}
										if(Random == 2)
										{
											Player(Attackerdent).PlaySound("Producer_NiceShot05");
										}
									}
								}
							}
							if(ShowInfo_Type == 1)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+GetAttackerModel+":"+Player(Attackerdent).GetName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
							}
							if(ShowInfo_Type == 2)
							{
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+GetAttackerModel+":"+Attackerdent.GetPlayerName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
							if(ShowInfo_Type == 3)
							{
								Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+GetAttackerModel+":"+Player(Attackerdent).GetName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip = HUD.Item("{info01}\n{info02}");
								hudtip.SetValue("info01", attackerdent_BotOrPlayer+GetAttackerModel+":"+Attackerdent.GetPlayerName()+GetAttackerWeapon+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
								hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
								hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
								hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
								hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
								hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
								Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
							}
						}
						if(GetAttackerTeam == 3)
						{
							if(GetDierentTeam == 2)
							{
								GetDierentModel = User_Model(dierent);
								if(ShowInfo_Type == 1)
								{
									Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
								}
								if(ShowInfo_Type == 2)
								{
									hudtip = HUD.Item("{info01}\n{info02}");
									hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"+Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName());
									hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
									hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
									hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
									hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
									Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
								}
								if(ShowInfo_Type == 3)
								{
									Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip = HUD.Item("{info01}\n{info02}");
									hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"+Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName());
									hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
									hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
									hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
									hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
									Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
								}
							}
							else
							{
								if(ShowInfo_Type == 1)
								{
									Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
								}
								if(ShowInfo_Type == 2)
								{
									hudtip = HUD.Item("{info01}\n{info02}");
									hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"+Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
									hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
									hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
									hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
									hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
									Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
								}
								if(ShowInfo_Type == 3)
								{
									Utils.SayToAll("[-]"+attackerdent_BotOrPlayer+Zombie_Type+":"+Player(Attackerdent).GetName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"，总杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip = HUD.Item("{info01}\n{info02}");
									hudtip.SetValue("info01", attackerdent_BotOrPlayer+Zombie_Type+":"+Attackerdent.GetPlayerName()+"在"+Dist.tointeger()+"m处杀死"+dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName());
									hudtip.SetValue("info02", "Ta总共击杀"+KillNum[Attackerdent.GetEntityIndex()]+"次");
									hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
									hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
									hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
									hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
									Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
								}
							}
						}
					}
				}	
			}
			else
			{
				DeathNum[dierent.GetEntityIndex()]++;
				if(GetDierentTeam == 2 && !IsPlayerABot(dierent) && UpgradeOff == 1)
				{
					ReduceExpKV(dierent, 3);
				}
				if(ShowInfo_Type == 1)
				{
					if(GetDierentTeam == 2)
					{
						GetDierentModel = User_Model(dierent);
						Utils.SayToAll("[-]"+dierent_BotOrPlayer+GetDierentModel+":"+Player(dierent).GetName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
					else
					{
						Utils.SayToAll("[-]"+dierent_BotOrPlayer+ZombieType+":"+Player(dierent).GetName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
				}
				if(ShowInfo_Type == 2)
				{
					if(GetDierentTeam == 2)
					{
						GetDierentModel = User_Model(dierent);
						hudtip = HUD.Item(dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
					else
					{
						hudtip = HUD.Item(dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
				if(ShowInfo_Type == 3)
				{
					if(GetDierentTeam == 2)
					{
						GetDierentModel = User_Model(dierent);
						Utils.SayToAll("[-]"+dierent_BotOrPlayer+GetDierentModel+":"+Player(dierent).GetName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
						hudtip = HUD.Item(dierent_BotOrPlayer+GetDierentModel+":"+dierent.GetPlayerName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
					else
					{
						Utils.SayToAll("[-]"+dierent_BotOrPlayer+ZombieType+":"+Player(dierent).GetName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
						hudtip = HUD.Item(dierent_BotOrPlayer+ZombieType+":"+dierent.GetPlayerName()+"死亡"+DeathNum[dierent.GetEntityIndex()]+"次");
					}
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
			}
		}
	}
}
::HUD_RandomColor<-function()
{
	local Color = {};
	local C = RandomInt(1, 5);
	
	if(C == 1)	Color = "255 128 0";
	if(C == 2)	Color = "255 255 128";
	if(C == 3)	Color = "255 255 255";
	if(C == 4)	Color = "255 255 0";
	if(C == 5)	Color = "0 255 0";
	
	return Color;
}
::IsOfficialMaps<-function()
{
	local Num = 0;
	if( SessionState.MapName.tolower() == "c1m1_hotel" || 
		SessionState.MapName.tolower() == "c1m2_streets" || 
		SessionState.MapName.tolower() == "c1m3_mall" || 
		SessionState.MapName.tolower() == "c1m4_atrium" || 
		SessionState.MapName.tolower() == "c2m1_highway" || 
		SessionState.MapName.tolower() == "c2m2_fairgrounds" || 
		SessionState.MapName.tolower() == "c2m3_coaster" || 
		SessionState.MapName.tolower() == "c2m4_barns" || 
		SessionState.MapName.tolower() == "c2m5_concert" || 
		SessionState.MapName.tolower() == "c3m1_plankcountry" || 
		SessionState.MapName.tolower() == "c3m2_swamp" || 
		SessionState.MapName.tolower() == "c3m3_shantytown" || 
		SessionState.MapName.tolower() == "c3m4_plantation"  || 
		SessionState.MapName.tolower() == "c4m1_milltown_a" || 
		SessionState.MapName.tolower() == "c4m2_sugarmill_a" || 
		SessionState.MapName.tolower() == "c4m3_sugarmill_b" || 
		SessionState.MapName.tolower() == "c4m4_milltown_b" || 
		SessionState.MapName.tolower() == "c4m5_milltown_escape" || 
		SessionState.MapName.tolower() == "c5m1_waterfront" || 
		SessionState.MapName.tolower() == "c5m2_park" || 
		SessionState.MapName.tolower() == "c5m3_cemetery" || 
		SessionState.MapName.tolower() == "c5m4_quarter" || 
		SessionState.MapName.tolower() == "c5m5_bridge" || 
		SessionState.MapName.tolower() == "c6m1_riverbank" || 
		SessionState.MapName.tolower() == "c6m2_bedlam" || 
		SessionState.MapName.tolower() == "c6m3_port" || 
		SessionState.MapName.tolower() == "c7m1_docks" || 
		SessionState.MapName.tolower() == "c7m2_barge" || 
		SessionState.MapName.tolower() == "c7m3_port" || 
		SessionState.MapName.tolower() == "c8m1_apartment" || 
		SessionState.MapName.tolower() == "c8m2_subway" || 
		SessionState.MapName.tolower() == "c8m3_sewers" || 
		SessionState.MapName.tolower() == "c8m4_interior" || 
		SessionState.MapName.tolower() == "c8m5_rooftop" || 
		SessionState.MapName.tolower() == "c9m1_alleys" || 
		SessionState.MapName.tolower() == "c9m2_lots" || 
		SessionState.MapName.tolower() == "c10m1_caves" || 
		SessionState.MapName.tolower() == "c10m2_drainage" || 
		SessionState.MapName.tolower() == "c10m3_ranchhouse" || 
		SessionState.MapName.tolower() == "c10m4_mainstreet" || 
		SessionState.MapName.tolower() == "c10m5_houseboat" || 
		SessionState.MapName.tolower() == "c11m1_greenhouse" || 
		SessionState.MapName.tolower() == "c11m2_offices" || 
		SessionState.MapName.tolower() == "c11m3_garage" || 
		SessionState.MapName.tolower() == "c11m4_terminal" || 
		SessionState.MapName.tolower() == "c11m5_runway" || 
		SessionState.MapName.tolower() == "c12m1_hilltop" || 
		SessionState.MapName.tolower() == "c12m2_traintunnel" || 
		SessionState.MapName.tolower() == "c12m3_bridge" || 
		SessionState.MapName.tolower() == "c12m4_barn" || 
		SessionState.MapName.tolower() == "c12m5_cornfield" || 
		SessionState.MapName.tolower() == "c13m1_alpinecreek" || 
		SessionState.MapName.tolower() == "c13m2_southpinestream" || 
		SessionState.MapName.tolower() == "c13m3_memorialbridge" || 
		SessionState.MapName.tolower() == "c13m4_cutthroatcreek" )
	{
		Num = 1;
	}
	else Num = 0
	
	return Num;
}
function OnGameEvent_witch_harasser_set(params)
{
	local UserId = null;
	local UserIddent = null;
	local hudtip = null;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdModel = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0)
		{
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			GetUserIdModel = User_Model(UserIddent);
			hudtip = HUD.Item(UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+" 惊扰 Witch");
			hudtip.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			hudtip.ChangeHUDNative(10, 40, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			hudtip.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG|HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
		}
	}
}

::KillTank_Models <- function(tank)
{
	local GetTank = tank.GetScriptScope();
	if ("tank" in GetTank)
		GetTank["tank"].Kill();
}
::KillTank_Info <- function(hud)
{
	local GetHud = hud.GetScriptScope();
	if ("hint" in GetHud)
		GetHud["hint"].Kill();
}
function OnGameEvent_tank_killed(params)
{
	local UserId = null;
	local UserIddent = null;
	local AttackerId = null;
	local AttackerIddent = null;
	local hudtip = null;
	local GetAttacker = null;
	local GetKillTank_Info = [];
	if(params.rawin("attacker") && params.rawin("userid"))
	{
		AttackerId = params["attacker"];
		AttackerIddent = GetPlayerFromUserID(AttackerId);
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		local Count = 0;
		SurvivorsIndex <- {};
		Show_TankRank = 1;

		foreach(surmodel in ::SurvivorsModel)
		{
			playerindex <- null;
			while ((playerindex = Entities.FindByModel(playerindex, surmodel)) != null)
			{			
				if(playerindex.IsValid() && playerindex.IsPlayer())
				{
					SurvivorsIndex[Count] <- playerindex.GetEntityIndex();
					Count++;
				}
			}
			for(local i = 0; i < SurvivorsIndex.len(); i++)
			{
				if(SurvivorsIndex[i] != null && DmgTankHealth[PlayerInstanceFromIndex(SurvivorsIndex[i]).GetEntityIndex()] > 0)
				{
					hudtip = HUD.Item("{info01}\n{info02}\n{info03}");
					hudtip.SetValue("info01", Rank01);
					hudtip.SetValue("info02", Rank02);
					hudtip.SetValue("info03", Rank03);
					hudtip.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(200, 250, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer(15.0, false, Tank_CloseHud, hudtip); //添加计时器关闭HUD
				}
			}
		}
		if(!IsPlayerABot(AttackerIddent))
		{
			if(UserId != AttackerId && AttackerId > 0)
			{
				if(Get_UserIdTeam(AttackerIddent) == 2)
				{
					if(UpgradeOff == 1)
					{
						GetKillTank_Info = "坦克杀手："+User_Model(AttackerIddent)+":"+GetUpgradeKV(AttackerIddent, UpgradeIdx.Lv)+"级."+Player(AttackerIddent).GetName();
					}
					else
					{
						GetKillTank_Info = "坦克杀手："+User_Model(AttackerIddent)+":"+Player(AttackerIddent).GetName();
					}
				}
				if(Get_UserIdTeam(AttackerIddent) == 3)
				{
					GetKillTank_Info = "坦克杀手："+Get_ZombieName(AttackerIddent)+":"+Player(AttackerIddent).GetName();
				}
			}
			else
			{
				GetKillTank_Info = "坦克自杀";
			}
			
			GetAttacker = HUD.Item(GetKillTank_Info);
			GetAttacker.AttachTo(HUD_LEFT_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			GetAttacker.ChangeHUDNative(180, 190, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			GetAttacker.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			GetAttacker.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer(15.0, false, Tank_CloseHud, GetAttacker); //添加计时器关闭HUD
		}
		else
		{
			if(UserId != AttackerId && AttackerId > 0)
			{
				GetKillTank_Info = "坦克杀手：(电脑)"+Player(AttackerIddent).GetName();
			}
			else
			{
				GetKillTank_Info = "坦克死亡";
			}
		}
		
		local ent = Utils.SpawnInventoryItem( GetKillTank_Info, "models/infected/hulk.mdl", Get_Position(UserIddent) );
		local hint = Utils.SetEntityHint(ent, GetKillTank_Info, "Stat_Most_Tank_Dmg", 500);
		hint.GetScriptScope()["hint"] <- hint;
		ent.GetScriptScope()["tank"] <- ent;
		Timers.AddTimer( 10.0, false, KillTank_Info, hint );
		Timers.AddTimer( 0.1, false, KillTank_Models, ent );
	}
}
::Tank_CloseHud <- function(hud)
{
	hud.Detach();
	Show_TankRank = 0;
}
::Rank01 <- function ()
{
	return DmgTank_PlayerRank[0];
}

::Rank02 <- function ()
{
	return DmgTank_PlayerRank[1];
}

::Rank03 <- function ()
{
	return DmgTank_PlayerRank[2];
}
::DmgTank_RankingList <- function(Survivor)
{
    for (local S = 0; S < Survivor.len() - 1; S++)
    {
		for (local C = 0; C < Survivor.len() - 1 - S; C++)
		{
			if (DmgTankHealth[Survivor[C]] < DmgTankHealth[Survivor[C+1]])
			{
				local P = Survivor[C + 1];
				Survivor[C + 1] = Survivor[C];
				Survivor[C] = P;
			}
		}
	}
}
::KillNum_RankingList <- function(Survivor)
{
    for (local S = 0; S < Survivor.len() - 1; S++)
    {
		for (local C = 0; C < Survivor.len() - 1 - S; C++)
		{
			if (ClientKillNum[Survivor[C]] < ClientKillNum[Survivor[C+1]])
			{
				local P = Survivor[C + 1];
				Survivor[C + 1] = Survivor[C];
				Survivor[C] = P;
			}
		}
	}
}
::KillWitch_Models <- function(witch)
{
	local GetTank = witch.GetScriptScope();
	if ("witch" in GetTank)
		GetTank["witch"].Kill();
}
::KillWitch_Info <- function(hud)
{
	local GetHud = hud.GetScriptScope();
	if ("hint" in GetHud)
		GetHud["hint"].Kill();
}
::RandomSurvivor <- function()
{
	local t = {};
	local ent = null;
	local i = -1;
	while (ent = Entities.FindByClassname(ent, "player"))
	{
		if (ent.IsValid())
		{
			local libObj = ::VSLib.Player(ent);
			if (libObj.GetTeam() == SURVIVORS && libObj.IsAlive() && !Entity(ent).IsBot())
				t[++i] <- libObj;
		}
	}
	
	return Utils.GetRandValueFromArray(t);
}
::RandomAllSurvivor <- function()
{
	local t = {};
	local ent = null;
	local i = -1;
	while (ent = Entities.FindByClassname(ent, "player"))
	{
		if (ent.IsValid())
		{
			local libObj = ::VSLib.Player(ent);
			if (libObj.GetTeam() == SURVIVORS && libObj.IsAlive())
				t[++i] <- libObj;
		}
	}
	
	return Utils.GetRandValueFromArray(t);
}
::Timer_ResinTide <- function(params)
{
	TriggerEvent_Zombie++;
	if(TriggerEvent_Zombie <= TriggerEvent_ZombieMax)
	{
		Timers.AddTimer( 5.0, false, Timer_ResinTide);
		local GetCommon = [];
		local GetCommonInfo = [];
		local ResinTide = null;
		local Random = RandomInt(1, 9);
		local Num = TriggerEvent_ZombieMax - TriggerEvent_Zombie;
		if(Random == 1)
		{
			GetCommon = "common_male_ceda"; //防化丧尸
			GetCommonInfo = "丧尸快攻：防化丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 2)
		{
			GetCommon = "common_male_roadcrew"; //建筑工人
			GetCommonInfo = "丧尸快攻：建筑工人出现，剩余-"+Num+"次";
		}
		if(Random == 3)
		{
			GetCommon = "common_male_clown"; //小丑
			GetCommonInfo = "丧尸快攻：小丑出现，剩余-"+Num+"次";
		}
		if(Random == 4)
		{
			GetCommon = "common_male_tshirt_cargos"; //T恤男
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 5)
		{
			GetCommon = "common_male_tankTop_jeans"; //背心牛仔裤男
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 6)
		{
			GetCommon = "common_male_dressShirt_jeans"; //衬衫牛仔裤男
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 7)
		{
			GetCommon = "common_female_tankTop_jeans"; //背心牛仔裤女
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 8)
		{
			GetCommon = "common_female_tshirt_skirt"; //T恤裙子女
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		if(Random == 9)
		{
			GetCommon = "common_male_tankTop_overalls"; //背心工装裤男
			GetCommonInfo = "丧尸快攻：普通丧尸出现，剩余-"+Num+"次";
		}
		
		ResinTide = HUD.Item(GetCommonInfo);
		ResinTide.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		ResinTide.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		ResinTide.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		ResinTide.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer( 5.0, false, Close_TriggerEvent, ResinTide ); //添加计时器关闭HUD
		
		for ( local i = 0; i < CommonSpawnMax; i++ )
		{
			local pos = Utils.GetNearbyLocationRadius( RandomAllSurvivor(), CommonSpawnLocation_Min, CommonSpawnLocation_Max );
			Utils.SpawnCommentaryZombie(GetCommon, pos);
		}
	}
	else
	{
		foreach (p in Players.All())
		{
			Mychainsaw[Entity(p).GetBaseIndex()] = 0;
		}
	}
}
function OnGameEvent_witch_killed(params)
{
	local UserId = null;
	local UserIddent = null;
	local OneShot = false;
	local hudtip = null;
	local hudwitch = null;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdWeapon = [];
	local GetUserIdModel = [];
	local _OneShot = [];
    if(params.rawin("userid") && params.rawin("oneshot"))
	{
		UserId = params["userid"];
		OneShot = params["oneshot"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0)
		{
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			if(ClientIsAlive(UserIddent) == 1)
			{
				if(Get_UserIdTeam(UserIddent) == 2 && !IsPlayerABot(UserIddent) && UpgradeOff == 1)
				{
					AddWitchExpKV(UserIddent);
				}
				if(OneShot)
				{
					if(Get_UserIdTeam(UserIddent) == 2 && !IsPlayerABot(UserIddent))
					{
						if(UpgradeOff == 1)
						{
							_OneShot = "秒杀Witch.获得"+KillWitch_GetExp+"Exp("+ExperiencePercent[Entity(UserIddent).GetBaseIndex()].tointeger()+"%%)."+GetUpgradeKV(UserIddent, UpgradeIdx.Lv)+"级";
						}
						if(UpgradeOff == 0)
						{
							_OneShot = "秒杀Witch";
						}
						Player(UserIddent).ShowHint(_OneShot, 10, "Stat_Most_Headshots", "", HUD_RandomColor());
						GetUserIdWeapon = Attacker_Weapon(UserIddent);
						GetUserIdModel = User_Model(UserIddent);
						hudtip = HUD.Item(UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+GetUserIdWeapon+" 秒杀 Witch");
						hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
					}
				}
				else
				{
					if(Get_UserIdTeam(UserIddent) == 2  && !IsPlayerABot(UserIddent))
					{
						GetUserIdWeapon = Attacker_Weapon(UserIddent);
						GetUserIdModel = User_Model(UserIddent);
						hudtip = HUD.Item(UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+GetUserIdWeapon+" 杀死 Witch");
						hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
						if(UpgradeOff == 1)
						{
							_OneShot = "杀死Witch.获得"+KillWitch_GetExp+"Exp("+ExperiencePercent[Entity(UserIddent).GetBaseIndex()].tointeger()+"%%)."+GetUpgradeKV(UserIddent, UpgradeIdx.Lv)+"级";
						}
						if(UpgradeOff == 0)
						{
							_OneShot = "杀死Witch";
						}
						Player(UserIddent).ShowHint(_OneShot, 15, "Stat_Most_Witch_Dmg", "", HUD_RandomColor());
					}
					else
					{
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"杀死 Witch");
					}
				}
			}
			if(WitchDeath_TriggerEventType == 1)
			{
				local Probability = RandomInt(1, 100);
				if(Probability <= TriggerEvent_Panic)
				{
					//Utils.TriggerStage(STAGE_PANIC);
					local RandomPlayer = RandomSurvivor();
					if(RandomPlayer != -1)
					{
						Player(RandomPlayer).Give("chainsaw");
						Mychainsaw[Entity(RandomPlayer).GetBaseIndex()] = 1;
						Player(RandomPlayer).ShowHint("你获得特殊电锯", 10, "Stat_Most_Melee_Kills", "", HUD_RandomColor());
					}
					Timers.AddTimer( 5.0, false, Timer_ResinTide);
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"触发丧尸快攻");
					hudwitch = HUD.Item("{info01}\n{info02}");
					hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
					hudwitch.SetValue("info02", ">>>触发丧尸快攻<<<");
					hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
					RoundStart_ShowInfo = 1;
					if(WitchSlowTime_Off == 1)
					{
						Utils.SlowTime(0.5);
					}
				}
			}
			if(WitchDeath_TriggerEventType == 2)
			{
				local Probability = RandomInt(1, 100);
				if(Probability <= TriggerEvent_Tank)
				{
					Utils.TriggerStage(STAGE_TANK);
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"引来一坦克");
					hudwitch = HUD.Item("{info01}\n{info02}");
					hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
					hudwitch.SetValue("info02", ">>>引来一坦克<<<");
					hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
					RoundStart_ShowInfo = 1;
					if(WitchSlowTime_Off == 1)
					{
						Utils.SlowTime(0.5);
					}
				}
			}
			if(WitchDeath_TriggerEventType == 3)
			{
				local Probability = RandomInt(1, 100);
				if(Probability <= TriggerEvent_Escape)
				{
					Utils.TriggerStage(STAGE_ESCAPE);
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"触发无限尸潮和坦克");
					hudwitch = HUD.Item("{info01}\n{info02}");
					hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
					hudwitch.SetValue("info02", ">>触发无限尸潮和坦克<<");
					hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
					RoundStart_ShowInfo = 1;
					if(WitchSlowTime_Off == 1)
					{
						Utils.SlowTime(0.5);
					}
				}
			}
			if(WitchDeath_TriggerEventType == 4)
			{
				local P = RandomInt(1, 3);
				if(P == 1)
				{
					local Probability = RandomInt(1, 100);
					if(Probability <= TriggerEvent_Panic)
					{
						//Utils.TriggerStage(STAGE_PANIC);
						local RandomPlayer = RandomSurvivor();
						if(RandomPlayer > 0)
						{
							Player(RandomPlayer).Give("chainsaw");
							Mychainsaw[Entity(RandomPlayer).GetBaseIndex()] = 1;
							Player(RandomPlayer).ShowHint("你获得特殊电锯", 10, "Stat_Most_Melee_Kills", "", HUD_RandomColor());
						}
						Timers.AddTimer( 5.0, false, Timer_ResinTide);
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"触发丧尸快攻");
						hudwitch = HUD.Item("{info01}\n{info02}");
						hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
						hudwitch.SetValue("info02", ">>>触发丧尸快攻<<<");
						hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
						RoundStart_ShowInfo = 1;
						if(WitchSlowTime_Off == 1)
						{
							Utils.SlowTime(0.5);
						}
					}
				}
				if(P == 2)
				{
					local Probability = RandomInt(1, 100);
					if(Probability <= TriggerEvent_Tank)
					{
						Utils.TriggerStage(STAGE_TANK);
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"引来一坦克");
						hudwitch = HUD.Item("{info01}\n{info02}");
						hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
						hudwitch.SetValue("info02", ">>>引来一坦克<<<");
						hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
						RoundStart_ShowInfo = 1;
						if(WitchSlowTime_Off == 1)
						{
							Utils.SlowTime(0.5);
						}
					}
				}
				if(P == 3)
				{
					local Probability = RandomInt(1, 100);
					if(Probability <= TriggerEvent_Escape)
					{
						Utils.TriggerStage(STAGE_ESCAPE);
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"触发无限尸潮和坦克");
						hudwitch = HUD.Item("{info01}\n{info02}");
						hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
						hudwitch.SetValue("info02", ">>触发无限尸潮和坦克<<");
						hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
						hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
						hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
						hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
						Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
						RoundStart_ShowInfo = 1;
						if(WitchSlowTime_Off == 1)
						{
							Utils.SlowTime(0.5);
						}
					}
				}
			}
			if(WitchDeath_TriggerEventType == 5)
			{
				local Probability = RandomInt(1, 100);
				if(Probability <= TriggerEvent_Results)
				{
					Utils.TriggerStage(STAGE_RESULTS);
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+Player(UserIddent).GetName()+"触发团灭事件");
					hudwitch = HUD.Item("{info01}\n{info02}");
					hudwitch.SetValue("info01", UserIddent_BotOrPlayer+UserIddent.GetPlayerName());
					hudwitch.SetValue("info02", ">>触发团灭事件<<");
					hudwitch.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudwitch.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudwitch.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudwitch.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, Close_TriggerEvent, hudwitch ); //添加计时器关闭HUD
					RoundStart_ShowInfo = 1;
					if(WitchSlowTime_Off == 1)
					{
						Utils.SlowTime(0.5);
					}
				}
			}
		}
	}
}
::Close_TriggerEvent <- function(hud)
{
	hud.Detach();
	RoundStart_ShowInfo = 0;
}
function OnGameEvent_door_open(params)
{
	local UserId = null;
	local UserIddent = null;
	local Checkpoint = false;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdModel = [];
    if(params.rawin("userid") && params.rawin("checkpoint"))
	{
		UserId = params["userid"];
		Checkpoint = params["checkpoint"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(Checkpoint)
		{
			if(UserId > 0)
			{
				GetUserIdModel = User_Model(UserIddent);
				if(!IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(玩家)";
				}
				if(IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(电脑)";
				}
				DoorOpenNum[UserIddent.GetEntityIndex()]++;
				Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":"+Player(UserIddent).GetName()+"打开安全门"+DoorOpenNum[UserIddent.GetEntityIndex()]+"次");
				if(SafeDoor_Off == 1)
				{
					if(DoorOpenNum[UserIddent.GetEntityIndex()] >= 5 && DoorOpenNum[UserIddent.GetEntityIndex()] < SafeDoor_Num)
					{
						local Num = SafeDoor_Num-DoorCloseNum[UserIddent.GetEntityIndex()]-1;
						local ClientInfo = "警告"+Num+"次，自杀";
						Player(UserIddent).ShowHint(ClientInfo, 8, "icon_door", "", "255 0 0");
						Player(UserIddent).PlaySound("Buttons.snd11");
					}
					if(DoorOpenNum[UserIddent.GetEntityIndex()] >= SafeDoor_Num)
					{
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":强制"+Player(UserIddent).GetName()+"自杀，原因：频繁使用安全门");
						Player(UserIddent).Kill();
						DoorOpenNum[UserIddent.GetEntityIndex()] = 0;
					}
				}
			}
		}
	}
}
function OnGameEvent_door_close(params)
{
	local UserId = null;
	local UserIddent = null;
	local Checkpoint = false;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdModel = [];
	if(params.rawin("userid") && params.rawin("checkpoint"))
	{
		UserId = params["userid"];
		Checkpoint = params["checkpoint"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(Checkpoint)
		{
			FileIO.SaveTable( "Save_RunTime", _SaveGemeRunTime() );
			FileIO.SaveTable( "total_gametime", _SaveTotalGameTime());
			if(UserId > 0)
			{
				DoorCloseNum[UserIddent.GetEntityIndex()]++;
				GetUserIdModel = User_Model(UserIddent);
				if(!IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(玩家)";
				}
				if(IsPlayerABot(UserIddent))
				{
					UserIddent_BotOrPlayer = "(电脑)";
				}
				Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":"+Player(UserIddent).GetName()+"关上安全门"+DoorCloseNum[UserIddent.GetEntityIndex()]+"次");
				if(SafeDoor_Off == 1)
				{
					if(DoorCloseNum[UserIddent.GetEntityIndex()] >= 5 && DoorCloseNum[UserIddent.GetEntityIndex()] < SafeDoor_Num)
					{
						local Num = SafeDoor_Num-DoorCloseNum[UserIddent.GetEntityIndex()]-1;
						local ClientInfo = "警告"+Num+"次，自杀";
						Player(UserIddent).ShowHint(ClientInfo, 8, "icon_door", "", "255 0 0");
						Player(UserIddent).PlaySound("Buttons.snd11");
					}
					if(DoorCloseNum[UserIddent.GetEntityIndex()] >= SafeDoor_Num)
					{
						Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":强制"+Player(UserIddent).GetName()+"自杀，原因：频繁使用安全门");
						Player(UserIddent).Kill();
						DoorCloseNum[UserIddent.GetEntityIndex()] = 0;
					}
				}
			}
		}
	}
}
function OnGameEvent_door_unlocked(params)
{
	local UserId = null;
	local UserIddent = null;
	local hudtip = null;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdModel = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0)
		{
			GetUserIdModel = User_Model(UserIddent);
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":"+Player(UserIddent).GetName()+"解锁安全门");
		}
	}
}
::CloseMenu <- function(menu)
{
	menu.Detach();
}
function OnGameEvent_charger_pummel_start(params)
{
	local UserId = null;
	local VictimId = null;
	local UserIddent = null;
	local Victimdent = null;
	local hudtip = null;
	local Victimdent_BotOrPlayer = [];
	local UserIddent_BotOrPlayer = [];
	local GetVictimModel = [];
	local Zombie_Type = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
		VictimId = params["victim"];
        UserIddent = GetPlayerFromUserID(UserId);
		Victimdent = GetPlayerFromUserID(VictimId);
		Zombie_Type = Get_ZombieName(UserIddent);
		if(UserId > 0 && VictimId > 0)
		{
			GetVictimModel = User_Model(Victimdent);
			ChargerPummel[Victimdent.GetEntityIndex()]++;
			if(!IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)"+Zombie_Type+":";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)"+Zombie_Type+":";
			}
			Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+UserIddent.GetPlayerName()+"抓住"+Victimdent_BotOrPlayer+GetVictimModel+":"+Victimdent.GetPlayerName()+"，被抓"+ChargerPummel[Victimdent.GetEntityIndex()]+"次");
			if(AotoFlounce_Off == 1 && !IsPlayerABot(Victimdent) && Player(UserIddent).IsAlive())
			{
				GetVictimId = Victimdent;
				GetAttackerId = UserIddent;
				Timers.AddTimer( _FlounceTime, false, Aoto_Flounce, Victimdent );
			}
		}
	}
}
function OnGameEvent_lunge_pounce(params)
{
	local UserId = null;
	local VictimId = null;
	local UserIddent = null;
	local Victimdent = null;
	local hudtip = null;
	local Victimdent_BotOrPlayer = [];
	local UserIddent_BotOrPlayer = [];
	local GetVictimModel = [];
	local Zombie_Type = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
		VictimId = params["victim"];
        UserIddent = GetPlayerFromUserID(UserId);
		Victimdent = GetPlayerFromUserID(VictimId);
		if(UserId > 0 && VictimId > 0)
		{
			GetVictimModel = User_Model(Victimdent);
			Zombie_Type = Get_ZombieName(UserIddent);
			LungePounce[Victimdent.GetEntityIndex()]++;
			if(!IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)"+Zombie_Type+":";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)"+Zombie_Type+":";
			}
			Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+UserIddent.GetPlayerName()+"抓住"+Victimdent_BotOrPlayer+GetVictimModel+":"+Victimdent.GetPlayerName()+"，被抓"+LungePounce[Victimdent.GetEntityIndex()]+"次");
			if(AotoFlounce_Off == 1 && !IsPlayerABot(Victimdent) && Player(UserIddent).IsAlive())
			{
				GetVictimId = Victimdent;
				GetAttackerId = UserIddent;
				Timers.AddTimer( _FlounceTime, false, Aoto_Flounce, Victimdent );
			}
		}
	}
}
function OnGameEvent_jockey_ride(params)
{
	local UserId = null;
	local VictimId = null;
	local Victimdent = null;
	local UserIddent = null;
	local hudtip = null;
	local Victimdent_BotOrPlayer = [];
	local UserIddent_BotOrPlayer = [];
	local GetVictimModel = [];
	local Zombie_Type = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
		VictimId = params["victim"];
        UserIddent = GetPlayerFromUserID(UserId);
		Victimdent = GetPlayerFromUserID(VictimId);
		if(UserId > 0 && VictimId > 0)
		{
			GetVictimModel = User_Model(Victimdent);
			Zombie_Type = Get_ZombieName(UserIddent);
			JockeyRide[Victimdent.GetEntityIndex()]++;
			if(!IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)"+Zombie_Type+":";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)"+Zombie_Type+":";
			}
			Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+UserIddent.GetPlayerName()+"骑住"+Victimdent_BotOrPlayer+GetVictimModel+":"+Victimdent.GetPlayerName()+"，被骑"+JockeyRide[Victimdent.GetEntityIndex()]+"次");
			if(AotoFlounce_Off == 1 && !IsPlayerABot(Victimdent) && Player(UserIddent).IsAlive())
			{
				GetVictimId = Victimdent;
				GetAttackerId = UserIddent;
				Timers.AddTimer( _FlounceTime, false, Aoto_Flounce, Victimdent );
			}
		}
	}
}
function OnGameEvent_gascan_pour_completed(params)
{
	local UserId = null;
	local UserIddent = null;
	local hudtip = null;
	local UserIddent_BotOrPlayer = [];
	local ItemInfo = [];
	if(params.rawin("userid"))
	{
		UserId = params["userid"];
		UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0 && Get_UserIdTeam(UserIddent) == 2)
		{
			
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			Completed_Num++;
			ItemInfo = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+UserIddent.GetPlayerName()+" 已倒完汽油，完成"+Completed_Num+"桶";
			hudtip = HUD.Item(ItemInfo);
			hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
		}
	}
}
function OnGameEvent_player_now_it(params)
{
	local UserId = null;
	local AttackerId = null;
	local Attackerdent = null;
	local UserIddent = null;
	local hudtip = null;
	local GetAttackerTeam = null;
	local GetUserIdTeam = null;
	local UserIddent_BotOrPlayer = [];
	local Attackerdent_BotOrPlayer = [];
	local GetUserIdModel = [];
	local GetAttackerModel = [];
	local Zombie_Type = [];
	local ZombieType = [];
	local ItemInfo = [];
    if(params.rawin("userid") && params.rawin("attacker"))
	{
		UserId = params["userid"];
		AttackerId = params["attacker"];
        UserIddent = GetPlayerFromUserID(UserId);
		Attackerdent = GetPlayerFromUserID(AttackerId);
		if(UserId > 0 && AttackerId > 0)
		{
			GetUserIdModel = User_Model(UserIddent);
			GetUserIdTeam = Get_UserIdTeam(UserIddent);
			GetAttackerTeam = Get_UserIdTeam(Attackerdent);
			GetAttackerModel = User_Model(Attackerdent);
			ZombieType = Get_ZombieName(UserIddent);
			Zombie_Type = Get_ZombieName(Attackerdent);
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			if(GetAttackerTeam == 3)
			{
				if(Attackerdent.IsValid())
				{
					if(!IsPlayerABot(Attackerdent))
					{
						
						Attackerdent_BotOrPlayer = "(玩家)"+Zombie_Type+":";
					}
					if(IsPlayerABot(Attackerdent))
					{
						
						Attackerdent_BotOrPlayer = "(电脑)"+Zombie_Type+":";
					}
					ItemInfo = Attackerdent_BotOrPlayer+Attackerdent.GetPlayerName()+" 呕吐 "+UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName();
				}
			}
			if(GetAttackerTeam == 2)
			{
				if(!IsPlayerABot(Attackerdent) && Attackerdent.IsValid())
				{
					if(GetUserIdTeam == 2)
					{
						ItemInfo = "(玩家)"+GetAttackerModel+":"+Attackerdent.GetPlayerName()+" 的胆汁击中 "+GetUseridModel+":"+UserIddent.GetPlayerName();
					}
					if(GetUserIdTeam == 3)
					{
						ItemInfo = "(玩家)"+GetAttackerModel+":"+Attackerdent.GetPlayerName()+" 的胆汁击中 "+ZombieType+":"+UserIddent.GetPlayerName();
					}
				}
			}
			hudtip = HUD.Item(ItemInfo);
			hudtip.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			hudtip.ChangeHUDNative(10, 40, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			hudtip.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG|HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
		}
	}
}
function OnGameEvent_player_no_longer_it(params)
{
	local UserId = null;
	local UserIddent = null;
	local hudtip = null;
	local UserIddent_BotOrPlayer = [];
	local ItemInfo = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0)
		{
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			if(Get_UserIdTeam(UserIddent) == 2)
			{
				ItemInfo = UserIddent_BotOrPlayer+User_Model(UserIddent)+":"+UserIddent.GetPlayerName()+" 胆汁已消失";
			}
			if(Get_UserIdTeam(UserIddent) == 3)
			{
				ItemInfo = UserIddent_BotOrPlayer+Get_ZombieName(UserIddent)+":"+UserIddent.GetPlayerName()+" 胆汁已消失";
			}
			hudtip = HUD.Item(ItemInfo);
			hudtip.AttachTo(HUD_FAR_LEFT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
			hudtip.ChangeHUDNative(10, 40, 1024, 80, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
			hudtip.SetTextPosition(TextAlign.Left); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
			hudtip.AddFlag(g_ModeScript.HUD_FLAG_NOBG); //设置HUD界面参数
			Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
		}
	}
}
function OnGameEvent_tongue_grab(params)
{
	local UserId = null;
	local VictimId = null;
	local Victimdent = null;
	local UserIddent = null;
	local hudtip = null;
	local Victimdent_BotOrPlayer = [];
	local UserIddent_BotOrPlayer = [];
	local GetVictimModel = [];
	local Zombie_Type = [];
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
		VictimId = params["victim"];
        UserIddent = GetPlayerFromUserID(UserId);
		Victimdent = GetPlayerFromUserID(VictimId);
		if(UserId > 0 && VictimId > 0)
		{
			GetVictimModel = User_Model(Victimdent);
			Zombie_Type = Get_ZombieName(UserIddent);
			TongueGrab[Victimdent.GetEntityIndex()]++;
			if(!IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(Victimdent))
			{
				Victimdent_BotOrPlayer = "(电脑)";
			}
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)"+Zombie_Type+":";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)"+Zombie_Type+":";
			}
			Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+UserIddent.GetPlayerName()+"拉住"+Victimdent_BotOrPlayer+GetVictimModel+":"+Victimdent.GetPlayerName()+"，被拉"+TongueGrab[Victimdent.GetEntityIndex()]+"次");
			if(AotoFlounce_Off == 1 && !IsPlayerABot(Victimdent) && Player(UserIddent).IsAlive())
			{
				GetVictimId = Victimdent;
				GetAttackerId = UserIddent;
				Timers.AddTimer( _FlounceTime, false, Aoto_FlounceSmoker, Victimdent);
			}
		}
	}
}
::Aoto_FlounceSmoker <- function(client)
{
	/* 杀死攻击者 */
	if(GetAttackerId != null)
	{
		if (!Player(GetAttackerId).IsDead() || !Player(GetAttackerId).IsDying())
		{
			if(Player(GetVictimId).IsSurvivorTrapped())
			{
				local _GetDist = GetCalculateDistance(GetAttackerId, GetVictimId);
				if(_GetDist.tointeger() <= 10000)
				{
					Player(GetAttackerId).Kill();
				}
			}
		}
	}
	/* 创建爆炸 */
	local model = Utils.SpawnPhysicsProp("models/props_junk/propanecanister001a.mdl", Entity(GetAttackerId).GetEyePosition());
	model.Input("break", GetAttackerId);
	Entity(model).SetNetProp( "m_CollisionGroup",  1);
	/* 创建推 */
	local Key = 
	{
		magnitude = 500,
		radius = 200,
		inner_radius = 500,
		spawnflags = 24,
	}
	local GetPush = Utils.CreateEntity("point_push", Entity(client).GetEyePosition(), Entity(client).GetAngles(), Key);
	GetPush.Input("Enable", client);
	Timers.AddTimer(1.0, false, DeletePushForce, GetPush);
}
::Aoto_Flounce <- function(client)
{
	/* 杀死攻击者 */
	if(GetAttackerId != null)
	{
		if (!Player(GetAttackerId).IsDead() || !Player(GetAttackerId).IsDying())
		{
			if(Player(GetVictimId).IsSurvivorTrapped())
			{
				local _GetDist = GetCalculateDistance(GetAttackerId, GetVictimId);
				if(_GetDist.tointeger() <= 100)
				{
					Player(GetAttackerId).Kill();
				}
			}
		}
	}
	/* 创建爆炸 */
	local model = Utils.SpawnPhysicsProp("models/props_junk/propanecanister001a.mdl", Entity(GetAttackerId).GetEyePosition());
	model.Input("break", GetAttackerId);
	Entity(model).SetNetProp( "m_CollisionGroup",  1);
	/* 创建推 */
	local Key = 
	{
		magnitude = 500,
		radius = 200,
		inner_radius = 500,
		spawnflags = 24,
	}
	local GetPush = Utils.CreateEntity("point_push", Entity(client).GetEyePosition(), Entity(client).GetAngles(), Key);
	GetPush.Input("Enable", client);
	Timers.AddTimer(1.0, false, DeletePushForce, GetPush);
}
::DeletePushForce <- function(push)
{
	if(Entity(push).GetClassname().tolower() == "point_push")
	{
		push.Input("Disable");
		push.Input("Kill");
		Utils.RemoveEntity(push);
	}
}
function OnGameEvent_upgrade_pack_used(params)
{
	local UserId = null;
	local UserIddent = null;
    if(params.rawin("userid"))
	{
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		if(UserId > 0)
		{
			if(!IsPlayerABot(UserIddent) && UserIddent.IsValid())
			{
				Timers.AddTimer( 0.1, false, Timer_UpgradePackInfo, UserIddent );
			}
		}
	}
}
::Timer_UpgradePackInfo <- function(client)
{
	Utils.SayToAll("[-]"+"(玩家)"+User_Model(client)+":"+Player(client).GetName()+"已部署升级包");
	local Info = Player(client).GetName()+" 部署升级包";
	local ent = Utils.SpawnInventoryItem( Info, Get_ZombieModels(client), Get_Position(client) );
	local hint = Utils.SetEntityHint(ent, Info, "tip_incendiary_ammo", 100000);
	hint.GetScriptScope()["hint"] <- hint;
	ent.GetScriptScope()["killinfo"] <- ent;
	Timers.AddTimer( 10.0, false, KillAttacker_Info, hint );
	Timers.AddTimer( 0.1, false, KillModels, ent );
}
function OnGameEvent_defibrillator_used(params)
{
	local UserId = null;
	local SubjectId = null;
	local Subjectdent = null;
	local UserIddent = null;
	local GetUserIdModel = [];
	local GetSubjectModel = [];
	local SubjectId_BotOrPlayer = [];
    if(params.rawin("userid") && params.rawin("subject"))
	{
		UserId = params["userid"];
		SubjectId = params["subject"];
        UserIddent = GetPlayerFromUserID(UserId);
		Subjectdent = GetPlayerFromUserID(SubjectId);
		if(UserId > 0 && SubjectId > 0)
		{
			if(!IsPlayerABot(UserIddent))
			{
				GetUserIdModel = User_Model(UserIddent);
				GetSubjectModel = User_Model(Subjectdent);
				if(!IsPlayerABot(Subjectdent))
				{
					Timers.AddTimer(0.1, false, Timer_Zoom, Subjectdent);
					SubjectId_BotOrPlayer = "(玩家)";
					if(_SetHealth[Entity(subjectdent).GetBaseIndex()] == 1 && UpgradeOff == 1)
					{
						local NewHealth = GetUpgradeKV(subjectdent, UpgradeIdx.Hp)+100;
						Entity(subjectdent).SetMaxHealth(NewHealth);
						Player(Subjectdent).Give("health");
					}
				}
				if(IsPlayerABot(Subjectdent))
				{
					SubjectId_BotOrPlayer = "(电脑)";
				}
				DefibrillatorUsed_AddExpKV(UserIddent);
				DefibrillatorNum[UserIddent.GetEntityIndex()]++;
				Utils.SayToAll("[-]"+"(玩家)"+GetUserIdModel+":"+Player(UserIddent).GetName()+"使用电击器救活"+SubjectId_BotOrPlayer+GetSubjectModel+":"+Subjectdent.GetPlayerName()+"，我总共电击"+DefibrillatorNum[UserIddent.GetEntityIndex()]+"次");
			}
		}
	}
}
function OnGameEvent_witch_spawn(event)
{
	WitchSpawn++;
	Witchid = EntIndexToHScript(event.witchid);
	if(WitchSpawnInfo == 0)
	{
		WitchSpawnInfo++;
		Timers.AddTimer(0.2, false, Timer_WitchSpawnInfo);
	}
}
::Timer_WitchSpawnInfo <- function(params)
{
	local Distance = 0;
	TriggerEvent_Zombie = 0;
	foreach (p in Players.All())
	{
		if(ClientIsAlive(p) == 1 && p.GetTeam() == SURVIVORS && !Entity(p).IsBot())
		{
			Distance = Utils.CalculateDistance(Entity(p).GetLocation(), Entity(Witchid).GetLocation());
			local Info = "出现"+WitchSpawn+"女巫，距离"+Distance.tointeger()+"m";
			Player(p).ShowHint(Info, 8, "Stat_Most_Witch_Dmg", "", HUD_RandomColor());
		}
	}
	Timers.AddTimer(0.5, false, Timer_WitchZero);
}
::Timer_WitchZero <- function(params)
{
	WitchSpawn = 0;
	WitchSpawnInfo = 0;
}
function OnGameEvent_tank_spawn(params)
{
	local UserId = null;
	local User = null;
	local ent = null;
	local TankInfo = [];
	local User_BotOrPlayer = [];
	if(params.rawin("userid"))
	{
		UserId = params["userid"];
		User = GetPlayerFromUserID(UserId);
		if(Get_ZombieName(User) == "坦克")
		{
			TankNum++;
			if(ModelOption == 2)
			{
				Player(User).Kill();
			}
			if(ModelOption == 8)
			{
				if(IsOfficialMaps() == 1)
				{
					if(MapIsValid(SessionState.MapName.tolower()) == 0)
					{
						Player(User).Kill();
					}
				}
			}
			if(ModelOption == 9)
			{
				if(ModelRandom == 2)
				{
					Player(User).Kill();
				}
				if(ModelRandom == 8)
				{
					if(IsOfficialMaps() == 1)
					{
						if(MapIsValid(SessionState.MapName.tolower()) == 0)
						{
							Player(User).Kill();
						}
					}
				}
			}
			if(!IsPlayerABot(User))
			{
				User_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(User))
			{
				User_BotOrPlayer = "(电脑)";
			}
			GetTankHealth[User.GetEntityIndex()] = Entity(User).GetHealth();
			while (ent = Entities.FindByClassname(ent, "player"))
			{
				if (Get_UserIdTeam(ent) == 2)
				{
					DmgTankHealth[ent.GetEntityIndex()] = 0;
				}
			}
			if(NewTank == 0)
			{
				if(ModelOption == 1 || ModelOption == 3 || ModelOption == 4 || ModelOption == 5 || ModelOption == 6 || ModelOption == 7)
				{
					foreach (p in Players.All())
					{
						if(!IsPlayerABot(p) && ClientIsAlive(p) == 1 && p.GetTeam() == SURVIVORS)
						{
							if(TankSpawnSound == 1)
							{
								p.PlaySound("HulkZombie.PainFire");
							}
							if(TankSpawnSound == 2)
							{
								p.PlaySound(GetRandomSound());
							}
							if(FadeScreenOff == 1)
							{
								Utils.FadeScreen(p, 255, 255, 255, 255, 1.0, 0.0, false, true);
							}
							if(ShakeScreenOff == 1)
							{
								Utils.ShakeScreen(Get_Position(p), 200, 3, 10, 500);
							}
							if(TankSlowTime_Off == 1)
							{
								Utils.SlowTime(0.5);
							}
						}
					}
				}
				if(ModelOption == 9)
				{
					if(ModelRandom == 1 || ModelRandom == 3 || ModelRandom == 4 || ModelRandom == 5 || ModelRandom == 6 || ModelRandom == 7)
					{
						foreach (p in Players.All())
						{
							if(!IsPlayerABot(p) && ClientIsAlive(p) == 1 && p.GetTeam() == SURVIVORS)
							{
								if(TankSpawnSound == 1)
								{
									p.PlaySound("HulkZombie.PainFire");
								}
								if(TankSpawnSound == 2)
								{
									p.PlaySound(GetRandomSound());
								}
								if(FadeScreenOff == 1)
								{
									Utils.FadeScreen(p, 255, 255, 255, 255, 1.0, 0.0, false, true);
								}
								if(ShakeScreenOff == 1)
								{
									Utils.ShakeScreen(Get_Position(p), 200, 3, 10, 500);
								}
								if(TankSlowTime_Off == 1)
								{
									Utils.SlowTime(0.5);
								}
							}
						}
					}
				}
			}
			if(NewTank == 1)
			{
				Entity(User).SetHealth(SetNewTankHealth);
				Timers.AddTimer( 1.0, false, Timer_NewTank );
			}
		}
	}
}
::Timer_NewTank <- function(params)
{
	NewTank = 0;
	SetNewTankHealth = 0;
}
::GetRandomSound<-function()
{
	local Sound = {};
	if(Utils.GetSurvivorSet() == 1)
	{
		local L4D1Survs = RandomInt(1, 4);
		if(L4D1Survs == 1)
		{
			Sound = "Player.TeenGirl_C6DLC3OPENINGDOOR03"
		}
		if(L4D1Survs == 2)
		{
			Sound = "Player.Biker_WarnTank03"
		}
		if(L4D1Survs == 3)
		{
			Sound = "Player.Manager_WarnTank02"
		}
		if(L4D1Survs == 4)
		{
			Sound = "Player.NamVet_WarnTank03"
		}
	}
	else
	{
		local L4D2Survs = RandomInt(1, 4);
		if(L4D2Survs == 1)
		{
			Sound = "Coach_FriendlyFireTank07"
		}
		if(L4D2Survs == 2)
		{
			Sound = "Producer_FriendlyFireTank01"
		}
		if(L4D2Survs == 3)
		{
			Sound = "Mechanic_FriendlyFireTank01"
		}
		if(L4D2Survs == 4)
		{
			Sound = "Gambler_FriendlyFireTank02"
		}
	}
	
	return Sound;
}
function OnGameEvent_player_incapacitated(params)
{
	local AttackerId = null;
	local AttackerIddent = null;
	local UserId = null;
	local UserIddent = null;
	local hudtip = null;
	local TankIncapacitated = null;
	local UserIddent_BotOrPlayer = [];
	local GetUserIdModel = [];
	local ZombieType = [];
    if(params.rawin("userid") && params.rawin("attacker"))
	{
		UserId = params["userid"];
        UserIddent = GetPlayerFromUserID(UserId);
		AttackerId = params["attacker"];
        AttackerIddent = GetPlayerFromUserID(AttackerId);
		if(UserId > 0)
		{
			ZombieType = Get_ZombieName( UserIddent );
			if(!IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(玩家)";
			}
			if(IsPlayerABot(UserIddent))
			{
				UserIddent_BotOrPlayer = "(电脑)";
			}
			if(Player(UserIddent).GetTeam() == SURVIVORS)
			{
				if(UpgradeOff == 1 && !IsPlayerABot(UserIddent))
				{
					ReduceExpKV(UserIddent, 2);
					
				}
				GetUserIdModel = User_Model(UserIddent);
				if(ShowInfo_Type == 1)
				{
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+"倒下了");
				}
				if(ShowInfo_Type == 2)
				{
					hudtip = HUD.Item(UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
				if(ShowInfo_Type == 3)
				{
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip = HUD.Item(UserIddent_BotOrPlayer+GetUserIdModel+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
			}
			if(Player(UserIddent).GetTeam() == INFECTED)
			{
				if(Player(UserIddent).GetPlayerType() == Z_TANK)
				{
					if(AttackerIddent.GetPlayerName() == UserIddent.GetPlayerName())
					{
						Entity(UserIddent).KillDelayed(0.5);
						SetNewTankHealth = Entity(UserIddent).GetHealth();
						if(NewTank == 0)
						{
							NewTank = 1;
							Timers.AddTimer( 1.0, false, Create_NewTank );
						}
					}
				}
				if( ShowInfo_Type == 1 )
				{
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+ZombieType+":"+UserIddent.GetPlayerName()+"倒下了");
				}
				if( ShowInfo_Type == 2 )
				{
					hudtip = HUD.Item(UserIddent_BotOrPlayer+ZombieType+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
				if( ShowInfo_Type == 3 )
				{
					Utils.SayToAll("[-]"+UserIddent_BotOrPlayer+ZombieType+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip = HUD.Item(UserIddent_BotOrPlayer+ZombieType+":"+UserIddent.GetPlayerName()+"倒下了");
					hudtip.AttachTo(HUD_MID_BOT); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
					hudtip.ChangeHUDNative(0, 0, 1024, 45, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
					hudtip.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
					hudtip.AddFlag(g_ModeScript.HUD_FLAG_AS_TIME|HUD_FLAG_NOBG); //设置HUD界面参数
					Timers.AddTimer( 5.0, false, CloseHud, hudtip ); //添加计时器关闭HUD
				}
			}
		}
	}
}
::Create_NewTank <- function(params)
{
	local TankIncapacitated = null;
	local pos = Utils.GetNearbyLocationRadius( RandomAllSurvivor(), 400, 1200 );
	if(pos)
	{
		Utils.SpawnZombie( Z_TANK, pos );
		TankIncapacitated = HUD.Item("坦克防卡启动");
		TankIncapacitated.AttachTo(HUD_RIGHT_TOP); //HUD位置参数，可使用预设参数，如HUD_MID_BOT，也可使用数值(0-14)，如0, 0, 0, 0(x坐标, y坐标, 宽, 高)
		TankIncapacitated.ChangeHUDNative(250, 200, 1024, 400, 1024, 768); // HUD坐标(xy)和长宽，后面1024(长)和768(宽)是屏幕最大值
		TankIncapacitated.SetTextPosition(TextAlign.Center); //文本对齐参数，Left=左对齐，Center=中心对齐，Right=右对齐
		TankIncapacitated.AddFlag(g_ModeScript.HUD_FLAG_BLINK|HUD_FLAG_NOBG); //设置HUD界面参数
		Timers.AddTimer( 5.0, false, CloseHud, TankIncapacitated ); //添加计时器关闭HUD
	}
	else
	{
		Timers.AddTimer( 0.1, Create_NewTank ); 
	}
}
::Close_TeamHud <- function(hud)
{
	hud.Detach();
}
::CloseHud <- function(hud)
{
	hud.Detach();
}
::Get_UserIdTeam<-function(UserId)
{
	local Team = 0;
	
	local TeamId = Player(UserId);
	if (TeamId.GetTeam() == SPECTATORS)
	{
		Team = 1;
	}
	if (TeamId.GetTeam() == SURVIVORS)
	{
		Team = 2;
	}
	if (TeamId.GetTeam() == INFECTED)
	{
		Team = 3;
	}
	
	return Team;
}

::ZombieIsAlive<-function(Z)
{
	local Alive = Entity(Z);
	
	if ( Alive.IsAlive() )
	{
		return 1;
	}
	
	return 0;
}
::ClientIsAlive<-function(P)
{
	local Alive = Player(P);
	
	if ( Alive.IsAlive() )
	{
		return 1;
	}
	
	return 0;
}

::GetIdAngles<-function(P)
{
	local IdAngles = 0.0;
	
	local PId = Entity(P);
	if(PId)
	{
		IdAngles = PId.GetAngles();
	}
	
	return IdAngles;
}
::Get_EyePosition<-function(P)
{
	local EyePosition = 0.0;
	
	local PId = Entity(P);
	if(PId)
	{
		EyePosition = PId.GetEyePosition();
	}
	
	return EyePosition;
}
::Get_Position<-function(P)
{
	local EyePosition = 0.0;
	
	local PId = Entity(P);
	if(PId)
	{
		EyePosition = PId.GetPosition();
	}
	
	return EyePosition;
}
::GetCalculateDistance<-function(P, D)
{
	local Distance = 0.0;
	
	local PId = Player(P);
	local DId = Player(D);
	if(PId)
	{
		Distance = Utils.GetDistBetweenEntities(PId, DId);
	}
	
	return Distance;
}
::GetSpawnItem<-function()
{
	local Spawn = [];
	
	local Probability = RandomInt(1, 14);
	
	if(Probability == 1)
	{
		Spawn = "weapon_rifle";
		GetSpawnItemName = "M16";
	}
	if(Probability == 2)
	{
		Spawn = "weapon_rifle_desert";
		GetSpawnItemName = "沙漠步枪";
	}
	if(Probability == 3)
	{
		Spawn = "weapon_rifle_ak47";
		GetSpawnItemName = "AK47";
	}
	if(Probability == 4)
	{
		Spawn = "weapon_first_aid_kit";
		GetSpawnItemName = "医疗包";
	}
	if(Probability == 5)
	{
		Spawn = "weapon_pain_pills";
		GetSpawnItemName = "止痛药";
	}
	if(Probability == 6)
	{
		Spawn = "weapon_adrenaline";
		GetSpawnItemName = "肾上腺素";
	}
	if(Probability == 7)
	{
		Spawn = "weapon_autoshotgun";
		GetSpawnItemName = "一代连喷";
	}
	if(Probability == 8)
	{
		Spawn = "weapon_grenade_launcher";
		GetSpawnItemName = "榴弹枪";
	}
	if(Probability == 9)
	{
		Spawn = "weapon_sniper_military";
		GetSpawnItemName = "二代连阻";
	}
	if(Probability == 10)
	{
		Spawn = "weapon_shotgun_spas";
		GetSpawnItemName = "二代连喷";
	}
	if(Probability == 11)
	{
		Spawn = "weapon_pipe_bomb";
		GetSpawnItemName = "土制炸弹";
	}
	if(Probability == 12)
	{
		Spawn = "weapon_molotov";
		GetSpawnItemName = "燃烧瓶";
	}
	if(Probability == 13)
	{
		Spawn = "weapon_vomitjar";
		GetSpawnItemName = "胆汁";
	}
	if(Probability == 14)
	{
		Spawn = "weapon_first_aid_kit";
		GetSpawnItemName = "医疗包";
	}
	
	
	return Spawn;
}
::RandomItem<-function()
{
	local Items = [];
	
	local Probability = RandomInt(1, 14);
	
	if(Probability == 1)
	{
		Items = "weapon_rifle";
		GetGiveItemsName = "M16";
	}
	if(Probability == 2)
	{
		Items = "weapon_rifle_desert";
		GetGiveItemsName = "沙漠步枪";
	}
	if(Probability == 3)
	{
		Items = "weapon_rifle_ak47";
		GetGiveItemsName = "AK47";
	}
	if(Probability == 4)
	{
		Items = "weapon_first_aid_kit";
		GetGiveItemsName = "医疗包";
	}
	if(Probability == 5)
	{
		Items = "pain_pills";
		GetGiveItemsName = "止痛药";
	}
	if(Probability == 6)
	{
		Items = "adrenaline";
		GetGiveItemsName = "肾上腺素";
	}
	if(Probability == 7)
	{
		Items = "weapon_autoshotgun";
		GetGiveItemsName = "一代连喷";
	}
	if(Probability == 8)
	{
		Items = "weapon_grenade_launcher";
		GetGiveItemsName = "榴弹枪";
	}
	if(Probability == 9)
	{
		Items = "weapon_sniper_military";
		GetGiveItemsName = "二代连阻";
	}
	if(Probability == 10)
	{
		Items = "weapon_shotgun_spas";
		GetGiveItemsName = "二代连喷";
	}
	if(Probability == 11)
	{
		Items = "pipe_bomb";
		GetGiveItemsName = "土制炸弹";
	}
	if(Probability == 12)
	{
		Items = "molotov";
		GetGiveItemsName = "燃烧瓶";
	}
	if(Probability == 13)
	{
		Items = "vomitjar";
		GetGiveItemsName = "胆汁";
	}
	if(Probability == 14)
	{
		Items = "health";
		GetGiveItemsName = "恢复生命";
	}
	
	return Items;
}
::Get_ZombieName<-function(Z)
{
	local TypeName = [];
	
	local Id = Player(Z);
	if(Id.GetPlayerType() == Z_SPITTER)
	{
		TypeName = "毒液";
	}
	else if(Id.GetPlayerType() == Z_HUNTER)
	{
		TypeName = "猎人";
	}
	else if(Id.GetPlayerType() == Z_JOCKEY)
	{
		TypeName = "骑士";
	}
	else if(Id.GetPlayerType() == Z_SMOKER)
	{
		TypeName = "长舌";
	}
	else if(Id.GetPlayerType() == Z_BOOMER)
	{
		TypeName = "毒瘤";
	}
	else if(Id.GetPlayerType() == Z_CHARGER)
	{
		TypeName = "独臂";
	}
	else if(Id.GetPlayerType() == Z_TANK)
	{
		TypeName = "坦克";
	}
	else if(Id.GetPlayerType() == Z_SURVIVOR)
	{
		TypeName = "幸存者";
	}
	
	return TypeName;
}
::Get_ZombieModels<-function(Z)
{
	local GetModels = [];
	
	if(Get_UserIdTeam(Z) == 3)
	{
		if(Player(Z).GetPlayerType() == Z_SPITTER)
		{
			GetModels = "models/infected/spitter.mdl";
		}
		else if(Player(Z).GetPlayerType() == Z_HUNTER)
		{
			GetModels = "models/infected/hunter.mdl";
		}
		else if(Player(Z).GetPlayerType() == Z_JOCKEY)
		{
			GetModels = "models/infected/jockey.mdl";
		}
		else if(Player(Z).GetPlayerType() == Z_SMOKER)
		{
			GetModels = "models/infected/smoker.mdl";
		}
		else if(Player(Z).GetPlayerType() == Z_BOOMER)
		{
			GetModels = "models/infected/boomer.mdl";
		}
		else if(Player(Z).GetPlayerType() == Z_CHARGER)
		{
			GetModels = "models/infected/charger.mdl";
		}
	}
	if(Get_UserIdTeam(Z) == 2)
	{
		if(User_Model(Z) == "教练")
		{
			GetModels = "models/survivors/survivor_coach.mdl";
		}
		if(User_Model(Z) == "技工")
		{
			GetModels = "models/survivors/survivor_mechanic.mdl";
		}
		if(User_Model(Z) == "赌徒")
		{
			GetModels = "models/survivors/survivor_gambler.mdl";
		}
		if(User_Model(Z) == "女记者")
		{
			GetModels = "models/survivors/survivor_producer.mdl";
		}
		if(User_Model(Z) == "女学生")
		{
			GetModels = "models/survivors/survivor_teenangst.mdl";
		}
		if(User_Model(Z) == "摩托党")
		{
			GetModels = "models/survivors/survivor_biker.mdl";
		}
		if(User_Model(Z) == "职员")
		{
			GetModels = "models/survivors/survivor_manager.mdl";
		}
		if(User_Model(Z) == "老兵")
		{
			GetModels = "models/survivors/survivor_namvet.mdl";
		}
	}
	
	return GetModels;
}
::_GetGender<-function(User)
{
	local Gender = [];
	
	if(Get_UserIdTeam(User) == 2)
	{
		local GetModel = _GetSurvivorModel(User);
		if(GetModel == "models/survivors/survivor_coach.mdl" || GetModel == "models/survivors/survivor_mechanic.mdl" || 
			GetModel == "models/survivors/survivor_gambler.mdl" || GetModel == "models/survivors/survivor_biker.mdl" || 
			GetModel == "models/survivors/survivor_manager.mdl" || GetModel == "models/survivors/survivor_namvet.mdl")
		{
			Gender = "man";
		}
		
		if(GetModel == "models/survivors/survivor_producer.mdl" || GetModel == "models/survivors/survivor_teenangst.mdl")
		{
			Gender = "woman";
		}
	}
	
	
	return Gender;
}
::_GetSurvivorModel<-function(target)
{
	local modelname = [];
	if (Player(target).GetPlayerType() == Z_SURVIVOR)
	{
		local SurvivorModels =
		[
			"models/survivors/survivor_coach.mdl"
			"models/survivors/survivor_mechanic.mdl"
			"models/survivors/survivor_gambler.mdl"
			"models/survivors/survivor_producer.mdl"
			"models/survivors/survivor_namvet.mdl"
			"models/survivors/survivor_biker.mdl"
			"models/survivors/survivor_manager.mdl"
			"models/survivors/survivor_teenangst.mdl"
			"models/survivors/survivor_biker_light.mdl"
			"models/survivors/survivor_teenangst_light.mdl"
		]
		foreach( modelname in SurvivorModels )
		{
			foreach( survivor in Objects.OfModel(modelname) )
			{
				if ( survivor.GetEntityHandle() == Entity(target).GetEntityHandle() )
					return modelname;
			}
		}
	}
	
	return;
}
::User_Model<-function(User)
{
	local GetModel = [];
	local ModelName = [];
	local GetUserTeam = null;
	
	GetUserTeam = Get_UserIdTeam(User);
	if(GetUserTeam == 2)
	{
		GetModel = _GetSurvivorModel(User);
		if(GetModel == "models/survivors/survivor_coach.mdl")
		{
			ModelName = "教练"
		}
		if(GetModel == "models/survivors/survivor_mechanic.mdl")
		{
			ModelName = "技工"
		}
		if(GetModel == "models/survivors/survivor_gambler.mdl")
		{
			ModelName = "赌徒"
		}
		if(GetModel == "models/survivors/survivor_producer.mdl")
		{
			ModelName = "女记者"
		}
		if(GetModel == "models/survivors/survivor_teenangst.mdl")
		{
			ModelName = "女学生"
		}
		if(GetModel == "models/survivors/survivor_biker.mdl")
		{
			ModelName = "摩托党"
		}
		if(GetModel == "models/survivors/survivor_manager.mdl")
		{
			ModelName = "职员"
		}
		if(GetModel == "models/survivors/survivor_namvet.mdl")
		{
			ModelName = "老兵"
		}
	}
	
	
	return ModelName;
}
::Attacker_Weapon<-function(attacker)
{
	local GetWeapon = [];
	local WeaponName = [];
	
	GetWeapon = attacker.GetActiveWeapon().GetClassname();
	if(GetWeapon == "weapon_rifle_ak47")
	{
		WeaponName = " 手持AK47"
	}
	if(GetWeapon == "weapon_rifle")
	{
		WeaponName = " 手持M16"
	}
	if(GetWeapon == "weapon_smg")
	{
		WeaponName = " 手持冲锋枪"
	}
	if(GetWeapon == "weapon_smg_silenced")
	{
		WeaponName = " 手持消音冲锋枪"
	}
	if(GetWeapon == "weapon_smg_mp5")
	{
		WeaponName = " 手持MP5冲锋枪"
	}
	if(GetWeapon == "weapon_pumpshotgun")
	{
		WeaponName = " 手持一代单喷"
	}
	if(GetWeapon == "weapon_shotgun_chrome")
	{
		WeaponName = " 手持二代单喷"
	}
	if(GetWeapon == "weapon_rifle_desert")
	{
		WeaponName = " 手持沙漠步枪"
	}
	if(GetWeapon == "weapon_rifle_sg552")
	{
		WeaponName = " 手持SG552"
	}
	if(GetWeapon == "weapon_rifle_m60")
	{
		WeaponName = " 手持机枪M60"
	}
	if(GetWeapon == "weapon_autoshotgun")
	{
		WeaponName = " 手持一代连喷"
	}
	if(GetWeapon == "weapon_shotgun_spas")
	{
		WeaponName = " 手持二代连喷"
	}
	if(GetWeapon == "weapon_hunting_rifle")
	{
		WeaponName = " 手持一代连阻"
	}
	if(GetWeapon == "weapon_sniper_military")
	{
		WeaponName = " 手持二代连阻"
	}
	if(GetWeapon == "weapon_sniper_awp")
	{
		WeaponName = " 手持重阻AWP"
	}
	if(GetWeapon == "weapon_sniper_scout")
	{
		WeaponName = " 手持轻阻Scout"
	}
	if(GetWeapon == "weapon_grenade_launcher")
	{
		WeaponName = " 手持榴弹枪"
	}
	if(GetWeapon == "weapon_pistol")
	{
		WeaponName = " 手持手枪"
	}
	if(GetWeapon == "weapon_pistol_magnum")
	{
		WeaponName = " 手持沙漠之鹰"
	}
	if(GetWeapon == "weapon_melee")
	{
		WeaponName = " 手持近战"
	}
	if(GetWeapon == "weapon_chainsaw")
	{
		WeaponName = " 手持电锯"
	}
	if(GetWeapon == "weapon_pipe_bomb")
	{
		WeaponName = " 手持土制炸弹"
	}
	if(GetWeapon == "weapon_molotov")
	{
		WeaponName = " 手持燃烧瓶"
	}
	if(GetWeapon == "weapon_vomitjar")
	{
		WeaponName = " 手持胆汁"
	}
	if(GetWeapon == "weapon_first_aid_kit")
	{
		WeaponName = " 手持医疗包"
	}
	if(GetWeapon == "weapon_defibrillator")
	{
		WeaponName = " 手持电击器"
	}
	if(GetWeapon == "weapon_upgradepack_incendiary")
	{
		WeaponName = " 手持子弹升级包"
	}
	if(GetWeapon == "weapon_upgradepack_explosive")
	{
		WeaponName = " 手持子弹升级包"
	}
	if(GetWeapon == "weapon_pain_pills")
	{
		WeaponName = " 手持止痛药"
	}
	if(GetWeapon == "weapon_adrenaline")
	{
		WeaponName = " 手持肾上腺素"
	}
	if(GetWeapon == "weapon_gascan")
	{
		WeaponName = " 手持燃料桶"
	}
	if(GetWeapon == "weapon_propanetank")
	{
		WeaponName = " 手持煤气罐"
	}
	if(GetWeapon == "weapon_oxygentank")
	{
		WeaponName = " 手持氧气瓶"
	}
	if(GetWeapon == "weapon_gnome")
	{
		WeaponName = " 手持圣诞老人"
	}
	if(GetWeapon == "weapon_cola_bottles")
	{
		WeaponName = " 手持乐可瓶"
	}
	if(GetWeapon == "weapon_fireworkcrate")
	{
		WeaponName = " 手持烟花盒"
	}
	
	return WeaponName;
}