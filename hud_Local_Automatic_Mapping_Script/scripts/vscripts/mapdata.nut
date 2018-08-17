/*  地图数据
*	如需添加新地图
*	请依照以下格式写入：
*	else if(Map == "当前地图最后一关")
	{
		NextMap = "下一关地图第一关";
		GetNextMapName = "下一关地图名称";
		BoolValidMap = true;
	}
*/
::GetNextMapName <- {};
::NextMap <- {};
::BoolValidMap <- false;

/* 换图数据 */
::Map_Data<-function()
{
	local Map = SessionState.MapName.tolower();
	
	if(Map == "c1m4_atrium")
	{
		RandomMap_1();
		BoolValidMap = true;
	}
	else if(Map == "c13m4_cutthroatcreek")
	{
		RandomMap_13();
		BoolValidMap = true;
	}
	else if(Map == "c10m5_houseboat")
	{
		RandomMap_10();
		BoolValidMap = true;
	}
	else if(Map == "c7m3_port")
	{
		RandomMap_7();
		BoolValidMap = true;
	}
	else if(Map == "c5m5_bridge")
	{
		RandomMap_5();
		BoolValidMap = true;
	}
	else if(Map == "c2m5_concert")
	{
		RandomMap_2();
		BoolValidMap = true;
	}
	else if(Map == "c4m5_milltown_escape")
	{
		RandomMap_4();
		BoolValidMap = true;
	}
	else if(Map == "c6m3_port")
	{
		RandomMap_6();
		BoolValidMap = true;
	}
	else if(Map == "c3m4_plantation")
	{
		RandomMap_3();
		BoolValidMap = true;
	}
	else if(Map == "c8m5_rooftop")
	{
		RandomMap_8();
		BoolValidMap = true;
	}
	else if(Map == "c11m5_runway")
	{
		RandomMap_11();
		BoolValidMap = true;
	}
	else if(Map == "c12m5_cornfield")
	{
		RandomMap_12();
		BoolValidMap = true;
	}
	else if(Map == "c9m2_lots")
	{
		RandomMap_9();
		BoolValidMap = true;
	}
	else
	{
		BoolValidMap = false;
	}
}
::RandomMap_9<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 9)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 10)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 11)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 12)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
}
::RandomMap_12<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 9)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 10)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 11)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_11<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 9)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 10)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_8<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 9)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_3<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_6<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_4<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_2<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_5<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 5)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_7<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 4)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 5)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_10<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 3)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 4)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 5)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_13<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c1m1_hotel";
		GetNextMapName = "死亡中心";
	}
	if(RandomMap == 2)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 3)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 4)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 5)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
::RandomMap_1<-function()
{
	local RandomMap = RandomInt(1, 12);;
	if(RandomMap == 1)
	{
		NextMap = "c13m1_alpinecreek";
		GetNextMapName = "刺骨寒溪";
	}
	if(RandomMap == 2)
	{
		NextMap = "c10m1_caves";
		GetNextMapName = "死亡丧钟";
	}
	if(RandomMap == 3)
	{
		NextMap = "c7m1_docks";
		GetNextMapName = "牺牲";
	}
	if(RandomMap == 4)
	{
		NextMap = "c5m1_waterfront";
		GetNextMapName = "教区";
	}
	if(RandomMap == 5)
	{
		NextMap = "c2m1_highway";
		GetNextMapName = "黑色嘉年华";
	}
	if(RandomMap == 6)
	{
		NextMap = "c4m1_milltown_a";
		GetNextMapName = "暴风骤雨";
	}
	if(RandomMap == 7)
	{
		NextMap = "c6m1_riverbank";
		GetNextMapName = "消逝";
	}
	if(RandomMap == 8)
	{
		NextMap = "c3m1_plankcountry";
		GetNextMapName = "沼泽激战";
	}
	if(RandomMap == 9)
	{
		NextMap = "c8m1_apartment";
		GetNextMapName = "毫不留情";
	}
	if(RandomMap == 10)
	{
		NextMap = "c11m1_greenhouse";
		GetNextMapName = "寂静时分";
	}
	if(RandomMap == 11)
	{
		NextMap = "c12m1_hilltop";
		GetNextMapName = "血腥收获";
	}
	if(RandomMap == 12)
	{
		NextMap = "c9m1_alleys";
		GetNextMapName = "坠机险途";
	}
}
/*	有效的地图，防止错误提示 
*	如已写入新地图代码
*	这里也应写入新地图救援关代码
*/
::MapIsValid<-function(Map)
{
	if( Map == "c1m4_atrium" || 
		Map == "c2m5_concert" || 
		Map == "c3m4_plantation"  || 
		Map == "c4m5_milltown_escape" || 
		Map == "c5m5_bridge" || 
		Map == "c6m3_port" || 
		Map == "c7m3_port" || 
		Map == "c8m5_rooftop" || 
		Map == "c9m2_lots" || 
		Map == "c10m5_houseboat" || 
		Map == "c11m5_runway" || 
		Map == "c12m5_cornfield" || 
		Map == "c13m4_cutthroatcreek" )
	{
		return 1;
	}
	
	return 0;
}
::NextMapName<-function()
{
	return GetNextMapName;
}
::GetNextMap<-function()
{
	return NextMap;
}

::IsValidMap<-function()
{
	if(BoolValidMap)
	{
		return 1;
	}
	
	return 0;
}