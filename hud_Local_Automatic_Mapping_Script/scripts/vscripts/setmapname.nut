/*  设置地图中文名称
*	如需添加新地图名称
*	请依照以下格式写入：
*	else if(Map == "建图代码")
	{
		GetMapName = "地图名称";
		Checkpoint = 地图总章节; 如黑色嘉年华为5章节
	}
*/
::Checkpoint <- 0;

::Set_MapName<-function(Map)
{
	local GetMapName = [];
	
	if(Map == "c1m1_hotel")
	{
		GetMapName = "死亡中心-第1站";
		Checkpoint = 4;
	}
	else if(Map == "c1m2_streets")
	{
		GetMapName = "死亡中心-第2站";
		Checkpoint = 4;
	}
	else if(Map == "c1m3_mall")
	{
		GetMapName = "死亡中心-第3站";
		Checkpoint = 4;
	}
	else if(Map == "c1m4_atrium")
	{
		GetMapName = "死亡中心-终点站";
		Checkpoint = 4;
	}
	else if(Map == "c2m1_highway")
	{
		GetMapName = "黑色嘉年华-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c2m2_fairgrounds")
	{
		GetMapName = "黑色嘉年华-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c2m3_coaster")
	{
		GetMapName = "黑色嘉年华-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c2m4_barns")
	{
		GetMapName = "黑色嘉年华-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c2m5_concert")
	{
		GetMapName = "黑色嘉年华-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c3m1_plankcountry")
	{
		GetMapName = "沼泽激战-第1站";
		Checkpoint = 4;
	}
	else if(Map == "c3m2_swamp")
	{
		GetMapName = "沼泽激战-第2站";
		Checkpoint = 4;
	}
	else if(Map == "c3m3_shantytown")
	{
		GetMapName = "沼泽激战-第3站";
		Checkpoint = 4;
	}
	else if(Map == "c3m4_plantation")
	{
		GetMapName = "沼泽激战-终点站";
		Checkpoint = 4;
	}
	else if(Map == "c4m1_milltown_a")
	{
		GetMapName = "暴风骤雨-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c4m2_sugarmill_a")
	{
		GetMapName = "暴风骤雨-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c4m3_sugarmill_b")
	{
		GetMapName = "暴风骤雨-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c4m4_milltown_b")
	{
		GetMapName = "暴风骤雨-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c4m5_milltown_escape")
	{
		GetMapName = "暴风骤雨-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c5m1_waterfront")
	{
		GetMapName = "教区-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c5m2_park")
	{
		GetMapName = "教区-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c5m3_cemetery")
	{
		GetMapName = "教区-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c5m4_quarter")
	{
		GetMapName = "教区-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c5m5_bridge")
	{
		GetMapName = "教区-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c6m1_riverbank")
	{
		GetMapName = "消逝-第1站";
		Checkpoint = 3;
	}
	else if(Map == "c6m2_bedlam")
	{
		GetMapName = "消逝-第2站";
		Checkpoint = 3;
	}
	else if(Map == "c6m3_port")
	{
		GetMapName = "消逝-终点站";
		Checkpoint = 3;
	}
	else if(Map == "c7m1_docks")
	{
		GetMapName = "牺牲-第1站";
		Checkpoint = 3;
	}
	else if(Map == "c7m2_barge")
	{
		GetMapName = "牺牲-第2站";
		Checkpoint = 3;
	}
	else if(Map == "c7m3_port")
	{
		GetMapName = "牺牲-终点站";
		Checkpoint = 3;
	}
	else if(Map == "c8m1_apartment")
	{
		GetMapName = "毫不留情-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c8m2_subway")
	{
		GetMapName = "毫不留情-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c8m3_sewers")
	{
		GetMapName = "毫不留情-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c8m4_interior")
	{
		GetMapName = "毫不留情-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c8m5_rooftop")
	{
		GetMapName = "毫不留情-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c9m1_alleys")
	{
		GetMapName = "坠机险途-第1站";
		Checkpoint = 2;
	}
	else if(Map == "c9m2_lots")
	{
		GetMapName = "坠机险途-终点站";
		Checkpoint = 2;
	}
	else if(Map == "c10m1_caves")
	{
		GetMapName = "死亡丧钟-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c10m2_drainage")
	{
		GetMapName = "死亡丧钟-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c10m3_ranchhouse")
	{
		GetMapName = "死亡丧钟-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c10m4_mainstreet")
	{
		GetMapName = "死亡丧钟-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c10m5_houseboat")
	{
		GetMapName = "死亡丧钟-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c11m1_greenhouse")
	{
		GetMapName = "寂静时分-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c11m2_offices")
	{
		GetMapName = "寂静时分-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c11m3_garage")
	{
		GetMapName = "寂静时分-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c11m4_terminal")
	{
		GetMapName = "寂静时分-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c11m5_runway")
	{
		GetMapName = "寂静时分-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c12m1_hilltop")
	{
		GetMapName = "血腥收获-第1站";
		Checkpoint = 5;
	}
	else if(Map == "c12m2_traintunnel")
	{
		GetMapName = "血腥收获-第2站";
		Checkpoint = 5;
	}
	else if(Map == "c12m3_bridge")
	{
		GetMapName = "血腥收获-第3站";
		Checkpoint = 5;
	}
	else if(Map == "c12m4_barn")
	{
		GetMapName = "血腥收获-第4站";
		Checkpoint = 5;
	}
	else if(Map == "c12m5_cornfield")
	{
		GetMapName = "血腥收获-终点站";
		Checkpoint = 5;
	}
	else if(Map == "c13m1_alpinecreek")
	{
		GetMapName = "刺骨寒溪-第1站";
		Checkpoint = 4;
	}
	else if(Map == "c13m2_southpinestream")
	{
		GetMapName = "刺骨寒溪-第2站";
		Checkpoint = 4;
	}
	else if(Map == "c13m3_memorialbridge")
	{
		GetMapName = "刺骨寒溪-第3站";
		Checkpoint = 4;
	}
	else if(Map == "c13m4_cutthroatcreek")
	{
		GetMapName = "刺骨寒溪-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_mic2_trapmentd")
	{
		GetMapName = "军事兵工厂-第1站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic2_decentd")
	{
		GetMapName = "军事兵工厂-第2站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic2_bunker_part1")
	{
		GetMapName = "军事兵工厂-第3站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic2_bunker_part2")
	{
		GetMapName = "军事兵工厂-第4站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic_bunker_top")
	{
		GetMapName = "军事兵工厂-第5站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic_bunker_bottom")
	{
		GetMapName = "军事兵工厂-第6站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic_escape")
	{
		GetMapName = "军事兵工厂-第7站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_mic_finale")
	{
		GetMapName = "军事兵工厂-终点站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_tbm_1")
	{
		GetMapName = "血腥荒野-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_tbm_2")
	{
		GetMapName = "血腥荒野-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_tbm_3")
	{
		GetMapName = "血腥荒野-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_tbm_4")
	{
		GetMapName = "血腥荒野-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_tbm_5")
	{
		GetMapName = "血腥荒野-终点站";
		Checkpoint = 5;
	}
	else if(Map == "srocchurch")
	{
		GetMapName = "巴塞罗那-第1站";
		Checkpoint = 4;
	}
	else if(Map == "plaza_espana")
	{
		GetMapName = "巴塞罗那-第2站";
		Checkpoint = 4;
	}
	else if(Map == "maria_cristina")
	{
		GetMapName = "巴塞罗那-第3站";
		Checkpoint = 4;
	}
	else if(Map == "mnac")
	{
		GetMapName = "巴塞罗那-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_deathwoods01_stranded")
	{
		GetMapName = "死亡森林-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathwoods02_tunnel")
	{
		GetMapName = "死亡森林-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathwoods03_bridge")
	{
		GetMapName = "死亡森林-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathwoods04_power")
	{
		GetMapName = "死亡森林-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathwoods05_airfield")
	{
		GetMapName = "死亡森林-终点站";
		Checkpoint = 5;
	}
	else if(Map == "hotel01_market1")
	{
		GetMapName = "死亡度假Ⅱ-第1站";
		Checkpoint = 5;
	}
	else if(Map == "hotel02_sewer1")
	{
		GetMapName = "死亡度假Ⅱ-第2站";
		Checkpoint = 5;
	}
	else if(Map == "hotel03_ramsey1")
	{
		GetMapName = "死亡度假Ⅱ-第3站";
		Checkpoint = 5;
	}
	else if(Map == "hotel04_scaling1")
	{
		GetMapName = "死亡度假Ⅱ-第4站";
		Checkpoint = 5;
	}
	else if(Map == "hotel05_rooftop1")
	{
		GetMapName = "死亡度假Ⅱ-终点站";
		Checkpoint = 5;
	}
	else if(Map == "tunel")
	{
		GetMapName = "死亡丧钟启示录-第1站";
		Checkpoint = 5;
	}
	else if(Map == "rury")
	{
		GetMapName = "死亡丧钟启示录-第2站";
		Checkpoint = 5;
	}
	else if(Map == "cmentarz")
	{
		GetMapName = "死亡丧钟启示录-第3站";
		Checkpoint = 5;
	}
	else if(Map == "miasto")
	{
		GetMapName = "死亡丧钟启示录-第4站";
		Checkpoint = 5;
	}
	else if(Map == "domki")
	{
		GetMapName = "死亡丧钟启示录-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_coaldblood01")
	{
		GetMapName = "逃离外太空-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_coaldblood02")
	{
		GetMapName = "逃离外太空-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_coaldblood03")
	{
		GetMapName = "逃离外太空-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_coaldblood04")
	{
		GetMapName = "逃离外太空-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_coaldblood05")
	{
		GetMapName = "逃离外太空-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_coaldblood06")
	{
		GetMapName = "逃离外太空-终点站";
		Checkpoint = 6;
	}
	else if(Map == "hf01_theforest")
	{
		GetMapName = "颤栗森林-第1站";
		Checkpoint = 4;
	}
	else if(Map == "hf02_thesteeple")
	{
		GetMapName = "颤栗森林-第2站";
		Checkpoint = 4;
	}
	else if(Map == "hf03_themansion")
	{
		GetMapName = "颤栗森林-第3站";
		Checkpoint = 4;
	}
	else if(Map == "hf04_escape")
	{
		GetMapName = "颤栗森林-终点站";
		Checkpoint = 4;
	}
	else if(Map == "ulice")
	{
		GetMapName = "毫不留情启示录-第1站";
		Checkpoint = 5;
	}
	else if(Map == "metro")
	{
		GetMapName = "毫不留情启示录-第2站";
		Checkpoint = 5;
	}
	else if(Map == "stacja")
	{
		GetMapName = "毫不留情启示录-第3站";
		Checkpoint = 5;
	}
	else if(Map == "szpital")
	{
		GetMapName = "毫不留情启示录-第4站";
		Checkpoint = 5;
	}
	else if(Map == "dach")
	{
		GetMapName = "毫不留情启示录-终点站";
		Checkpoint = 5;
	}
	else if(Map == "route_to_city")
	{
		GetMapName = "死亡狂奔-第1站";
		Checkpoint = 4;
	}
	else if(Map == "the_city")
	{
		GetMapName = "死亡狂奔-第2站";
		Checkpoint = 4;
	}
	else if(Map == "Prison")
	{
		GetMapName = "死亡狂奔-第3站";
		Checkpoint = 4;
	}
	else if(Map == "trainstation")
	{
		GetMapName = "死亡狂奔-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_co_canal")
	{
		GetMapName = "跨越-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_co_church")
	{
		GetMapName = "跨越-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_co_school")
	{
		GetMapName = "跨越-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_co_granary")
	{
		GetMapName = "跨越-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_co_bridge")
	{
		GetMapName = "跨越-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_planb1_v051")
	{
		GetMapName = "B计划-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_planb2_v051")
	{
		GetMapName = "B计划-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_planb3_v051")
	{
		GetMapName = "B计划-终点站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_dbd2dc_anna_is_gone")
	{
		GetMapName = "活死人黎明-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_dbd2dc_the_mall")
	{
		GetMapName = "活死人黎明-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_dbd2dc_clean_up")
	{
		GetMapName = "活死人黎明-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_dbd2dc_undead_center")
	{
		GetMapName = "活死人黎明-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_dbd2dc_new_dawn")
	{
		GetMapName = "活死人黎明-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_downtowndine01")
	{
		GetMapName = "停车加油-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_downtowndine02")
	{
		GetMapName = "停车加油-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_downtowndine03")
	{
		GetMapName = "停车加油-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_downtowndine04")
	{
		GetMapName = "停车加油-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_downtowndine05")
	{
		GetMapName = "停车加油-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ravenholmwar_1")
	{
		GetMapName = "我们不去莱温霍姆-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_ravenholmwar_2")
	{
		GetMapName = "我们不去莱温霍姆-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_ravenholmwar_3")
	{
		GetMapName = "我们不去莱温霍姆-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_ravenholmwar_4")
	{
		GetMapName = "我们不去莱温霍姆-终点站";
		Checkpoint = 4;
	}
	else if(Map == "uf1_boulevard")
	{
		GetMapName = "城市航班-第1站";
		Checkpoint = 4;
	}
	else if(Map == "uf2_rooftops")
	{
		GetMapName = "城市航班-第2站";
		Checkpoint = 4;
	}
	else if(Map == "uf3_harbor")
	{
		GetMapName = "城市航班-第3站";
		Checkpoint = 4;
	}
	else if(Map == "uf4_airfield")
	{
		GetMapName = "城市航班-终点站";
		Checkpoint = 4;
	}
	else if(Map == "saltwell_1_d")
	{
		GetMapName = "盐井地狱公园-第1站";
		Checkpoint = 5;
	}
	else if(Map == "saltwell_2_d")
	{
		GetMapName = "盐井地狱公园-第2站";
		Checkpoint = 5;
	}
	else if(Map == "saltwell_3_d")
	{
		GetMapName = "盐井地狱公园-第3站";
		Checkpoint = 5;
	}
	else if(Map == "saltwell_4_d")
	{
		GetMapName = "盐井地狱公园-第4站";
		Checkpoint = 5;
	}
	else if(Map == "saltwell_5_d")
	{
		GetMapName = "盐井地狱公园-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ihm01_forest")
	{
		GetMapName = "我恨大山II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ihm02_manor")
	{
		GetMapName = "我恨大山II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ihm03_underground")
	{
		GetMapName = "我恨大山II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ihm04_lumberyard")
	{
		GetMapName = "我恨大山II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ihm05_lakeside")
	{
		GetMapName = "我恨大山II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "eu01_residential_b16")
	{
		GetMapName = "恐怖之旅-第1站";
		Checkpoint = 5;
	}
	else if(Map == "eu02_castle_b16")
	{
		GetMapName = "恐怖之旅-第2站";
		Checkpoint = 5;
	}
	else if(Map == "eu03_oldtown_b16")
	{
		GetMapName = "恐怖之旅-第3站";
		Checkpoint = 5;
	}
	else if(Map == "eu04_freeway_b16")
	{
		GetMapName = "恐怖之旅-第4站";
		Checkpoint = 5;
	}
	else if(Map == "eu05_train_b16")
	{
		GetMapName = "恐怖之旅-终点站";
		Checkpoint = 5;
	}
	else if(Map == "nt01_mansion")
	{
		GetMapName = "惊夜2013-第1站";
		Checkpoint = 5;
	}
	else if(Map == "nt02_haunts")
	{
		GetMapName = "惊夜2013-第2站";
		Checkpoint = 5;
	}
	else if(Map == "nt03_moria")
	{
		GetMapName = "惊夜2013-第3站";
		Checkpoint = 5;
	}
	else if(Map == "nt04_jungleruins")
	{
		GetMapName = "惊夜2013-第4站";
		Checkpoint = 5;
	}
	else if(Map == "nt05_wake")
	{
		GetMapName = "惊夜2013-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_sh01_oldsh")
	{
		GetMapName = "寂静岭II-第1站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh02_school")
	{
		GetMapName = "寂静岭II-第2站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh03_schoolalt")
	{
		GetMapName = "寂静岭II-第3站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh04_church")
	{
		GetMapName = "寂静岭II-第4站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh05_hospital")
	{
		GetMapName = "寂静岭II-第5站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh06_hospitalalt")
	{
		GetMapName = "寂静岭II-第6站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh07_otherchurch")
	{
		GetMapName = "寂静岭II-第7站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh08_sewres")
	{
		GetMapName = "寂静岭II-第8站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh09_resort")
	{
		GetMapName = "寂静岭II-第9站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh10_amusementpark")
	{
		GetMapName = "寂静岭II-第10站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh11_nowhere")
	{
		GetMapName = "寂静岭II-第11站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh12_theend")
	{
		GetMapName = "寂静岭II-第12站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh_theend2")
	{
		GetMapName = "寂静岭II-第13站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh_theend3")
	{
		GetMapName = "寂静岭II-第14站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh_theend4")
	{
		GetMapName = "寂静岭II-第15站";
		Checkpoint = 16;
	}
	else if(Map == "l4d_sh_credits")
	{
		GetMapName = "寂静岭II-终点站";
		Checkpoint = 16;
	}
	else if(Map == "l4d2_bts01_forest")
	{
		GetMapName = "回到学校-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_bts02_station")
	{
		GetMapName = "回到学校-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_bts03_town")
	{
		GetMapName = "回到学校-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_bts04_cinema")
	{
		GetMapName = "回到学校-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_bts05_church")
	{
		GetMapName = "回到学校-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_bts06_school")
	{
		GetMapName = "回到学校-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds1")
	{
		GetMapName = "地狱风暴-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds2")
	{
		GetMapName = "地狱风暴-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds3")
	{
		GetMapName = "地狱风暴-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds4")
	{
		GetMapName = "地狱风暴-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds5")
	{
		GetMapName = "地狱风暴-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_vs_ds6")
	{
		GetMapName = "地狱风暴-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_grave_city")
	{
		GetMapName = "死亡军团II-第1站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_mall_beta")
	{
		GetMapName = "死亡军团II-第2站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_sewers_beta")
	{
		GetMapName = "死亡军团II-第3站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_factory_beta")
	{
		GetMapName = "死亡军团II-第4站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_outside_beta")
	{
		GetMapName = "死亡军团II-第5站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_rural")
	{
		GetMapName = "死亡军团II-第6站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_prison")
	{
		GetMapName = "死亡军团II-第7站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_grave_station")
	{
		GetMapName = "死亡军团II-终点站";
		Checkpoint = 8;
	}
	else if(Map == "nem_1_uptown")
	{
		GetMapName = "复仇女神-第1站";
		Checkpoint = 8;
	}
	else if(Map == "nem_2_rpd")
	{
		GetMapName = "复仇女神-第2站";
		Checkpoint = 8;
	}
	else if(Map == "nem_3_downtown")
	{
		GetMapName = "复仇女神-第3站";
		Checkpoint = 8;
	}
	else if(Map == "nem_4_clocktower")
	{
		GetMapName = "复仇女神-第4站";
		Checkpoint = 8;
	}
	else if(Map == "nem_5_hospital")
	{
		GetMapName = "复仇女神-第5站";
		Checkpoint = 8;
	}
	else if(Map == "nem_6_park")
	{
		GetMapName = "复仇女神-第6站";
		Checkpoint = 8;
	}
	else if(Map == "nem_7_factory")
	{
		GetMapName = "复仇女神-第7站";
		Checkpoint = 8;
	}
	else if(Map == "nem_8_finale")
	{
		GetMapName = "复仇女神-终点站";
		Checkpoint = 8;
	}
	else if(Map == "hellishjourney01")
	{
		GetMapName = "地狱之旅-第1站";
		Checkpoint = 4;
	}
	else if(Map == "hellishjourney02")
	{
		GetMapName = "地狱之旅-第2站";
		Checkpoint = 4;
	}
	else if(Map == "hellishjourney03")
	{
		GetMapName = "地狱之旅-第3站";
		Checkpoint = 4;
	}
	else if(Map == "hellishjourney04")
	{
		GetMapName = "地狱之旅-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_noway_out_town")
	{
		GetMapName = "没有出路II-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_noway_out_labyrinth")
	{
		GetMapName = "没有出路II-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_noway_out3")
	{
		GetMapName = "没有出路II-终点站";
		Checkpoint = 3;
	}
	else if(Map == "Las")
	{
		GetMapName = "血腥森林启示录-第1站";
		Checkpoint = 6;
	}
	else if(Map == "Magazyn")
	{
		GetMapName = "血腥森林启示录-第2站";
		Checkpoint = 6;
	}
	else if(Map == "Most")
	{
		GetMapName = "血腥森林启示录-第3站";
		Checkpoint = 6;
	}
	else if(Map == "Farma")
	{
		GetMapName = "血腥森林启示录-第4站";
		Checkpoint = 6;
	}
	else if(Map == "Tunele")
	{
		GetMapName = "血腥森林启示录-第5站";
		Checkpoint = 6;
	}
	else if(Map == "Lotnisko")
	{
		GetMapName = "血腥森林启示录-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_city17_01")
	{
		GetMapName = "城市17-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_city17_02")
	{
		GetMapName = "城市17-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_city17_03")
	{
		GetMapName = "城市17-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_city17_04")
	{
		GetMapName = "城市17-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_city17_05")
	{
		GetMapName = "城市17-终点站";
		Checkpoint = 5;
	}
	else if(Map == "oot_forest")
	{
		GetMapName = "哥奇利森林-第1站";
		Checkpoint = 3;
	}
	else if(Map == "oot_temple")
	{
		GetMapName = "哥奇利森林-第2站";
		Checkpoint = 3;
	}
	else if(Map == "oot_boss")
	{
		GetMapName = "哥奇利森林-终点站";
		Checkpoint = 3;
	}
	else if(Map == "kf01_ultra_massacre")
	{
		GetMapName = "超级屠杀";
	}
	else if(Map == "l4d2_tank_challenge")
	{
		GetMapName = "坦克挑战赛-总十场";
		Checkpoint = 1;
	}
	else if(Map == "l4d2_tank_challenge_inf")
	{
		GetMapName = "坦克挑战赛-总三十场";
		Checkpoint = 1;
	}
	else if(Map == "gridlockfinal2")
	{
		GetMapName = "交通大拥堵";
		Checkpoint = 1;
	}
	else if(Map == "p84m1_crash")
	{
		GetMapName = "84警区-第1站";
		Checkpoint = 4;
	}
	else if(Map == "p84m2_train")
	{
		GetMapName = "84警区-第2站";
		Checkpoint = 4;
	}
	else if(Map == "p84m3_clubd")
	{
		GetMapName = "84警区-第3站";
		Checkpoint = 4;
	}
	else if(Map == "p84m4_precinct")
	{
		GetMapName = "84警区-终点站";
		Checkpoint = 4;
	}
	else if(Map == "ddg1_tower_v2_1")
	{
		GetMapName = "暴毙峡谷-第1站";
		Checkpoint = 3;
	}
	else if(Map == "ddg2_gristmill_v2")
	{
		GetMapName = "暴毙峡谷-第2站";
		Checkpoint = 3;
	}
	else if(Map == "ddg3_bluff_v2_1")
	{
		GetMapName = "暴毙峡谷-终点站";
		Checkpoint = 3;
	}
	else if(Map == "Dead_Series1")
	{
		GetMapName = "连续死亡-第1站";
		Checkpoint = 4;
	}
	else if(Map == "Dead_Series2")
	{
		GetMapName = "连续死亡-第2站";
		Checkpoint = 4;
	}
	else if(Map == "Dead_Series3")
	{
		GetMapName = "连续死亡-第3站";
		Checkpoint = 4;
	}
	else if(Map == "Dead_Series4")
	{
		GetMapName = "连续死亡-终点站";
		Checkpoint = 4;
	}
	else if(Map == "highway01_apt_20130613")
	{
		GetMapName = "地狱之路-第1站";
		Checkpoint = 5;
	}
	else if(Map == "highway02_megamart_20130613")
	{
		GetMapName = "地狱之路-第2站";
		Checkpoint = 5;
	}
	else if(Map == "highway03_hood01_20130614")
	{
		GetMapName = "地狱之路-第3站";
		Checkpoint = 5;
	}
	else if(Map == "highway04_afb_a_02_20130616")
	{
		GetMapName = "地狱之路-第4站";
		Checkpoint = 5;
	}
	else if(Map == "highway05_afb02_20130820")
	{
		GetMapName = "地狱之路-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_tanksplayground")
	{
		GetMapName = "坦克竞技场";
	}
	else if(Map == "l4d_lambda_01")
	{
		GetMapName = "半条命II-第1站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_02")
	{
		GetMapName = "半条命II-第2站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_03")
	{
		GetMapName = "半条命II-第3站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_04")
	{
		GetMapName = "半条命II-第4站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_05")
	{
		GetMapName = "半条命II-第5站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_06")
	{
		GetMapName = "半条命II-第6站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_07")
	{
		GetMapName = "半条命II-第7站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_08")
	{
		GetMapName = "半条命II-第8站";
		Checkpoint = 9;
	}
	else if(Map == "l4d_lambda_09")
	{
		GetMapName = "半条命II-终点站";
		Checkpoint = 9;
	}
	else if(Map == "l4d2_canals_01")
	{
		GetMapName = "运河航道-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_canals_02")
	{
		GetMapName = "运河航道-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_canals_03")
	{
		GetMapName = "运河航道-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_canals_04")
	{
		GetMapName = "运河航道-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_canals_05")
	{
		GetMapName = "运河航道-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_canals_06")
	{
		GetMapName = "运河航道-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_ic_2_1")
	{
		GetMapName = "感染之城-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ic2_2")
	{
		GetMapName = "感染之城-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ic2_3")
	{
		GetMapName = "感染之城-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ic2_4")
	{
		GetMapName = "感染之城-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ic2_5")
	{
		GetMapName = "感染之城-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_tank_arena")
	{
		GetMapName = "灰色坦克竞技场";
	}
	else if(Map == "dprm1_milltown_a")
	{
		GetMapName = "暴风改版-第1站";
		Checkpoint = 5;
	}
	else if(Map == "dprm2_sugarmill_a")
	{
		GetMapName = "暴风改版-第2站";
		Checkpoint = 5;
	}
	else if(Map == "dprm3_sugarmill_b")
	{
		GetMapName = "暴风改版-第3站";
		Checkpoint = 5;
	}
	else if(Map == "dprm4_milltown_b")
	{
		GetMapName = "暴风改版-第4站";
		Checkpoint = 5;
	}
	else if(Map == "dprm5_milltown_escape")
	{
		GetMapName = "暴风改版-终点站";
		Checkpoint = 5;
	}
	else if(Map == "Bus_Depot")
	{
		GetMapName = "至死方休II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "OutSkirt")
	{
		GetMapName = "至死方休II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "TheBackStreets")
	{
		GetMapName = "至死方休II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "graveyard")
	{
		GetMapName = "至死方休II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "EngineRoom")
	{
		GetMapName = "至死方休II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_cine")
	{
		GetMapName = "玛雅遗址-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_nighclub")
	{
		GetMapName = "玛雅遗址-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_iglesia")
	{
		GetMapName = "玛雅遗址-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_ruinas")
	{
		GetMapName = "玛雅遗址-终点站";
		Checkpoint = 4;
	}
	else if(Map == "lost01_club")
	{
		GetMapName = "迷失II-第1站";
		Checkpoint = 6;
	}
	else if(Map == "lost02_")
	{
		GetMapName = "迷失-第2站";
		Checkpoint = 6;
	}
	else if(Map == "lost03")
	{
		GetMapName = "迷失-第3站";
		Checkpoint = 6;
	}
	else if(Map == "lost04")
	{
		GetMapName = "迷失-第4站";
		Checkpoint = 6;
	}
	else if(Map == "lost02_1")
	{
		GetMapName = "迷失II-第5站";
		Checkpoint = 6;
	}
	else if(Map == "lost02_2")
	{
		GetMapName = "迷失II-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_deadgetaway01_dam")
	{
		GetMapName = "死亡逃脱-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deadgetaway02_zone")
	{
		GetMapName = "死亡逃脱-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deadgetaway03_lab")
	{
		GetMapName = "死亡逃脱-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deadgetway04_tunnel")
	{
		GetMapName = "死亡逃脱-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deadgetaway_final")
	{
		GetMapName = "死亡逃脱-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_149_1")
	{
		GetMapName = "古墓亡影-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_149_2")
	{
		GetMapName = "古墓亡影-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_149_3")
	{
		GetMapName = "古墓亡影-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_149_4")
	{
		GetMapName = "古墓亡影-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_149_5")
	{
		GetMapName = "古墓亡影-终点站";
		Checkpoint = 5;
	}
	else if(Map == "sa_01")
	{
		GetMapName = "另一边生活-第1站";
		Checkpoint = 7;
	}
	else if(Map == "sa_02")
	{
		GetMapName = "另一边生活-第2站";
		Checkpoint = 7;
	}
	else if(Map == "sa_03")
	{
		GetMapName = "另一边生活-第3站";
		Checkpoint = 7;
	}
	else if(Map == "sa_04")
	{
		GetMapName = "另一边生活-第4站";
		Checkpoint = 7;
	}
	else if(Map == "sa_05")
	{
		GetMapName = "另一边生活-第5站";
		Checkpoint = 7;
	}
	else if(Map == "sa_06")
	{
		GetMapName = "另一边生活-第6站";
		Checkpoint = 7;
	}
	else if(Map == "sa_07")
	{
		GetMapName = "另一边生活-终点站";
		Checkpoint = 7;
	}
	else if(Map == "l4d_greyscale_01_street")
	{
		GetMapName = "灰色战役-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_greyscale_02_factory")
	{
		GetMapName = "灰色战役-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_greyscale_03_descent")
	{
		GetMapName = "灰色战役-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_greyscale_04_rooftop")
	{
		GetMapName = "灰色战役-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_without_complex")
	{
		GetMapName = "无名丧尸电影-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_without_lake")
	{
		GetMapName = "无名丧尸电影-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_without_town")
	{
		GetMapName = "无名丧尸电影-终点站";
		Checkpoint = 3;
	}
	else if(Map == "x1m1_cliffs")
	{
		GetMapName = "绝命公路-第1站";
		Checkpoint = 5;
	}
	else if(Map == "x1m2_path")
	{
		GetMapName = "绝命公路-第2站";
		Checkpoint = 5;
	}
	else if(Map == "x1m3_city")
	{
		GetMapName = "绝命公路-第3站";
		Checkpoint = 5;
	}
	else if(Map == "x1m4_forest")
	{
		GetMapName = "绝命公路-第4站";
		Checkpoint = 5;
	}
	else if(Map == "x1m5_salvation")
	{
		GetMapName = "绝命公路-终点站";
		Checkpoint = 5;
	}
	else if(Map == "left4bowl_depot")
	{
		GetMapName = "逃离保龄球馆-第1站";
		Checkpoint = 3;
	}
	else if(Map == "left4bowl_the_dude")
	{
		GetMapName = "逃离保龄球馆-第2站";
		Checkpoint = 3;
	}
	else if(Map == "left4bowl_escape")
	{
		GetMapName = "逃离保龄球馆-终点站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_almacen001_almacen")
	{
		GetMapName = "工业区II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_almacen002_camino")
	{
		GetMapName = "工业区II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_almacen003_waterworks")
	{
		GetMapName = "工业区II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_almacen004_arboles")
	{
		GetMapName = "工业区II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_almacen005_fabrica")
	{
		GetMapName = "工业区II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4dblackoutbasement1")
	{
		GetMapName = "停电地下室-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4dblackoutbasement2")
	{
		GetMapName = "停电地下室-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4dblackoutbasement3")
	{
		GetMapName = "停电地下室-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4dblackoutbasement4")
	{
		GetMapName = "停电地下室-终点站";
		Checkpoint = 4;
	}
	else if(Map == "jsarena201_town")
	{
		GetMapName = "死亡舞台II-第1站";
		Checkpoint = 4;
	}
	else if(Map == "jsarena202_alley")
	{
		GetMapName = "死亡舞台II-第2站";
		Checkpoint = 4;
	}
	else if(Map == "jsarena203_roof")
	{
		GetMapName = "死亡舞台II-第3站";
		Checkpoint = 4;
	}
	else if(Map == "jsarena204_arena")
	{
		GetMapName = "死亡舞台II-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_ff01_woods")
	{
		GetMapName = "致命货运站-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ff02_factory")
	{
		GetMapName = "致命货运站-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ff03_highway")
	{
		GetMapName = "致命货运站-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ff04_plant")
	{
		GetMapName = "致命货运站-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_ff05_station")
	{
		GetMapName = "致命货运站-终点站";
		Checkpoint = 5;
	}
	else if(Map == "the_hive_m1")
	{
		GetMapName = "蜂巢-第1站";
		Checkpoint = 5;
	}
	else if(Map == "the_hive_m2")
	{
		GetMapName = "蜂巢-第2站";
		Checkpoint = 5;
	}
	else if(Map == "the_hive_m3")
	{
		GetMapName = "蜂巢-第3站";
		Checkpoint = 5;
	}
	else if(Map == "the_hive_m4")
	{
		GetMapName = "蜂巢-第4站";
		Checkpoint = 5;
	}
	else if(Map == "the_hive_m5")
	{
		GetMapName = "蜂巢-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_win1")
	{
		GetMapName = "冰与火-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_win2")
	{
		GetMapName = "冰与火-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_win3")
	{
		GetMapName = "冰与火-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_win4")
	{
		GetMapName = "冰与火-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_win5")
	{
		GetMapName = "冰与火-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_win6")
	{
		GetMapName = "冰与火-终点站";
		Checkpoint = 6;
	}
	else if(Map == "splash1")
	{
		GetMapName = "飞溅山之旅-第1站";
		Checkpoint = 5;
	}
	else if(Map == "splash2")
	{
		GetMapName = "飞溅山之旅-第2站";
		Checkpoint = 5;
	}
	else if(Map == "splash3")
	{
		GetMapName = "飞溅山之旅-第3站";
		Checkpoint = 5;
	}
	else if(Map == "splash4")
	{
		GetMapName = "飞溅山之旅-第4站";
		Checkpoint = 5;
	}
	else if(Map == "splash5")
	{
		GetMapName = "飞溅山之旅-终点站";
		Checkpoint = 5;
	}
	else if(Map == "claustrophobia1")
	{
		GetMapName = "下水道-第1站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia2")
	{
		GetMapName = "下水道-第2站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia3")
	{
		GetMapName = "下水道-第3站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia4")
	{
		GetMapName = "下水道-第4站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia5")
	{
		GetMapName = "下水道-第5站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia6")
	{
		GetMapName = "下水道-第6站";
		Checkpoint = 7;
	}
	else if(Map == "claustrophobia7")
	{
		GetMapName = "下水道-终点站";
		Checkpoint = 7;
	}
	else if(Map == "2019ii_dc_plazamerge")
	{
		GetMapName = "广场合并-第1站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_streets")
	{
		GetMapName = "广场合并-第2站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_breakdown")
	{
		GetMapName = "广场合并-第3站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_outside")
	{
		GetMapName = "广场合并-第4站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_getup")
	{
		GetMapName = "广场合并-第5站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_altbunk")
	{
		GetMapName = "广场合并-第6站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_bunker")
	{
		GetMapName = "广场合并-第7站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_bunker3")
	{
		GetMapName = "广场合并-第8站";
		Checkpoint = 8;
	}
	else if(Map == "2019ii_dc_altbunk2")
	{
		GetMapName = "广场合并-终点站";
		Checkpoint = 8;
	}
	else if(Map == "hg_boss_sawrunner")
	{
		GetMapName = "挥之不去的理由";
		Checkpoint = 1;
	}
	else if(Map == "unsdwn_mp_1")
	{
		GetMapName = "丧尸侵袭-第1站";
		Checkpoint = 4;
	}
	else if(Map == "unsdwn_mp_2")
	{
		GetMapName = "丧尸侵袭-第2站";
		Checkpoint = 4;
	}
	else if(Map == "unsdwn_mp_3")
	{
		GetMapName = "丧尸侵袭-第3站";
		Checkpoint = 4;
	}
	else if(Map == "unsdwn_mp_4")
	{
		GetMapName = "丧尸侵袭-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_pdmesa01_surface")
	{
		GetMapName = "地下研究室-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_pdmesa02_shafted")
	{
		GetMapName = "地下研究室-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_pdmesa03_office")
	{
		GetMapName = "地下研究室-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_pdmesa04_pointinsert")
	{
		GetMapName = "地下研究室-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_pdmesa05_returntoxen")
	{
		GetMapName = "地下研究室-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_pdmesa06_xen")
	{
		GetMapName = "地下研究室-终点站";
		Checkpoint = 6;
	}
	else if(Map == "lost01_club")
	{
		GetMapName = "迷失-第1站";
		Checkpoint = 6;
	}
	else if(Map == "lost02_")
	{
		GetMapName = "迷失-第2站";
		Checkpoint = 6;
	}
	else if(Map == "lost03")
	{
		GetMapName = "迷失-第3站";
		Checkpoint = 6;
	}
	else if(Map == "lost04")
	{
		GetMapName = "迷失-第4站";
	}
	else if(Map == "lost02_1")
	{
		GetMapName = "迷失-第5站";
		Checkpoint = 6;
	}
	else if(Map == "lost02_2")
	{
		GetMapName = "迷失-终点站";
		Checkpoint = 6;
	}
	else if(Map == "hkboxtest")
	{
		GetMapName = "香港-第1站";
		Checkpoint = 3;
	}
	else if(Map == "hkboxtest2")
	{
		GetMapName = "香港-第2站";
		Checkpoint = 3;
	}
	else if(Map == "hkboxtest3")
	{
		GetMapName = "香港-终点站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_stadium1_apartment")
	{
		GetMapName = "闪电突袭II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_stadium2_riverwalk")
	{
		GetMapName = "闪电突袭II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_stadium3_city1")
	{
		GetMapName = "闪电突袭II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_stadium4_city2")
	{
		GetMapName = "闪电突袭II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_stadium5_stadium")
	{
		GetMapName = "闪电突袭II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "dm1_suburbs")
	{
		GetMapName = "恶魔山区-第1站";
		Checkpoint = 5;
	}
	else if(Map == "dm2_blastzone")
	{
		GetMapName = "恶魔山区-第2站";
		Checkpoint = 5;
	}
	else if(Map == "dm3_canyon")
	{
		GetMapName = "恶魔山区-第3站";
		Checkpoint = 5;
	}
	else if(Map == "dm4_caves")
	{
		GetMapName = "恶魔山区-第4站";
		Checkpoint = 5;
	}
	else if(Map == "dm5_summit")
	{
		GetMapName = "恶魔山区-终点站";
		Checkpoint = 5;
	}
	else if(Map == "de01_sewers")
	{
		GetMapName = "死亡回声II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "de02_hotel")
	{
		GetMapName = "死亡回声II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "de03_store")
	{
		GetMapName = "死亡回声II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "de04_woods")
	{
		GetMapName = "死亡回声II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "de05_echo_finale")
	{
		GetMapName = "死亡回声II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deathaboard01_prison")
	{
		GetMapName = "幽灵船II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deathaboard02_yard")
	{
		GetMapName = "幽灵船II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deathaboard03_docks")
	{
		GetMapName = "幽灵船II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deathaboard04_ship")
	{
		GetMapName = "幽灵船II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_deathaboard05_light")
	{
		GetMapName = "幽灵船II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "reintro")
	{
		GetMapName = "生化爆发-第1站";
		Checkpoint = 8;
	}
	else if(Map == "re_outbreak")
	{
		GetMapName = "生化爆发-第2站";
		Checkpoint = 8;
	}
	else if(Map == "re_belowfreezingpoint")
	{
		GetMapName = "生化爆发-第3站";
		Checkpoint = 8;
	}
	else if(Map == "re_thehive")
	{
		GetMapName = "生化爆发-第4站";
		Checkpoint = 8;
	}
	else if(Map == "re_hellfire")
	{
		GetMapName = "生化爆发-第5站";
		Checkpoint = 8;
	}
	else if(Map == "re_decisions1")
	{
		GetMapName = "生化爆发-第6站";
		Checkpoint = 8;
	}
	else if(Map == "re_decisions2")
	{
		GetMapName = "生化爆发-第7站";
		Checkpoint = 8;
	}
	else if(Map == "re_decisionsfinale")
	{
		GetMapName = "生化爆发-终点站";
		Checkpoint = 8;
	}
	else if(Map == "qe2_ep1")
	{
		GetMapName = "阿尔法测试-第1站";
		Checkpoint = 5;
	}
	else if(Map == "qe2_ep2")
	{
		GetMapName = "阿尔法测试-第2站";
		Checkpoint = 5;
	}
	else if(Map == "qe2_ep3")
	{
		GetMapName = "阿尔法测试-第3站";
		Checkpoint = 5;
	}
	else if(Map == "qe2_ep4")
	{
		GetMapName = "阿尔法测试-第4站";
		Checkpoint = 5;
	}
	else if(Map == "qe2_ep5")
	{
		GetMapName = "阿尔法测试-终点站";
		Checkpoint = 5;
	}
	else if(Map == "qe_1_cliche")
	{
		GetMapName = "伦理问题-第1站";
		Checkpoint = 4;
	}
	else if(Map == "qe_2_remember_me")
	{
		GetMapName = "伦理问题-第2站";
		Checkpoint = 4;
	}
	else if(Map == "qe_3_unorthodox_paradox")
	{
		GetMapName = "伦理问题-第3站";
		Checkpoint = 4;
	}
	else if(Map == "qe_4_ultimate_test")
	{
		GetMapName = "伦理问题-终点站";
		Checkpoint = 4;
	}
	else if(Map == "cdta_01detour")
	{
		GetMapName = "勇往直前-第1站";
		Checkpoint = 5;
	}
	else if(Map == "cdta_02road")
	{
		GetMapName = "勇往直前-第2站";
		Checkpoint = 5;
	}
	else if(Map == "cdta_03warehouse")
	{
		GetMapName = "勇往直前-第3站";
		Checkpoint = 5;
	}
	else if(Map == "cdta_04onarail")
	{
		GetMapName = "勇往直前-第4站";
		Checkpoint = 5;
	}
	else if(Map == "cdta_05finalroad")
	{
		GetMapName = "勇往直前-终点站";
		Checkpoint = 5;
	}
	else if(Map == "bloodtracks_01")
	{
		GetMapName = "血腥轨道-第1站";
		Checkpoint = 4;
	}
	else if(Map == "bloodtracks_02")
	{
		GetMapName = "血腥轨道-第2站";
		Checkpoint = 4;
	}
	else if(Map == "bloodtracks_03")
	{
		GetMapName = "血腥轨道-第3站";
		Checkpoint = 4;
	}
	else if(Map == "bloodtracks_04")
	{
		GetMapName = "血腥轨道-终点站";
		Checkpoint = 4;
	}
	else if(Map == "redemptionII-deadstop")
	{
		GetMapName = "救赎II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "redemptionII-plantworks")
	{
		GetMapName = "救赎II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "redemptionII-ceda-pt1")
	{
		GetMapName = "救赎II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "redemptionii-ceda-pt2")
	{
		GetMapName = "救赎II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "roundhouse")
	{
		GetMapName = "救赎II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "damitdc1")
	{
		GetMapName = "大坝II-第1站";
		Checkpoint = 4;
	}
	else if(Map == "damitdc2")
	{
		GetMapName = "大坝II-第2站";
		Checkpoint = 4;
	}
	else if(Map == "damitdc3")
	{
		GetMapName = "大坝II-第3站";
		Checkpoint = 4;
	}
	else if(Map == "damitdc4")
	{
		GetMapName = "大坝II-终点站";
		Checkpoint = 4;
	}
	else if(Map == "DthMnt_Village")
	{
		GetMapName = "死亡山峰-第1站";
		Checkpoint = 6;
	}
	else if(Map == "DthMnt_Crater")
	{
		GetMapName = "死亡山峰-第2站";
		Checkpoint = 6;
	}
	else if(Map == "DthMnt_TempleForye")
	{
		GetMapName = "死亡山峰-第3站";
		Checkpoint = 6;
	}
	else if(Map == "DthMnt_Temple3rdFloor")
	{
		GetMapName = "死亡山峰-第4站";
		Checkpoint = 6;
	}
	else if(Map == "DthMnt_Temple4thFloor")
	{
		GetMapName = "死亡山峰-第5站";
		Checkpoint = 6;
	}
	else if(Map == "DthMnt_TempleBoss")
	{
		GetMapName = "死亡山峰-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_daybreak01_hotel")
	{
		GetMapName = "黎明-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_daybreak02_coastline")
	{
		GetMapName = "黎明-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_daybreak03_bridge")
	{
		GetMapName = "黎明-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_daybreak04_cruise")
	{
		GetMapName = "黎明-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_daybreak05_rescue")
	{
		GetMapName = "黎明-终点站";
		Checkpoint = 5;
	}
	else if(Map == "versus_1")
	{
		GetMapName = "消防塔-第1站";
		Checkpoint = 5;
	}
	else if(Map == "versus_2")
	{
		GetMapName = "消防塔-第2站";
		Checkpoint = 5;
	}
	else if(Map == "versus_3")
	{
		GetMapName = "消防塔-第3站";
		Checkpoint = 5;
	}
	else if(Map == "versus_4")
	{
		GetMapName = "消防塔-第4站";
		Checkpoint = 5;
	}
	else if(Map == "versus_5")
	{
		GetMapName = "消防塔-终点站";
		Checkpoint = 5;
	}
	else if(Map == "Heaven_1_AirCrash")
	{
		GetMapName = "天堂可待I-第1站";
		Checkpoint = 5;
	}
	else if(Map == "Heaven_2_RiverMotel")
	{
		GetMapName = "天堂可待I-第2站";
		Checkpoint = 5;
	}
	else if(Map == "Heaven_3_OutSkirts")
	{
		GetMapName = "天堂可待I-第3站";
		Checkpoint = 5;
	}
	else if(Map == "Heaven_4_CityHall")
	{
		GetMapName = "天堂可待I-第4站";
		Checkpoint = 5;
	}
	else if(Map == "Heaven_5_BombShelter")
	{
		GetMapName = "天堂可待I-终点站";
		Checkpoint = 5;
	}
	else if(Map == "AirCrash")
	{
		GetMapName = "天堂可待II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "RiverMotel")
	{
		GetMapName = "天堂可待II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "OutSkirts")
	{
		GetMapName = "天堂可待II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "CityHall")
	{
		GetMapName = "天堂可待II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "BombShelter")
	{
		GetMapName = "天堂可待II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "InnesRoadRash01")
	{
		GetMapName = "恩尼斯路-第1站";
		Checkpoint = 5;
	}
	else if(Map == "InnesRoadRash02")
	{
		GetMapName = "恩尼斯路-第2站";
		Checkpoint = 5;
	}
	else if(Map == "InnesRoadRash03")
	{
		GetMapName = "恩尼斯路-第3站";
		Checkpoint = 5;
	}
	else if(Map == "InnesRoadRash04")
	{
		GetMapName = "恩尼斯路-第4站";
		Checkpoint = 5;
	}
	else if(Map == "InnesRoadRash05")
	{
		GetMapName = "恩尼斯路-终点站";
		Checkpoint = 5;
	}
	else if(Map == "ec01_outlets")
	{
		GetMapName = "能源危机-第1站";
		Checkpoint = 5;
	}
	else if(Map == "ec02_dam")
	{
		GetMapName = "能源危机-第2站";
		Checkpoint = 5;
	}
	else if(Map == "ec03_village")
	{
		GetMapName = "能源危机-第3站";
		Checkpoint = 5;
	}
	else if(Map == "ec04_powerstation")
	{
		GetMapName = "能源危机-第4站";
		Checkpoint = 5;
	}
	else if(Map == "ec05_quarry")
	{
		GetMapName = "能源危机-终点站";
		Checkpoint = 5;
	}
	else if(Map == "grmap1")
	{
		GetMapName = "公路杀手-第1站";
		Checkpoint = 4;
	}
	else if(Map == "gridmap2")
	{
		GetMapName = "公路杀手-第2站";
		Checkpoint = 4;
	}
	else if(Map == "gridmap3")
	{
		GetMapName = "公路杀手-第3站";
		Checkpoint = 4;
	}
	else if(Map == "grid4")
	{
		GetMapName = "公路杀手-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_dbd2_citylights")
	{
		GetMapName = "在黎明前死去-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_dbd2_anna_is_gone")
	{
		GetMapName = "在黎明前死去-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_dbd2_the_mall")
	{
		GetMapName = "在黎明前死去-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_dbd2_clean_up")
	{
		GetMapName = "在黎明前死去-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_dbd2_new_dawn")
	{
		GetMapName = "在黎明前死去-终点站";
		Checkpoint = 5;
	}
	else if(Map == "Hideout01_v5etd")
	{
		GetMapName = "地狱-第1站";
		Checkpoint = 6;
	}
	else if(Map == "Hideout02etd")
	{
		GetMapName = "地狱-第2站";
		Checkpoint = 6;
	}
	else if(Map == "Hideout03etd")
	{
		GetMapName = "地狱-第3站";
		Checkpoint = 6;
	}
	else if(Map == "Hideout04_tlmetd")
	{
		GetMapName = "地狱-第4站";
		Checkpoint = 6;
	}
	else if(Map == "e4d_m1etd")
	{
		GetMapName = "地狱-第5站";
		Checkpoint = 6;
	}
	else if(Map == "house_1etd")
	{
		GetMapName = "地狱-终点站";
		Checkpoint = 6;
	}
	else if(Map == "gr-mapone-7")
	{
		GetMapName = "赶尽杀绝-第1站";
		Checkpoint = 4;
	}
	else if(Map == "gasrunpart2")
	{
		GetMapName = "赶尽杀绝-第2站";
		Checkpoint = 4;
	}
	else if(Map == "evac2")
	{
		GetMapName = "赶尽杀绝-第3站";
		Checkpoint = 4;
	}
	else if(Map == "gasrun")
	{
		GetMapName = "赶尽杀绝-终点站";
		Checkpoint = 4;
	}
	else if(Map == "citystreets1ewc")
	{
		GetMapName = "逃离魔鬼教堂-第1站";
		Checkpoint = 6;
	}
	else if(Map == "techbuildingewc")
	{
		GetMapName = "逃离魔鬼教堂-第2站";
		Checkpoint = 6;
	}
	else if(Map == "museumewc")
	{
		GetMapName = "逃离魔鬼教堂-第3站";
		Checkpoint = 6;
	}
	else if(Map == "dodsurvivalcoopewc")
	{
		GetMapName = "逃离魔鬼教堂-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_martial_lawewc")
	{
		GetMapName = "逃离魔鬼教堂-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_helicopterescapeewc")
	{
		GetMapName = "逃离魔鬼教堂-终点站";
		Checkpoint = 6;
	}
	else if(Map == "alejki")
	{
		GetMapName = "坠机险途启示录-第1站";
		Checkpoint = 3;
	}
	else if(Map == "baza")
	{
		GetMapName = "坠机险途启示录-第2站";
		Checkpoint = 3;
	}
	else if(Map == "baza2")
	{
		GetMapName = "坠机险途启示录-终点站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_deathtoll01_clam")
	{
		GetMapName = "死亡丧钟改版-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathtoll02_clam")
	{
		GetMapName = "死亡丧钟改版-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathtoll03_clam")
	{
		GetMapName = "死亡丧钟改版-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathtoll04_clam")
	{
		GetMapName = "死亡丧钟改版-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deathtoll05_clam")
	{
		GetMapName = "死亡丧钟改版-终点站";
		Checkpoint = 5;
	}
	else if(Map == "damshort170surv")
	{
		GetMapName = "金钱建造-第1站";
		Checkpoint = 3;
	}
	else if(Map == "gemarshy02fac")
	{
		GetMapName = "金钱建造-第2站";
		Checkpoint = 3;
	}
	else if(Map == "gemarshy03aztec")
	{
		GetMapName = "金钱建造-终点站";
		Checkpoint = 3;
	}
	else if(Map == "hotel01_market_two")
	{
		GetMapName = "死亡度假-第1站";
		Checkpoint = 5;
	}
	else if(Map == "hotel02_sewer_two")
	{
		GetMapName = "死亡度假-第2站";
		Checkpoint = 5;
	}
	else if(Map == "hotel03_ramsey_two")
	{
		GetMapName = "死亡度假-第3站";
		Checkpoint = 5;
	}
	else if(Map == "hotel04_scaling_two")
	{
		GetMapName = "死亡度假-第4站";
		Checkpoint = 5;
	}
	else if(Map == "hotel05_rooftop_two")
	{
		GetMapName = "死亡度假-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_base_east")
	{
		GetMapName = "恶臭熏天-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_base_south")
	{
		GetMapName = "恶臭熏天-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_base_hunter_inn")
	{
		GetMapName = "恶臭熏天-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_base_escape")
	{
		GetMapName = "恶臭熏天-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_camp_dead")
	{
		GetMapName = "死亡岛-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_deadzone")
	{
		GetMapName = "死亡岛-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_death_city")
	{
		GetMapName = "死亡岛-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_death_pit")
	{
		GetMapName = "死亡岛-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_death_pit_finale")
	{
		GetMapName = "死亡岛-终点站";
		Checkpoint = 5;
	}
	else if(Map == "silent_hillbc")
	{
		GetMapName = "黑色之城-第1站";
		Checkpoint = 5;
	}
	else if(Map == "silent_hill2bc")
	{
		GetMapName = "黑色之城-第2站";
		Checkpoint = 5;
	}
	else if(Map == "silent_hill3bc")
	{
		GetMapName = "黑色之城-第3站";
		Checkpoint = 5;
	}
	else if(Map == "silent_hill4bc")
	{
		GetMapName = "黑色之城-第4站";
		Checkpoint = 5;
	}
	else if(Map == "silent_hill5bc")
	{
		GetMapName = "黑色之城-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_auburn")
	{
		GetMapName = "奥本计划-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_2")
	{
		GetMapName = "奥本计划-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_3")
	{
		GetMapName = "奥本计划-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_finale")
	{
		GetMapName = "奥本计划-终点站";
		Checkpoint = 4;
	}
	else if(Map == "dw_woods")
	{
		GetMapName = "阴暗森林-第1站";
		Checkpoint = 5;
	}
	else if(Map == "dw_underground")
	{
		GetMapName = "阴暗森林-第2站";
		Checkpoint = 5;
	}
	else if(Map == "dw_complex")
	{
		GetMapName = "阴暗森林-第3站";
		Checkpoint = 5;
	}
	else if(Map == "dw_otherworld")
	{
		GetMapName = "阴暗森林-第4站";
		Checkpoint = 5;
	}
	else if(Map == "dw_final")
	{
		GetMapName = "阴暗森林-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_noe1")
	{
		GetMapName = "理性壁垒-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_noe2")
	{
		GetMapName = "理性壁垒-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_noe3")
	{
		GetMapName = "理性壁垒-终点站";
		Checkpoint = 3;
	}
	else if(Map == "hiking_trails")
	{
		GetMapName = "远足山路-第1站";
		Checkpoint = 4;
	}
	else if(Map == "camp_grounds")
	{
		GetMapName = "远足山路-第2站";
		Checkpoint = 4;
	}
	else if(Map == "plant")
	{
		GetMapName = "远足山路-第3站";
		Checkpoint = 4;
	}
	else if(Map == "the_end")
	{
		GetMapName = "远足山路-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_dm_01")
	{
		GetMapName = "死亡军团II-第1站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_02")
	{
		GetMapName = "死亡军团II-第2站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_03")
	{
		GetMapName = "死亡军团II-第3站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_04")
	{
		GetMapName = "死亡军团II-第4站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_05")
	{
		GetMapName = "死亡军团II-第5站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_06")
	{
		GetMapName = "死亡军团II-第6站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_07")
	{
		GetMapName = "死亡军团II-第7站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_dm_08")
	{
		GetMapName = "死亡军团II-终点站";
		Checkpoint = 8;
	}
	else if(Map == "frozen_m1_streets")
	{
		GetMapName = "复仇第2章-第1站";
		Checkpoint = 5;
	}
	else if(Map == "frozen_m2_school")
	{
		GetMapName = "复仇第2章-第2站";
		Checkpoint = 5;
	}
	else if(Map == "frozen_train")
	{
		GetMapName = "复仇第2章-第3站";
		Checkpoint = 5;
	}
	else if(Map == "frozen_factory_d")
	{
		GetMapName = "复仇第2章-第4站";
		Checkpoint = 5;
	}
	else if(Map == "frozen_mall")
	{
		GetMapName = "复仇第2章-终点站";
		Checkpoint = 5;
	}
	else if(Map == "neverendingwar_train")
	{
		GetMapName = "复仇第3章-第1站";
		Checkpoint = 5;
	}
	else if(Map == "neverendingwar_apartments")
	{
		GetMapName = "复仇第3章-第2站";
		Checkpoint = 5;
	}
	else if(Map == "neverendingwar_m2_gunshop")
	{
		GetMapName = "复仇第3章-第3站";
		Checkpoint = 5;
	}
	else if(Map == "neverendingwar_m3_prison_new")
	{
		GetMapName = "复仇第3章-第4站";
		Checkpoint = 5;
	}
	else if(Map == "neverendingwar_m4_storage_new")
	{
		GetMapName = "复仇第3章-终点站";
		Checkpoint = 5;
	}
	else if(Map == "kickedout_m1_subway")
	{
		GetMapName = "复仇第4章-第1站";
		Checkpoint = 2;
	}
	else if(Map == "kickedout_m2_pier")
	{
		GetMapName = "复仇第4章-终点站";
		Checkpoint = 2;
	}
	else if(Map == "lasthours_m1_alleys")
	{
		GetMapName = "复仇第5章-第1站";
		Checkpoint = 3;
	}
	else if(Map == "lasthours_m2_lab")
	{
		GetMapName = "复仇第5章-第2站";
		Checkpoint = 3;
	}
	else if(Map == "lasthours_m3_lot")
	{
		GetMapName = "复仇第5章-终点站";
		Checkpoint = 3;
	}
	else if(Map == "revenge_m1_office_new")
	{
		GetMapName = "复仇第6章-第1站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m1_rooftops")
	{
		GetMapName = "复仇第6章-第2站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m1_rooftops_rain")
	{
		GetMapName = "复仇第6章-第3站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m2_hospital")
	{
		GetMapName = "复仇第6章-第4站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m2_hospital_rain")
	{
		GetMapName = "复仇第6章-第5站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m3_canal")
	{
		GetMapName = "复仇第6章-第6站";
		Checkpoint = 7;
	}
	else if(Map == "revenge_m3b_under")
	{
		GetMapName = "复仇第6章-终点站";
		Checkpoint = 7;
	}
	else if(Map == "beldurra2_1")
	{
		GetMapName = "恐惧II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "beldurra2_2")
	{
		GetMapName = "恐惧II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "beldurra2_3")
	{
		GetMapName = "恐惧II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "beldurra2_4")
	{
		GetMapName = "恐惧II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "beldurra2_5")
	{
		GetMapName = "恐惧II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "gunk_misty")
	{
		GetMapName = "毒液-第1站";
		Checkpoint = 6;
	}
	else if(Map == "gunk_occupied")
	{
		GetMapName = "毒液-第2站";
		Checkpoint = 6;
	}
	else if(Map == "gunk_stinkin_thinkin")
	{
		GetMapName = "毒液-第3站";
		Checkpoint = 6;
	}
	else if(Map == "gunk_stinky_bombs")
	{
		GetMapName = "毒液-第4站";
		Checkpoint = 6;
	}
	else if(Map == "gunk_on_the_wagon")
	{
		GetMapName = "毒液-第5站";
		Checkpoint = 6;
	}
	else if(Map == "gunk_wicked_dead")
	{
		GetMapName = "毒液-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_zero01_base")
	{
		GetMapName = "新绝对零度-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_zero02_comp")
	{
		GetMapName = "新绝对零度-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_zero03_ruins")
	{
		GetMapName = "新绝对零度-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_zero04_outpost")
	{
		GetMapName = "新绝对零度-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_zero05_villa")
	{
		GetMapName = "新绝对零度-终点站";
		Checkpoint = 5;
	}
	else if(Map == "deathttoiletmaze1")
	{
		GetMapName = "死亡迷宫-第1站";
		Checkpoint = 5;
	}
	else if(Map == "deathttoiletmaze2")
	{
		GetMapName = "死亡迷宫-第2站";
		Checkpoint = 5;
	}
	else if(Map == "deathttoiletmaze3")
	{
		GetMapName = "死亡迷宫-第3站";
		Checkpoint = 5;
	}
	else if(Map == "deathttoiletmaze4")
	{
		GetMapName = "死亡迷宫-第4站";
		Checkpoint = 5;
	}
	else if(Map == "deathttoiletmaze5")
	{
		GetMapName = "死亡迷宫-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_naniwa01_shoppingmall")
	{
		GetMapName = "浪速都市II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_naniwa02_arcade")
	{
		GetMapName = "浪速都市II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_naniwa03_highway")
	{
		GetMapName = "浪速都市II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_naniwa04_subway")
	{
		GetMapName = "浪速都市II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_naniwa05_tower")
	{
		GetMapName = "浪速都市II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "re1m1")
	{
		GetMapName = "生化危机-第1站";
		Checkpoint = 6;
	}
	else if(Map == "re1m2")
	{
		GetMapName = "生化危机-第2站";
		Checkpoint = 6;
	}
	else if(Map == "re1m3")
	{
		GetMapName = "生化危机-第3站";
		Checkpoint = 6;
	}
	else if(Map == "re1m4")
	{
		GetMapName = "生化危机-第4站";
		Checkpoint = 6;
	}
	else if(Map == "re1m5")
	{
		GetMapName = "生化危机-第5站";
		Checkpoint = 6;
	}
	else if(Map == "re1m6")
	{
		GetMapName = "生化危机-终点站";
		Checkpoint = 6;
	}
	else if(Map == "re2a1")
	{
		GetMapName = "生化危机II-第1站";
		Checkpoint = 4;
	}
	else if(Map == "re2a2")
	{
		GetMapName = "生化危机II-第2站";
		Checkpoint = 4;
	}
	else if(Map == "re2a3")
	{
		GetMapName = "生化危机II-第3站";
		Checkpoint = 4;
	}
	else if(Map == "re2a4")
	{
		GetMapName = "生化危机II-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_brain4dead01_suburbs_b2")
	{
		GetMapName = "太平间-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_brain4dead02_pool_b1")
	{
		GetMapName = "太平间-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_mortuary01")
	{
		GetMapName = "太平间-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_mortuary02")
	{
		GetMapName = "太平间-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_mortuary03")
	{
		GetMapName = "太平间-终点站";
		Checkpoint = 5;
	}
	else if(Map == "1BM")
	{
		GetMapName = "惩罚者-第1站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-2")
	{
		GetMapName = "惩罚者-第2站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-3")
	{
		GetMapName = "惩罚者-第3站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-4")
	{
		GetMapName = "惩罚者-第4站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-5")
	{
		GetMapName = "惩罚者-第5站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-6")
	{
		GetMapName = "惩罚者-第6站";
		Checkpoint = 7;
	}
	else if(Map == "1BM-7")
	{
		GetMapName = "惩罚者-终点站";
		Checkpoint = 7;
	}
	else if(Map == "wth_1")
	{
		GetMapName = "欢迎来到地狱-第1站";
		Checkpoint = 5;
	}
	else if(Map == "WTH_2")
	{
		GetMapName = "欢迎来到地狱-第2站";
		Checkpoint = 5;
	}
	else if(Map == "WTH_3")
	{
		GetMapName = "欢迎来到地狱-第3站";
		Checkpoint = 5;
	}
	else if(Map == "WTH_4")
	{
		GetMapName = "欢迎来到地狱-第4站";
		Checkpoint = 5;
	}
	else if(Map == "WTH_5")
	{
		GetMapName = "欢迎来到地狱-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_apocalypse01")
	{
		GetMapName = "启示录II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_apocalypse02")
	{
		GetMapName = "启示录II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_apocalypse03")
	{
		GetMapName = "启示录II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_apocalypse04")
	{
		GetMapName = "启示录II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_apocalypse05")
	{
		GetMapName = "启示录II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_bs_mansion")
	{
		GetMapName = "血腥周末II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_bs_riverside")
	{
		GetMapName = "血腥周末II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_bs_valley_of_death")
	{
		GetMapName = "血腥周末II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_bs_barrage")
	{
		GetMapName = "血腥周末II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_bs_bloodyfinale1")
	{
		GetMapName = "血腥周末II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "Cure2_001")
	{
		GetMapName = "治愈II-第1站";
		Checkpoint = 5;
	}
	else if(Map == "Cure2_002")
	{
		GetMapName = "治愈II-第2站";
		Checkpoint = 5;
	}
	else if(Map == "Cure2_003")
	{
		GetMapName = "治愈II-第3站";
		Checkpoint = 5;
	}
	else if(Map == "Cure2_004")
	{
		GetMapName = "治愈II-第4站";
		Checkpoint = 5;
	}
	else if(Map == "Cure2_005")
	{
		GetMapName = "治愈II-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_eft1_subsystem")
	{
		GetMapName = "逃离多伦多II-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_eft2_tower")
	{
		GetMapName = "逃离多伦多II-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_eft3_queensquay")
	{
		GetMapName = "逃离多伦多II-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_eft4_drybay")
	{
		GetMapName = "逃离多伦多II-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_eft5_niagaracity")
	{
		GetMapName = "逃离多伦多II-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_eft6_bordercrossing1")
	{
		GetMapName = "逃离多伦多II-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_forest01_orchard")
	{
		GetMapName = "大坝I-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_forest02_campground")
	{
		GetMapName = "大坝I-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_forest03_dam")
	{
		GetMapName = "大坝I-终点站";
		Checkpoint = 3;
	}
	else if(Map == "uz_crash")
	{
		GetMapName = "星河战队-第1站";
		Checkpoint = 5;
	}
	else if(Map == "uz_town")
	{
		GetMapName = "星河战队-第2站";
		Checkpoint = 5;
	}
	else if(Map == "uz_desert")
	{
		GetMapName = "星河战队-第3站";
		Checkpoint = 5;
	}
	else if(Map == "uz_bunker")
	{
		GetMapName = "星河战队-第4站";
		Checkpoint = 5;
	}
	else if(Map == "uz_escape")
	{
		GetMapName = "星河战队-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_sh01_oldsh")
	{
		GetMapName = "寂静岭迷你版-第1站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh07_otherchurch")
	{
		GetMapName = "寂静岭迷你版-第2站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh08_sewres")
	{
		GetMapName = "寂静岭迷你版-第3站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh09_resort")
	{
		GetMapName = "寂静岭迷你版-第4站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh10_amusementpark")
	{
		GetMapName = "寂静岭迷你版-第5站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh11_nowhere")
	{
		GetMapName = "寂静岭迷你版-第6站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh12_theend")
	{
		GetMapName = "寂静岭迷你版-第7站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh_theend2")
	{
		GetMapName = "寂静岭迷你版-第8站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh_theend3")
	{
		GetMapName = "寂静岭迷你版-第9站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh_theend4")
	{
		GetMapName = "寂静岭迷你版-第10站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_sh_credits")
	{
		GetMapName = "寂静岭迷你版-终点站";
		Checkpoint = 11;
	}
	else if(Map == "l4d2_longmap01")
	{
		GetMapName = "官方地图(毫不留情)-第1站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap02")
	{
		GetMapName = "官方地图(坠机险途)-第2站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap03")
	{
		GetMapName = "官方地图(死亡丧钟)-第3站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap04")
	{
		GetMapName = "官方地图(寂静时分)-第4站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap05")
	{
		GetMapName = "官方地图(血腥收获)-第5站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap06")
	{
		GetMapName = "官方地图(牺牲)-第6站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap07")
	{
		GetMapName = "官方地图(黑色嘉年华)-第7站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap08")
	{
		GetMapName = "官方地图(消逝)-第8站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap09")
	{
		GetMapName = "官方地图(黑色嘉年华)-第9站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap10")
	{
		GetMapName = "官方地图(沼泽激战)-第10站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap11")
	{
		GetMapName = "官方地图(暴风骤雨)-第11站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap12")
	{
		GetMapName = "官方地图(教区)-第12站";
		Checkpoint = 13;
	}
	else if(Map == "l4d2_longmap13")
	{
		GetMapName = "官方地图-终点站";
		Checkpoint = 13;
	}
	else if(Map == "l4d_stadium1_apartment")
	{
		GetMapName = "闪电战-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_stadium2_underground")
	{
		GetMapName = "闪电战-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_stadium3_city1")
	{
		GetMapName = "闪电战-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_stadium4_city2")
	{
		GetMapName = "闪电战-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_stadium5_stadium")
	{
		GetMapName = "闪电战-终点站";
		Checkpoint = 5;
	}
	else if(Map == "bp_m1_waterfront")
	{
		GetMapName = "教区重置版-第1站";
		Checkpoint = 5;
	}
	else if(Map == "bp_m2_semiurban")
	{
		GetMapName = "教区重置版-第2站";
		Checkpoint = 5;
	}
	else if(Map == "bp_m3_cemetery")
	{
		GetMapName = "教区重置版-第3站";
		Checkpoint = 5;
	}
	else if(Map == "bp_m4_urban")
	{
		GetMapName = "教区重置版-第4站";
		Checkpoint = 5;
	}
	else if(Map == "bp_m5_finale")
	{
		GetMapName = "教区重置版-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d2_cc_street_d")
	{
		GetMapName = "城市中心启示录-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_cc_basement_c")
	{
		GetMapName = "城市中心启示录-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_cc_ascent_a")
	{
		GetMapName = "城市中心启示录-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_cc_hotel")
	{
		GetMapName = "城市中心启示录-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_cc_station-a")
	{
		GetMapName = "城市中心启示录-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_cc_finale")
	{
		GetMapName = "城市中心启示录-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_tgtn01_fridayroad")
	{
		GetMapName = "Neighborhood-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_tgtn02_northave")
	{
		GetMapName = "Neighborhood-第2站";
		Checkpoint = 4;
	}
	else if(Map == "embassy")
	{
		GetMapName = "Neighborhood-第3站";
		Checkpoint = 4;
	}
	else if(Map == "ud_map4")
	{
		GetMapName = "Neighborhood-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_fallindeath01")
	{
		GetMapName = "坠入死亡-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_fallindeath02")
	{
		GetMapName = "坠入死亡-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_fallindeath03")
	{
		GetMapName = "坠入死亡-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_fallindeath04")
	{
		GetMapName = "坠入死亡-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_draxmap0")
	{
		GetMapName = "死亡终点站-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_draxmap2")
	{
		GetMapName = "死亡终点站-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_draxmap3")
	{
		GetMapName = "死亡终点站-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_draxmap4")
	{
		GetMapName = "死亡终点站-终点站";
		Checkpoint = 4;
	}
	else if(Map == "soi_m1_metrostation")
	{
		GetMapName = "感染之源-第1站";
		Checkpoint = 4;
	}
	else if(Map == "soi_m2_museum")
	{
		GetMapName = "感染之源-第2站";
		Checkpoint = 4;
	}
	else if(Map == "soi_m3_biolab")
	{
		GetMapName = "感染之源-第3站";
		Checkpoint = 4;
	}
	else if(Map == "soi_m4_underground")
	{
		GetMapName = "感染之源-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_fallen01_approach")
	{
		GetMapName = "坠落-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen02_trenches")
	{
		GetMapName = "坠落-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen03_tower")
	{
		GetMapName = "坠落-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen04_cliff")
	{
		GetMapName = "坠落-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen05_shaft")
	{
		GetMapName = "坠落-终点站";
		Checkpoint = 5;
	}
	else if(Map == "quart")
	{
		GetMapName = "逃离瓦伦西-第1站";
		Checkpoint = 4;
	}
	else if(Map == "nuevocentro_ext")
	{
		GetMapName = "逃离瓦伦西-第2站";
		Checkpoint = 4;
	}
	else if(Map == "nuevocentro_int")
	{
		GetMapName = "逃离瓦伦西-第3站";
		Checkpoint = 4;
	}
	else if(Map == "metro_vlc")
	{
		GetMapName = "逃离瓦伦西-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_linz_kbh")
	{
		GetMapName = "迷失在林茨-第1站";
		Checkpoint = 5;
	}
	else if(Map == "busbahnhof1")
	{
		GetMapName = "迷失在林茨-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_linz_ok")
	{
		GetMapName = "迷失在林茨-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_linz_zurueck")
	{
		GetMapName = "迷失在林茨-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_linz_bahnhof")
	{
		GetMapName = "迷失在林茨-终点站";
		Checkpoint = 5;
	}
	else if(Map == "dttg001")
	{
		GetMapName = "黑暗之塔:神枪-第1站";
		Checkpoint = 7;
	}
	else if(Map == "dttg002")
	{
		GetMapName = "黑暗之塔:神枪-第2站";
		Checkpoint = 7;
	}
	else if(Map == "dttg003")
	{
		GetMapName = "黑暗之塔:神枪-第3站";
		Checkpoint = 7;
	}
	else if(Map == "dttg004")
	{
		GetMapName = "黑暗之塔:神枪-第4站";
		Checkpoint = 7;
	}
	else if(Map == "dttg005")
	{
		GetMapName = "黑暗之塔:神枪-第5站";
		Checkpoint = 7;
	}
	else if(Map == "dttg006")
	{
		GetMapName = "黑暗之塔:神枪-第6站";
		Checkpoint = 7;
	}
	else if(Map == "dttg007")
	{
		GetMapName = "黑暗之塔:神枪-终点站";
		Checkpoint = 7;
	}
	else if(Map == "l4d2_crashbandicootvs1")
	{
		GetMapName = "崩溃博士II-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_crashbandicootvs2")
	{
		GetMapName = "崩溃博士II-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_crashbandicootvs3")
	{
		GetMapName = "崩溃博士II-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_crashbandicootvs4")
	{
		GetMapName = "崩溃博士II-终点站";
		Checkpoint = 4;
	}
	else if(Map == "umd")
	{
		GetMapName = "德卢斯2017-第1站";
		Checkpoint = 4;
	}
	else if(Map == "fitgers")
	{
		GetMapName = "德卢斯2017-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4duluth_skywalk_vs")
	{
		GetMapName = "德卢斯2017-第3站";
		Checkpoint = 4;
	}
	else if(Map == "canalpark")
	{
		GetMapName = "德卢斯2017-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_ravenholm01_blackmesa")
	{
		GetMapName = "莱温霍姆-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ravenholm02_traptown")
	{
		GetMapName = "莱温霍姆-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ravenholm03_church")
	{
		GetMapName = "莱温霍姆-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ravenholm04_cavern")
	{
		GetMapName = "莱温霍姆-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_ravenholm05_docks")
	{
		GetMapName = "莱温霍姆-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen01_approach")
	{
		GetMapName = "坠落-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen02_trenches")
	{
		GetMapName = "坠落-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen03_tower")
	{
		GetMapName = "坠落-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen04_cliff")
	{
		GetMapName = "坠落-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_fallen05_shaft")
	{
		GetMapName = "坠落-终点站";
		Checkpoint = 5;
	}
	else if(Map == "mall_of_ukraine")
	{
		GetMapName = "第聂伯河-第1站";
		Checkpoint = 4;
	}
	else if(Map == "waters_of_the_dniepr")
	{
		GetMapName = "第聂伯河-第2站";
		Checkpoint = 4;
	}
	else if(Map == "warm_welcoming")
	{
		GetMapName = "第聂伯河-第3站";
		Checkpoint = 4;
	}
	else if(Map == "the_end")
	{
		GetMapName = "第聂伯河-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_feetunder_outpostazbo")
	{
		GetMapName = "僵尸停电-第1站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_route76azbo")
	{
		GetMapName = "僵尸停电-第2站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_shoppingcenterzbo")
	{
		GetMapName = "僵尸停电-第3站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_ft_station01zbo")
	{
		GetMapName = "僵尸停电-第4站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_ft_station02zbo")
	{
		GetMapName = "僵尸停电-第5站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_withoutname_complexzbo")
	{
		GetMapName = "僵尸停电-第6站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_withoutname_lakezbo")
	{
		GetMapName = "僵尸停电-第7站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_withoutname_townzbo")
	{
		GetMapName = "僵尸停电-终点站";
		Checkpoint = 8;
	}
	else if(Map == "l4d2_deadcity01_riverside")
	{
		GetMapName = "死亡之城II-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_deadcity02_backalley")
	{
		GetMapName = "死亡之城II-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_deadcity03_bridge")
	{
		GetMapName = "死亡之城II-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_deadcity04_outpost")
	{
		GetMapName = "死亡之城II-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_deadcity05_plant")
	{
		GetMapName = "死亡之城II-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d2_deadcity06_station")
	{
		GetMapName = "死亡之城II-终点站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_yama_1")
	{
		GetMapName = "摩耶山危机-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_yama_2")
	{
		GetMapName = "摩耶山危机-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_yama_3")
	{
		GetMapName = "摩耶山危机-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_yama_4")
	{
		GetMapName = "摩耶山危机-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_yama_5")
	{
		GetMapName = "摩耶山危机-终点站";
		Checkpoint = 5;
	}
	else if(Map == "amsterdam1etd")
	{
		GetMapName = "本能逃离-第1站";
		Checkpoint = 7;
	}
	else if(Map == "amsterdam2etd")
	{
		GetMapName = "本能逃离-第2站";
		Checkpoint = 7;
	}
	else if(Map == "fs_m1_canaletd")
	{
		GetMapName = "本能逃离-第3站";
		Checkpoint = 7;
	}
	else if(Map == "palacev4etd")
	{
		GetMapName = "本能逃离-第4站";
		Checkpoint = 7;
	}
	else if(Map == "fort1ecc")
	{
		GetMapName = "本能逃离-第5站";
		Checkpoint = 7;
	}
	else if(Map == "fort2ecc")
	{
		GetMapName = "本能逃离-第6站";
		Checkpoint = 7;
	}
	else if(Map == "fort3ecc")
	{
		GetMapName = "本能逃离-终点站";
		Checkpoint = 7;
	}
	else if(Map == "dead_death_02")
	{
		GetMapName = "最后电话-第1站";
		Checkpoint = 4;
	}
	else if(Map == "dead_death_03")
	{
		GetMapName = "最后电话-第2站";
		Checkpoint = 4;
	}
	else if(Map == "dead_death_01")
	{
		GetMapName = "最后电话-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_gore_factory")
	{
		GetMapName = "最后电话-终点站";
		Checkpoint = 4;
	}
	else if(Map == "southstreet3_sunrise")
	{
		GetMapName = "南街Ⅲ-生存";
		Checkpoint = 1;
	}
	else if(Map == "southstreet3_night")
	{
		GetMapName = "南街Ⅲ-今晚";
		Checkpoint = 1;
	}
	else if(Map == "southstreet3_day")
	{
		GetMapName = "南街Ⅲ-今天";
		Checkpoint = 1;
	}
	else if(Map == "1-cheyenne")
	{
		GetMapName = "SGC-第1站";
		Checkpoint = 6;
	}
	else if(Map == "2-comandosgc")
	{
		GetMapName = "SGC-第2站";
		Checkpoint = 6;
	}
	else if(Map == "3-BaseGamma")
	{
		GetMapName = "SGC-第3站";
		Checkpoint = 6;
	}
	else if(Map == "4-DnalsiYeknom")
	{
		GetMapName = "SGC-第4站";
		Checkpoint = 6;
	}
	else if(Map == "5-dedalo")
	{
		GetMapName = "SGC-第5站";
		Checkpoint = 6;
	}
	else if(Map == "6-despegando")
	{
		GetMapName = "SGC-终点站";
		Checkpoint = 6;
	}
	else if(Map == "cotd01_apartments")
	{
		GetMapName = "死亡之城-第1站";
		Checkpoint = 4;
	}
	else if(Map == "cotd02_warehouse")
	{
		GetMapName = "死亡之城-第2站";
		Checkpoint = 4;
	}
	else if(Map == "cotd03_mall")
	{
		GetMapName = "死亡之城-第3站";
		Checkpoint = 4;
	}
	else if(Map == "cotd04_rooftop")
	{
		GetMapName = "死亡之城-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_junglecrisis01_hunted")
	{
		GetMapName = "丛林食尸鬼-第1站";
		Checkpoint = 8;
	}
	else if(Map == "lc_museum_hall")
	{
		GetMapName = "丛林食尸鬼-第2站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_agonizing_city")
	{
		GetMapName = "丛林食尸鬼-第3站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_nyc01_bridge")
	{
		GetMapName = "丛林食尸鬼-第4站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_nyc02_inwood")
	{
		GetMapName = "丛林食尸鬼-第5站";
		Checkpoint = 8;
	}
	else if(Map == "l4d_hospital02_riverpark")
	{
		GetMapName = "丛林食尸鬼-第6站";
		Checkpoint = 8;
	}
	else if(Map == "lor_43")
	{
		GetMapName = "丛林食尸鬼-第7站";
		Checkpoint = 8;
	}
	else if(Map == "sh_theend4")
	{
		GetMapName = "丛林食尸鬼-终点站";
		Checkpoint = 8;
	}
	else if(Map == "symbyosys_01")
	{
		GetMapName = "合作符号-第1站";
		Checkpoint = 5;
	}
	else if(Map == "symbyosys_02")
	{
		GetMapName = "合作符号-第2站";
		Checkpoint = 5;
	}
	else if(Map == "symbyosys_03_bridge")
	{
		GetMapName = "合作符号-第3站";
		Checkpoint = 5;
	}
	else if(Map == "symbyosys_04")
	{
		GetMapName = "合作符号-第4站";
		Checkpoint = 5;
	}
	else if(Map == "symbyosys_05_final")
	{
		GetMapName = "合作符号-终点站";
		Checkpoint = 5;
	}
	else if(Map == "newintro_3")
	{
		GetMapName = "虚幻竞技场-第1站";
		Checkpoint = 7;
	}
	else if(Map == "new_coret1")
	{
		GetMapName = "虚幻竞技场-第2站";
		Checkpoint = 7;
	}
	else if(Map == "new_deck1")
	{
		GetMapName = "虚幻竞技场-第3站";
		Checkpoint = 7;
	}
	else if(Map == "new_gaunty1")
	{
		GetMapName = "虚幻竞技场-第4站";
		Checkpoint = 7;
	}
	else if(Map == "new_Lliandri1")
	{
		GetMapName = "虚幻竞技场-第5站";
		Checkpoint = 7;
	}
	else if(Map == "new_duku_3")
	{
		GetMapName = "虚幻竞技场-第6站";
		Checkpoint = 7;
	}
	else if(Map == "new_lava_weather_3")
	{
		GetMapName = "虚幻竞技场-终点站";
		Checkpoint = 7;
	}
	else if(Map == "facility13_v2_0" || Map == "facility13_survival_cl")
	{
		GetMapName = "死守-终点站";
		Checkpoint = 1;
	}
	else if(Map == "gb_m1_road")
	{
		GetMapName = "弹道导弹-第1站";
		Checkpoint = 5;
	}
	else if(Map == "gb_m2_yard")
	{
		GetMapName = "弹道导弹-第2站";
		Checkpoint = 5;
	}
	else if(Map == "gb_m3_doctor")
	{
		GetMapName = "弹道导弹-第3站";
		Checkpoint = 5;
	}
	else if(Map == "gb_m4_up")
	{
		GetMapName = "弹道导弹-第4站";
		Checkpoint = 5;
	}
	else if(Map == "gb_m5_burn")
	{
		GetMapName = "弹道导弹-终点站";
		Checkpoint = 5;
	}
	else if(Map == "the_return_lvl1")
	{
		GetMapName = "返回:续集-第1站";
		Checkpoint = 5;
	}
	else if(Map == "the_return_lvl2")
	{
		GetMapName = "返回:续集-第2站";
		Checkpoint = 5;
	}
	else if(Map == "the_return_level3")
	{
		GetMapName = "返回:续集-第3站";
		Checkpoint = 5;
	}
	else if(Map == "the_return_level4")
	{
		GetMapName = "返回:续集-第4站";
		Checkpoint = 5;
	}
	else if(Map == "the_return_lvl5")
	{
		GetMapName = "返回:续集-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_auburn")
	{
		GetMapName = "奥本计划-第1站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_2")
	{
		GetMapName = "奥本计划-第2站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_3")
	{
		GetMapName = "奥本计划-第3站";
		Checkpoint = 4;
	}
	else if(Map == "l4d_auburn_finale")
	{
		GetMapName = "奥本计划-终点站";
		Checkpoint = 4;
	}
	else if(Map == "d1c1")
	{
		GetMapName = "Dreamz-第1站";
		Checkpoint = 4;
	}
	else if(Map == "d1c2")
	{
		GetMapName = "Dreamz-第2站";
		Checkpoint = 4;
	}
	else if(Map == "d1c3")
	{
		GetMapName = "Dreamz-第3站";
		Checkpoint = 4;
	}
	else if(Map == "d1c4")
	{
		GetMapName = "Dreamz-终点站";
		Checkpoint = 4;
	}
	else if(Map == "l4d2_echo")
	{
		GetMapName = "撤离中心-第1站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_ceda")
	{
		GetMapName = "撤离中心-第2站";
		Checkpoint = 3;
	}
	else if(Map == "l4d2_hub")
	{
		GetMapName = "撤离中心-终点站";
		Checkpoint = 3;
	}
	else if(Map == "ud_map01")
	{
		GetMapName = "城市灾害-第1站";
		Checkpoint = 5;
	}
	else if(Map == "ud_map02")
	{
		GetMapName = "城市灾害-第2站";
		Checkpoint = 5;
	}
	else if(Map == "ud_map03")
	{
		GetMapName = "城市灾害-第3站";
		Checkpoint = 5;
	}
	else if(Map == "ud_map04")
	{
		GetMapName = "城市灾害-第4站";
		Checkpoint = 5;
	}
	else if(Map == "ud_map05")
	{
		GetMapName = "城市灾害-终点站";
		Checkpoint = 5;
	}
	else if(Map == "azhill1")
	{
		GetMapName = "绝对零度结局-第1站";
		Checkpoint = 3;
	}
	else if(Map == "azhill2")
	{
		GetMapName = "绝对零度结局-第2站";
		Checkpoint = 3;
	}
	else if(Map == "azhill3")
	{
		GetMapName = "绝对零度结局-终点站";
		Checkpoint = 3;
	}
	else if(Map == "l4d_viennacalling_city")
	{
		GetMapName = "维也纳呼唤-第1站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_viennacalling_kaiserfranz")
	{
		GetMapName = "维也纳呼唤-第2站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_viennacalling_gloomy")
	{
		GetMapName = "维也纳呼唤-第3站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_viennacalling_donauinsel")
	{
		GetMapName = "维也纳呼唤-第4站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_viennacalling_donauturm")
	{
		GetMapName = "维也纳呼唤-终点站";
		Checkpoint = 5;
	}
	else if(Map == "l4d_viennacalling2_1")
	{
		GetMapName = "维也纳呼唤II-第1站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_viennacalling2_2")
	{
		GetMapName = "维也纳呼唤II-第2站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_viennacalling2_3")
	{
		GetMapName = "维也纳呼唤II-第3站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_viennacalling2_4")
	{
		GetMapName = "维也纳呼唤II-第4站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_viennacalling2_5")
	{
		GetMapName = "维也纳呼唤II-第5站";
		Checkpoint = 6;
	}
	else if(Map == "l4d_viennacalling2_finale")
	{
		GetMapName = "维也纳呼唤II-终点站";
		Checkpoint = 6;
	}
	else
	{
		GetMapName = Map;
		Checkpoint = 0;
	}
	
	return GetMapName;
}
::GetCheckpoint <- function()
{
	return Checkpoint;
}