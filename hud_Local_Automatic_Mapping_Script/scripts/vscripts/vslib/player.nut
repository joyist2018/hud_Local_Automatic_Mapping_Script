/*  
 * Copyright (c) 2013 LuKeM aka Neil - 119 and Rayman1103
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 */


/**
 * \简要提供了很多有用的玩家功能
 *
 * 玩家类的工作原理是 ::VSLib.EasyLogic.通知和构建在实体类上.
 */
class ::VSLib.Player extends ::VSLib.Entity
{
	constructor(index)
	{
		base.constructor(index);
	}
	
	function _typeof()
	{
		return "VSLIB_PLAYER";
	}
}


// @see DropWeaponSlot
getconsttable()["SLOT_PRIMARY"] <- 0;
getconsttable()["SLOT_SECONDARY"] <- 1;
getconsttable()["SLOT_THROW"] <- 2;
getconsttable()["SLOT_MEDKIT"] <- 3;
getconsttable()["SLOT_PILLS"] <- 4;
getconsttable()["SLOT_CARRIED"] <- 5;
getconsttable()["SLOT_HELD"] <- "Held";



/**
 * 如果玩家的实体是valid有效或虚假false,则返回true.
 */
function VSLib::Player::IsPlayerEntityValid()
{
	if (_ent == null)
		return false;
	
	if (!("IsValid" in _ent))
		return false;
	
	if (!_ent.IsValid())
		return false;
	
	if ("IsPlayer" in _ent)
		return _ent.IsPlayer();
	
	return false;
}

/**
 * 获取字符名称(不是steam名称)。如 "Nick" 或 "Rochelle"
 */
function VSLib::Player::GetCharacterName()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	if ( GetSurvivorCharacter() == 4 )
		return "Bill";
	else if ( GetSurvivorCharacter() == 5 )
		return "Zoey";
	else if ( GetSurvivorCharacter() == 6 )
		return "Francis";
	else if ( GetSurvivorCharacter() == 7 )
		return "Louis";
	else if ( GetSurvivorCharacter() > 7 && GetTeam() == 4 )
		return "Survivor";
	
	return g_MapScript.GetCharacterDisplayName(_ent);
}

/**
 * 基本角色名称。例如 Bill 将返回 "Nick" 或 Zoey 将返回 "Rochelle"
 */
function VSLib::Player::GetBaseCharacterName()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	if ( GetSurvivorCharacter() == 0 )
		return "Nick";
	else if ( GetSurvivorCharacter() == 1 )
		return "Rochelle";
	else if ( GetSurvivorCharacter() == 2 )
		return "Coach";
	else if ( GetSurvivorCharacter() == 3 )
		return "Ellis";
	
	return GetCharacterName();
}

/**
 * 返回幸存者的过滤器名称.
 */
function VSLib::Player::GetFilterName()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return "";
	
	if ( GetSurvivorCharacter() == 0 )
		return "!nick";
	else if ( GetSurvivorCharacter() == 1 )
		return "!rochelle";
	else if ( GetSurvivorCharacter() == 2 )
		return "!coach";
	else if ( GetSurvivorCharacter() == 3 )
		return "!ellis";
	else if ( GetSurvivorCharacter() == 4 )
		return "!bill";
	else if ( GetSurvivorCharacter() == 5 )
		return "!zoey";
	else if ( GetSurvivorCharacter() == 6 )
		return "!francis";
	else if ( GetSurvivorCharacter() == 7 )
		return "!louis";
	
	return "";
}

/**
 * 获取玩家的Steam ID.
 */
function VSLib::Player::GetSteamID()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	if ("GetNetworkIDString" in _ent)
		return _ent.GetNetworkIDString();
	else
	{
		local userid = "_vslUserID_" + GetUserID();
		
		if ( userid in ::VSLib.EasyLogic.UserCache && IsHuman() )
		{
			if ("_steam" in ::VSLib.EasyLogic.UserCache[userid])
				return ::VSLib.EasyLogic.UserCache[userid]["_steam"];
		}
		else
		{
			local id = _idx;
			if (!(id in ::VSLib.GlobalCache))
				return GetNetPropString( "m_szNetworkIDString" );
			
			if ("_steam" in ::VSLib.GlobalCache[id])
				return ::VSLib.GlobalCache[id]["_steam"];
		}
	}
	
	return "";
}

/**
 * 获取玩家的Unqiue ID (clean, formatted Steam ID).
 */
function VSLib::Player::GetUniqueID()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	local steamid = GetSteamID();
	steamid = ::VSLib.Utils.StringReplace(steamid, "STEAM_1:", "S");
	steamid = ::VSLib.Utils.StringReplace(steamid, "STEAM_0:", "S");
	steamid = ::VSLib.Utils.StringReplace(steamid, ":", "");
	
	return steamid;
}

/**
 * 得到了玩家的SteamID64.
 */
function VSLib::Player::GetSteamID64()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	local userid = "_vslUserID_" + GetUserID();
	
	if ( userid in ::VSLib.EasyLogic.UserCache && IsHuman() )
	{
		if ("_xuid" in ::VSLib.EasyLogic.UserCache[userid])
			return ::VSLib.EasyLogic.UserCache[userid]["_xuid"];
	}
	else
	{
		local id = _idx;
		if (!(id in ::VSLib.GlobalCache))
			return "";
		
		if ("_xuid" in ::VSLib.GlobalCache[id])
			return ::VSLib.GlobalCache[id]["_xuid"];
	}
	
	return "";
}

/**
 * 获取玩家的IP地址.
 */
function VSLib::Player::GetIPAddress()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return "";
	}
	
	local userid = "_vslUserID_" + GetUserID();
	
	if ( userid in ::VSLib.EasyLogic.UserCache && IsHuman() )
	{
		if ("_ip" in ::VSLib.EasyLogic.UserCache[userid])
			return ::VSLib.EasyLogic.UserCache[userid]["_ip"];
	}
	else
	{
		local id = _idx;
		if (!(id in ::VSLib.GlobalCache))
			return "";
		
		if ("_ip" in ::VSLib.GlobalCache[id])
			return ::VSLib.GlobalCache[id]["_ip"];
	}
	
	return "";
}

/**
 * 获取玩家的名字.
 */
function VSLib::Player::GetName()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return base.GetName();
	}
	
	return _ent.GetPlayerName();
}

/**
 * 返回玩家的ping.
 */
function VSLib::Player::GetPing()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ( !Entities.FindByClassname( null, "terror_player_manager" ) )
		return;
	
	return ::VSLib.Entity("terror_player_manager").GetNetPropInt( "m_iPing", _idx );
}

/**
 * 如果玩家是监听服务器的主机则返回true.
 */
function VSLib::Player::IsServerHost()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if ( !Entities.FindByClassname( null, "terror_player_manager" ) )
		return false;
	
	return ::VSLib.Entity("terror_player_manager").GetNetPropBool( "m_listenServerHost", _idx );
}

/**
 * 如果玩家连接到服务器，返回true.
 */
function VSLib::Player::IsConnected()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if ( !Entities.FindByClassname( null, "terror_player_manager" ) )
		return false;
	
	return ::VSLib.Entity("terror_player_manager").GetNetPropBool( "m_bConnected", _idx );
}

/**
 * 获取玩家的记录生存时间.
 */
function VSLib::Player::GetSurvivalRecordTime()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if ( !Entities.FindByClassname( null, "terror_player_manager" ) )
		return;
	
	return ::VSLib.Entity("terror_player_manager").GetNetPropFloat( "m_flSurvivalRecordTime", _idx );
}

/**
 * 获取玩家的最高生存奖牌.
 */
function VSLib::Player::GetSurvivalTopMedal()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if ( !Entities.FindByClassname( null, "terror_player_manager" ) )
		return;
	
	return ::VSLib.Entity("terror_player_manager").GetNetPropInt( "m_nSurvivalTopMedal", _idx );
}

/**
 * 如果玩家还活着，返回true.
 */
function VSLib::Player::IsAlive()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return !_ent.IsDead() && !_ent.IsDying();
}

/**
 * 如果玩家死亡，返回true.
 */
function VSLib::Player::IsDead()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return _ent.IsDead();
}

/**
 * 如果玩家频临死亡，返回true.
 */
function VSLib::Player::IsDying()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return _ent.IsDying();
}

/**
 * 如果玩家被制服倒地，返回true.
 */
function VSLib::Player::IsIncapacitated()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return _ent.IsIncapacitated();
}

/**
 * 如果玩家被扑杀，返回true
 */
function VSLib::Player::IsCulling()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isCulling" );
}

/**
 * 如果正在重新安置玩家，则返回true
 */
function VSLib::Player::IsRelocating()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isRelocating" );
}

/**
 * 如果玩家挂在边缘，返回true.
 */
function VSLib::Player::IsHangingFromLedge()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return _ent.IsHangingFromLedge();
}

/**
 * 如果玩家被烟舌缠住，返回true
 */
function VSLib::Player::IsHangingFromTongue()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isHangingFromTongue" );
}

/**
 * 如果玩家被猴子jockeyed骑，就返回true
 */
function VSLib::Player::IsBeingJockeyed()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return (GetNetPropInt( "m_jockeyAttacker" ) > 0) ? true : false;
}

/**
 * 如果玩家是猎人Hunter猛扑的受害者，就返回true
 */
function VSLib::Player::IsPounceVictim()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return (GetNetPropInt( "m_pounceAttacker" ) > 0) ? true : false;
}

/**
 * 如果玩家是烟鬼Smoker的受害者，返回true 
 */
function VSLib::Player::IsTongueVictim()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return (GetNetPropInt( "m_tongueOwner" ) > 0) ? true : false;
}

/**
 * 如果玩家被牛Charger抓住，返回true 
 */
function VSLib::Player::IsCarryVictim()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return (GetNetPropInt( "m_carryAttacker" ) > 0) ? true : false;
}

/**
 * 如果玩家被牛Charger击打，返回true
 */
function VSLib::Player::IsPummelVictim()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return (GetNetPropInt( "m_pummelAttacker" ) > 0) ? true : false;
}

/**
 * 如果玩家处于ghost模式(即受感染的ghost)，返回true.
 */
function VSLib::Player::IsGhost()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return _ent.IsGhost();
}

/**
 * 如果玩家平静的，返回true
 */
function VSLib::Player::IsCalm()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isCalm" );
}

/**
 * 如果玩家将要死亡，返回true.
 */
function VSLib::Player::IsGoingToDie()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isGoingToDie" );
}

/**
 * 如果玩家是第一个进入救援车,返回true, DirectorOptions.cm_FirstManOut = 1.
 */
function VSLib::Player::IsFirstManOut()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_bIsFirstManOut" );
}

/**
 * 如果玩家有可见的威胁，返回true
 */
function VSLib::Player::HasVisibleThreats()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_hasVisibleThreats" );
}

/**
 * 如果启用幸存者的辉光，返回true.
 */
function VSLib::Player::IsSurvivorGlowEnabled()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_bSurvivorGlowEnabled" );
}

/**
 * 如果幸存者的武器被藏起来，返回真值.
 */
function VSLib::Player::IsSurvivorPositionHidingWeapons()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_bSurvivorPositionHidingWeapons" );
}

/**
 * 如果幸存者在说话，返回true.
 */
function VSLib::Player::IsSpeaking( sceneFile = "" )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	foreach( scene in ::VSLib.EasyLogic.Objects.OfClassname("instanced_scripted_scene") )
	{
		if ( scene.GetNetPropEntity("m_hOwner").GetEntityHandle() == _ent.GetEntityHandle() )
		{
			if ( sceneFile == "" )
				return true;
			else
			{
				if ( scene.GetNetPropString("m_iszSceneFile").find(sceneFile) != null )
					return true;
			}
		}
	}
	
	return false;
}

/**
 * 如果玩家处于noclip穿墙模式，返回true.
 */
function VSLib::Player::IsNoclipping()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if ( GetNetPropInt( "movetype" ) == 8 )
		return true;
	else
		return false;
}

/**
 * 返回玩家有效武器 VSLib::Entity.
 */
function VSLib::Player::GetActiveWeapon()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return null;
	}
	
	return ::VSLib.Entity(_ent.GetActiveWeapon());
}

/**
 * 返回玩家最后武器VSLib::Entity.
 */
function VSLib::Player::GetLastWeapon()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return null;
	}
	
	return GetNetPropEntity( "m_hLastWeapon" );
}

/**
 * 恢复特殊感染的能力。
 */
function VSLib::Player::GetAbility()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return null;
	}
	
	return GetNetPropEntity( "m_customAbility" );
}

/**
 * 返回玩家的视图模型viewmodel.
 */
function VSLib::Player::GetViewModel()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return null;
	}
	
	return GetNetPropEntity( "m_hViewModel" );
}

/**
 * 返回玩家的发声主题.
 */
function VSLib::Player::GetVocalizationSubject()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return null;
	}
	
	return GetNetPropEntity( "m_vocalizationSubject" );
}

/**
 * 返回玩家死亡后的时间。
 */
function VSLib::Player::GetTimeSinceDeath()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local time = GetNetPropFloat( "m_flDeathTime" );
	
	if (time <= 0.0)
		return time;
	
	return Time() - time;
}

/**
 * 返回玩家的队伍。
 */
function VSLib::Player::GetVersusTeam()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return GetNetPropInt( "m_iVersusTeam" );
}

/**
 * 获得人类坦克的挫败感.
 */
function VSLib::Player::GetFrustration()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return GetNetPropInt( "m_frustration" );
}

/**
 * 返回观看此机器人的玩家.
 */
function VSLib::Player::GetHumanSpectator()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (!IsHumanSpectating())
		return null;
	
	return ::VSLib.Utils.GetPlayerFromUserID(GetNetPropInt( "m_humanSpectatorUserID" ));
}

/**
 * 如果玩家正在观看这个机器人，返回true.
 */
function VSLib::Player::IsHumanSpectating()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetNetPropInt( "m_humanSpectatorUserID" ) < 1)
		return false;
	
	return true;
}

/**
 * 如果玩家在战役第一张地图的起始区域，返回true.
 */
function VSLib::Player::IsInMissionStartArea()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_isInMissionStartArea" );
}

/**
 * 如果玩家目前在结束的安全室，返回true.
 */
function VSLib::Player::IsInEndingSafeRoom()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_inSafeRoom" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._inSafeRoom;
	
	return false;
}

/**
 * 获取玩家的衍生位置
 */
function VSLib::Player::GetSpawnLocation()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_startPos" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._startPos;
	
	return null;
}

/**
 * 如果玩家仍然在起始区域附近，返回true.
 * 注意，他们可以在安全室外面，仍然在开始区域附近
 * 如果它们靠近最初生成的位置, 则该函数将返回 true
 * 
 */
function VSLib::Player::IsNearStartingArea()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local startVec = GetSpawnLocation();
	if (!startVec)
		return false;
	
	local curpos = GetLocation();
	if (!curpos)
		return false;
	
	return ::VSLib.Utils.CalculateDistance(curpos, startVec) < 600.0;
}

/**
 * 返回玩家的最后一个攻击者（最后一个伤害该玩家的人）.
 * 如果“攻击者”是世界或其他一些无效对象，则返回Null.
 */
function VSLib::Player::GetLastAttacker()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_lastAttacker" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._lastAttacker;
	
	return null;
}

/**
 * 如果玩家在本轮获得某种奖励，则返回true.
 * 例如，第67个奖项是指一个玩家保护另一个玩家. 
 * 如果你有奖励HasAward(67), 且仅当玩家在那个回合保护了另一个玩家时，函数将返回true
 * 所以，你问，我怎么知道哪个数字是什么?好问题!试验和错误.
 * 使用EasyLogic.Notifications.OnAwarded 当您在玩游戏时，
 * 可以在奖励的挂钩上找到什么奖励。
 * 然后，使用您发现的编号来执行您所需的操作。
 * 您可能认为这听起来很复杂，
 * 但是使用VSLib比不使用VSLib更容易。.
 */
function VSLib::Player::HasAward(award)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local idx = GetIndex();
	if ("Awards" in ::VSLib.EasyLogic.Cache[idx])
		if (award in ::VSLib.EasyLogic.Cache[idx].Awards)
			return true;
	
	return false;
}

/**
 * Returns the entity or player that last killed this player. If this player
 * has not been killed yet or the killer is an invalid object, returns null.
 */
function VSLib::Player::GetLastKilledBy()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_lastKilledBy" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._lastKilledBy;
	
	return null;
}

/**
 * 返回上次杀死该玩家的实体或玩家.
 * 如果这个玩家还没有被杀死，或者杀手是一个无效的对象，返回null.
 */
function VSLib::Player::GetLastDefibbedBy()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_lastDefibBy" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._lastDefibBy;
	
	return null;
}

/**
 * 返回最后一名玩家的实体或玩家. 
 * 如果这个玩家还没有被推开，返回null.
 */
function VSLib::Player::GetLastShovedBy()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_lastShovedBy" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._lastShovedBy;
	
	return null;
}

/**
 * 返回该玩家最后尝试“Use”使用的实体.
 * 如果玩家还没有尝试使用任何东西，返回null.
 */
function VSLib::Player::GetLastUsed()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_lastUse" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.Entity(::VSLib.EasyLogic.Cache[_idx]._lastUse._ent);
	
	return null;
}

/**
 *返回此玩家使用的最后一项技能。
 *例如 “ability_lunge”或“ability_tongue”或“ability_vomit”或“ability_charge”或“ability_spit”或“ability_ride”
 *例如 “能力冲刺”或“能力舌头”或“能力呕吐”或“能力充电”或“能力冲刺”或“能力驾驶”
 *此功能仅适用于SI。
 */
function VSLib::Player::GetLastAbilityUsed()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetTeam() != INFECTED)
		return null;
	
	if ("_lastAbility" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._lastAbility;
	
	return null;
}

/**
 * 返回当前攻击者的玩家实体，如果没有攻击该玩家的实体，则返回null
 * 注意，这个函数只返回当前的hunter，smoker, charger, 或 jockey 攻击. 
 * Boomer, tank, 和 spitter 不能"continuously"持续困住幸存者和攻击 
 * 因此它们将不会被返回。如果没有SI攻击该玩家，
 * 然后将返回null。此功能仅适用于幸存者。
 */
function VSLib::Player::GetCurrentAttacker()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetTeam() != SURVIVORS)
		return null;
	
	if ("_curAttker" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._curAttker;
	
	return null;
}
	
/**
 * 如果幸存者玩家被一个SI攻击者(如smoker、hunter, charger,或jockey)困住,
 * 返回true.
 */
function VSLib::Player::IsSurvivorTrapped()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return GetTeam() == SURVIVORS && GetCurrentAttacker() != null;
}


/**
 * 返回玩家的类型。例如 Z_SPITTER, Z_TANK, Z_SURVIVOR, Z_HUNTER, Z_JOCKEY, Z_SMOKER, Z_BOOMER, Z_CHARGER, 或者 UNKNOWN.
 */
function VSLib::Player::GetPlayerType()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return UNKNOWN;
	}
	
	if (!("GetZombieType" in _ent))
		return UNKNOWN;
	
	return _ent.GetZombieType();
}

/**
 * 如果在玩家的当前强制按钮中存在按钮，则返回true.
 */
function VSLib::Player::HasForcedButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonForced" );
	
	return buttons == ( buttons | button );
}

/**
 * 将按钮添加到玩家当前的强制按钮中。
 */
function VSLib::Player::ForceButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonForced" );
	
	if ( HasForcedButton(button) )
		return;
	
	SetNetProp( "m_afButtonForced", ( buttons | button ) );
}

/**
 * 从玩家当前的强制按钮中移除按钮。
 */
function VSLib::Player::UnforceButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonForced" );
	
	if ( !HasForcedButton(button) )
		return;
	
	SetNetProp( "m_afButtonForced", ( buttons & ~button ) );
}

/**
 * 如果该按钮存在于玩家当前禁用的按钮中，则返回true。
 */
function VSLib::Player::HasDisabledButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonDisabled" );
	
	return buttons == ( buttons | button );
}

/**
 * 将按钮添加到玩家的当前禁用按钮。
 */
function VSLib::Player::DisableButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonDisabled" );
	
	if ( HasDisabledButton(button) )
		return;
	
	SetNetProp( "m_afButtonDisabled", ( buttons | button ) );
}

/**
 * 从玩家当前禁用的按钮中删除按钮。
 */
function VSLib::Player::EnableButton( button )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local buttons = GetNetPropInt( "m_afButtonDisabled" );
	
	if ( !HasDisabledButton(button) )
		return;
	
	SetNetProp( "m_afButtonDisabled", ( buttons & ~button ) );
}

/**
 * Incaps 倒地晕昏玩家
 */
function VSLib::Player::Incapacitate( dmgtype = 0, attacker = null )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (IsIncapacitated())
		return;
	
	Damage(GetHealth(), dmgtype, attacker);
	
	if ( !IsIncapacitated() && Entities.FindByClassname( null, "worldspawn" ) )
		Damage(GetHealth(), dmgtype, ::VSLib.Entity("worldspawn"));
}

/**
 * 杀死玩家.
 */
function VSLib::Player::Kill( dmgtype = 0, attacker = null )
{
	if (IsPlayerEntityValid())
	{
		if ( _ent.IsSurvivor() )
			SetLastStrike();
		Damage(GetHealth(), dmgtype, attacker);
		
		if ( IsAlive() && Entities.FindByClassname( null, "worldspawn" ) )
			Damage(GetHealth(), dmgtype, ::VSLib.Entity("worldspawn"));
	}
	else
		base.Kill();
}

/**
 * Ragdolls布娃娃，玩家
 */
function VSLib::Player::Ragdoll( allowDefib = false )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	local origin = GetLocation();
	local angles = GetEyeAngles();
	
	local function VSLib_RemoveDeathModel( args )
	{
		args.player.GetSurvivorDeathModel().KillEntity();
		local ragdoll = ::VSLib.Utils.SpawnRagdoll( args.model, args.origin, args.angles );
		
		if ( args.allowDefib )
		{
			local deathModel = ::VSLib.Utils.CreateEntity("survivor_death_model", ragdoll.GetLocation());
			deathModel.SetNetProp("m_nCharacterType", args.player.GetSurvivorCharacter());
			ragdoll.AttachOther(deathModel, false);
			::VSLib.EasyLogic.SurvivorRagdolls.rawset(args.player.GetIndex(), {});
			::VSLib.EasyLogic.SurvivorRagdolls[args.player.GetIndex()]["Ragdoll"] <- ragdoll;
		}
	}
	
	if ( GetTeam() == 4 )
	{
		Input( "Kill" );
		::VSLib.Utils.SpawnRagdoll( GetModel(), origin, angles );
	}
	else
	{
		if ( IsAlive() )
			Kill();
		if ( GetSurvivorDeathModel() != null )
			VSLib_RemoveDeathModel( { player = this, origin = origin, angles = angles, model = GetModel(), allowDefib = allowDefib } );
		else
			::VSLib.Timers.AddTimer(0.1, false, VSLib_RemoveDeathModel, { player = this, origin = origin, angles = angles, model = GetModel(), allowDefib = allowDefib });
	}
}

/**
 * 向玩家显示提示.
 */
function VSLib::Player::ShowHint( text, duration = 5, icon = "icon_tip", binding = "", color = "255 255 255", pulsating = 0, alphapulse = 0, shaking = 0 )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	duration = duration.tofloat();
	if ( binding != "" )
		icon = "use_binding";
	
	local hinttbl =
	{
		hint_allow_nodraw_target = "1",
		hint_alphaoption = alphapulse,
		hint_auto_start = "0",
		hint_binding = binding,
		hint_caption = text.tostring(),
		hint_color = color,
		hint_forcecaption = "0",
		hint_icon_offscreen = icon,
		hint_icon_offset = "0",
		hint_icon_onscreen = icon,
		hint_instance_type = "2",
		hint_nooffscreen = "0",
		hint_pulseoption = pulsating,
		hint_range = "0",
		hint_shakeoption = shaking,
		hint_static = "1",
		hint_target = "",
		hint_timeout = duration,
		targetname = "vslib_tmp_" + UniqueString(),
	};
	
	local hint = ::VSLib.Utils.CreateEntity("env_instructor_hint", Vector(0, 0, 0), QAngle(0, 0, 0), hinttbl);
	
	hint.Input("ShowHint", "", 0, this);
	
	if ( duration > 0 )
		hint.Input("Kill", "", duration);
}

/**
 * 如果此玩家可以在他们的视野中看到输入的位置，则返回true。
 * 
 * @param pos         你想要检查的向量位置，如果玩家可以看到.
 * @param tolerance   结果的公差。75是默认的视域.
 */
function VSLib::Player::CanSeeLocation(targetPos, tolerance = 50)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local clientPos = GetEyePosition();
	local clientToTargetVec = targetPos - clientPos;
	local clientAimVector = GetEyeAngles().Forward();
	
	local angToFind = acos(::VSLib.Utils.VectorDotProduct(clientAimVector, clientToTargetVec) / (clientAimVector.Length() * clientToTargetVec.Length())) * 360 / 2 / 3.14159265;
	
	if (angToFind < tolerance)
		return true;
	else
		return false;
}

/**
 * 如果玩家能看到输入的实体，返回true.
 */
function VSLib::Player::CanSeeOtherEntity(otherEntity, tolerance = 50)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	// 首先检查玩家是否朝它的方向看
	if (!CanSeeLocation(otherEntity.GetLocation(), tolerance))
		return false;
	
	// 接下来检查一下，确保它不是在墙后面或者其他什么地方
	local m_trace = { start = GetEyePosition(), end = otherEntity.GetLocation(), ignore = _ent, mask = TRACE_MASK_SHOT };
	TraceLine(m_trace);
	
	if (!m_trace.hit || m_trace.enthit == null || m_trace.enthit == _ent)
		return false;
	
	if (m_trace.enthit.GetClassname() == "worldspawn" || !m_trace.enthit.IsValid())
		return false;
		
	if (m_trace.enthit == otherEntity.GetBaseEntity())
		return true;
	
	return false;
}

/**
 * 如果玩家能从眼睛追踪到指定地点，返回true。
 */
function VSLib::Player::CanTraceToLocation(finishPos, traceMask = MASK_NPCWORLDSTATIC)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local begin = GetEyePosition();
	local finish = finishPos;
	
	local m_trace = { start = begin, end = finish, ignore = _ent, mask = traceMask };
	TraceLine(m_trace);
	
	if (::VSLib.Utils.AreVectorsEqual(m_trace.pos, finish))
		return true;
	
	return false;
}

/**
 * 向玩家实体发送客户端命令。.
 * \todo @TODO 不能工作，需要修复.
 */
function VSLib::Player::ClientCommand(str)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local cl_cmd = ::VSLib.Utils.CreateEntity( "point_clientcommand", GetLocation() );
	if (!cl_cmd)
	{
		printf("VSLib Error: Could not exec cl_cmd; entity is invalid!");
		return;
	}
	if (!cl_cmd.IsEntityValid())
	{
		printf("VSLib Error: Could not exec cl_cmd; entity is invalid!");
		return;
	}
	cl_cmd.Input("Command", str, 0, _ent);
	cl_cmd.Kill();
}

/**
 * 手电筒的状态变化。
 */
function VSLib::Player::SetFlashlight(turnFlashOn)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (turnFlashOn)
		SetEffects(4);
	else
		SetEffects(0);
}

/**
 * 设置玩家的健康缓冲
 */
function VSLib::Player::SetHealthBuffer(value)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.SetHealthBuffer(value);
}

/**
 * 将幸存者的健康状况从永久性转换为临时性，反之亦然。
 */
function VSLib::Player::SwitchHealth(hpType = "")
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || typeof hpType != "string")
		return;
	
	hpType = hpType.tolower();
	
	if ( hpType.find("perm") != null )
	{
		SetRawHealth(GetHealth());
		SetHealthBuffer(0);
	}
	else if ( hpType.find("temp") != null )
	{
		SetHealthBuffer(GetHealth());
		SetRawHealth(1);
	}
	else
	{
		if ( GetRawHealth() > 1 )
		{
			SetHealthBuffer(GetHealth());
			SetRawHealth(1);
		}
		else
		{
			SetRawHealth(GetHealth());
			SetHealthBuffer(0);
		}
	}
}

/**
 * 设定玩家的摩擦力。
 */
function VSLib::Player::SetFriction(value)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.SetFriction(value);
}

/**
 * 设置玩家的重力。
 */
function VSLib::Player::SetGravity(value)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.SetGravity(value);
}

/**
 * 把武器从槽里扔出来
 *
 * 你可以使用全局常量 SLOT_PRIMARY, SLOT_SECONDARY, SLOT_THROW,
 * SLOT_MEDKIT (也适用于除颤器defibs), SLOT_PILLS (也适用于肾上腺素adrenaline)
 */
function VSLib::Player::DropWeaponSlot(slot)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ( slot != "Held" )
		slot = "slot" + slot;
	local t = GetHeldItems();
	
	if (t && slot in t)
		t[slot].Kill();
}

/**
 * 落下所有持有的武器
 */
function VSLib::Player::DropAllWeapons()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	
	local t = GetHeldItems();
	
	if (t)
		foreach (ent in t)
			ent.Kill();
}

/**
 * 获取玩家的健康缓冲.
 */
function VSLib::Player::GetHealthBuffer()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return _ent.GetHealthBuffer();
}

/**
 * 获得玩家的valve库存(molotov, weapons, pills, etc).
 */
function VSLib::Player::GetHeldItems()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = {};
	local table = {};
	GetInvTable(_ent, table);
	
	foreach( slot, item in table )
		t[slot] <- ::VSLib.Entity(item);
	
	return t;
}

/**
 * 获取该玩家最后死亡的位置，如果该玩家尚未死亡，则为null
 */
function VSLib::Player::GetLastDeathLocation()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_deathPos" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._deathPos;
}

/**
 * 设置玩家的复活计数
 */
function VSLib::Player::SetReviveCount(count)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.SetReviveCount(count);
}

/**
 * 获得玩家的复活计数
 */
function VSLib::Player::GetReviveCount()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return GetNetPropInt( "m_currentReviveCount" );
}

/**
 * 计算幸存者丧失行动能力的次数
 */
function VSLib::Player::GetIncapacitatedCount()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return GetReviveCount();
}

/**
 * 如果幸存者是黑白的，则返回true
 */
function VSLib::Player::IsLastStrike()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	return GetReviveCount() == ::VSLib.Utils.GetMaxIncapCount();
}

/**
 * 让玩家变成黑白的
 */
function VSLib::Player::SetLastStrike()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	SetReviveCount(::VSLib.Utils.GetMaxIncapCount());
}

/**
 * 复活玩家(同时检查玩家是否首次倒地).
 * 如果玩家复活，返回true.
 */
function VSLib::Player::Revive()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (IsIncapacitated())
	{
		_ent.ReviveFromIncap();
		return true;
	}
	
	return false;
}

/**
*给死去的玩家使用除颤器(同时检查玩家是否首次死亡)。
*如果玩家使用除颤器，返回true。
 */
function VSLib::Player::Defib()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (IsDead() || IsDying())
	{
		_ent.ReviveByDefib();
		
		local idx = GetIndex();
		if ( idx in ::VSLib.EasyLogic.SurvivorRagdolls )
		{
			::VSLib.EasyLogic.SurvivorRagdolls[idx]["Ragdoll"].Kill();
			::VSLib.EasyLogic.SurvivorRagdolls.rawdelete(idx);
		}
		
		foreach (func in ::VSLib.EasyLogic.Notifications.OnScriptDefib)
			func(this);
		
		return true;
	}
	
	return false;
}

/**
 * 如果玩家当前在救援壁橱中，返回true。
 */
function VSLib::Player::IsInCloset()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return false;
	
	foreach( rescue in ::VSLib.EasyLogic.Objects.OfClassname("info_survivor_rescue") )
	{
		local survivor = rescue.GetNetPropEntity( "m_survivor" );
		
		if ( survivor != null )
		{
			if ( survivor.GetEntityHandle() == _ent.GetEntityHandle() )
				return true;
		}
	}
	
	return false;
}

/**
 * Rescues a player from a rescue closet.
 * Returns true if the player was successfully rescued.
 */
function VSLib::Player::Rescue()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return false;
	
	foreach( rescue in ::VSLib.EasyLogic.Objects.OfClassname("info_survivor_rescue") )
	{
		local survivor = rescue.GetNetPropEntity( "m_survivor" );
		
		if ( survivor != null )
		{
			if ( survivor.GetEntityHandle() == _ent.GetEntityHandle() )
			{
				rescue.Input( "Rescue" );
				return true;
			}
		}
	}
	
	return false;
}


/**
 * Gets the last player who vomited this player, or returns null if the player
 * has not been vomited on yet OR has not been vomited on by a valid player
 */
function VSLib::Player::GetLastVomitedBy()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if(_idx in ::VSLib.EasyLogic.Cache)
		if ("_lastVomitedBy" in ::VSLib.EasyLogic.Cache[_idx])
			return ::VSLib.EasyLogic.Cache[_idx]._lastVomitedBy;
}

/**
 * Returns true if this player was ever vomited this round
 */
function VSLib::Player::WasEverVomited()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if(_idx in ::VSLib.EasyLogic.Cache)
		if ("_wasVomited" in ::VSLib.EasyLogic.Cache[_idx])
			return ::VSLib.EasyLogic.Cache[_idx]._wasVomited;
	
	return false;
}

/**
 * Staggers this entity
 */
function VSLib::Player::Stagger()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.Stagger( Vector(0,0,0) );
}

/**
 * Staggers this entity away from another entity
 */
function VSLib::Player::StaggerAwayFromEntity(otherEnt)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local loc = otherEnt.GetLocation();
	if (loc != null) _ent.Stagger( loc );
}

/**
 * Staggers this entity away from another location
 */
function VSLib::Player::StaggerAwayFromLocation(loc)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.Stagger( loc );
}

/**
 * Gives the player an upgrade
 */
function VSLib::Player::GiveUpgrade(upgrade)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.GiveUpgrade( upgrade ) ;
}

/**
 * Removes the player's upgrade
 */
function VSLib::Player::RemoveUpgrade(upgrade)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.RemoveUpgrade( upgrade ) ;
}

/**
 * Returns true if the player is a tank and is frustrated
 */
function VSLib::Player::IsFrustrated()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_TANK)
		return false;
	
	if(_idx in ::VSLib.EasyLogic.Cache)
		if ("_isFrustrated" in ::VSLib.EasyLogic.Cache[_idx])
			return ::VSLib.EasyLogic.Cache[_idx]._isFrustrated;
}

/**
 * Returns true if the player is a female boomer
 */
function VSLib::Player::IsBoomette()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_BOOMER)
		return false;
	
	if ("_isBoomette" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._isBoomette;
	
	return false;
}

/**
 * Returns true if the boomer is a leaker
 */
function VSLib::Player::IsLeaker()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	if (GetPlayerType() != Z_BOOMER)
		return false;
	
	if ("_isLeaker" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._isLeaker;
	
	return false;
}

/**
 * Gives the entity an adrenaline effect
 */
function VSLib::Player::GiveAdrenaline( time )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.UseAdrenaline( time ) ;
}

/**
 * Returns true if the survivor is currently under the effect of adrenaline
 */
function VSLib::Player::IsAdrenalineActive()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_bAdrenalineActive" );
}

/**
 * Returns true if the player was present at the start of the survival round
 */
function VSLib::Player::WasPresentAtSurvivalStart()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_bWasPresentAtSurvivalStart" );
}

/**
 * Returns true if the player is currently using a mounted gun
 */
function VSLib::Player::IsUsingMountedGun()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	return GetNetPropBool( "m_usingMountedGun" ) || GetNetPropBool( "m_usingMountedWeapon" );
}

/**
 * Gets the userid of the player
 */
function VSLib::Player::GetUserID()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return _ent.GetPlayerUserId();
}

/**
 * Gets the survivor slot
 */
function VSLib::Player::GetSurvivorSlot()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return _ent.GetSurvivorSlot();
}

/**
 * Gets the survivor_death_model associated with the survivor
 */
function VSLib::Player::GetSurvivorDeathModel()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return null;
	
	foreach( death_model in ::VSLib.EasyLogic.Objects.OfClassname("survivor_death_model") )
	{
		if ( death_model.GetNetPropInt("m_nCharacterType") == GetNetPropInt("m_survivorCharacter") )
			return death_model;
	}
	
	return null;
}

/**
 * Get the survivor's current intensity value
 */
function VSLib::Player::GetIntensity()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	return GetNetPropInt( "m_clientIntensity" );
}

/**
 * Vomits on the player
 */
function VSLib::Player::Vomit( duration = null )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.HitWithVomit();
	if ( duration != null )
		SetNetProp( "m_itTimer.m_timestamp", Time() + duration.tofloat() );
}

/**
 * Gives ammo
 */
function VSLib::Player::GiveAmmo( amount )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.GiveAmmo(amount.tointeger());
}

/**
 * Gets the player's max primary ammo
 */
function VSLib::Player::GetMaxPrimaryAmmo()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		return t["slot0"].GetMaxAmmo();
	}
}

/**
 * Gets the player's primary ammo
 */
function VSLib::Player::GetPrimaryAmmo()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		return t["slot0"].GetAmmo();
	}
}

/**
 * Sets the player's primary ammo
 */
function VSLib::Player::SetPrimaryAmmo( amount )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		SetNetProp( "m_iAmmo", amount.tointeger(), t["slot0"].GetNetPropInt( "m_iPrimaryAmmoType" ) );
	}
}

/**
 * Gets the player's primary ammo
 */
function VSLib::Player::GetPrimaryClip()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		return t["slot0"].GetClip();
	}
}

/**
 * Sets the player's primary ammo
 */
function VSLib::Player::SetPrimaryClip( amount )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		t["slot0"].SetNetProp( "m_iClip1", amount.tointeger() );
	}
}

/**
 * Gets the player's current primary upgrades
 */
function VSLib::Player::GetPrimaryUpgrades()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		return t["slot0"].GetUpgrades();
	}
}

/**
 * Sets the player's current primary upgrades
 */
function VSLib::Player::SetPrimaryUpgrades( amount )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		t["slot0"].SetUpgrades( amount );
	}
}

/**
 * Returns true if the upgrade exists in the player's current primary upgrades
 */
function VSLib::Player::HasPrimaryUpgrade( upgrade )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		return t["slot0"].HasUpgrade( upgrade );
	}
}

/**
 * Adds the upgrade to the player's current primary upgrades
 */
function VSLib::Player::AddPrimaryUpgrade( upgrade )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		t["slot0"].AddUpgrade( upgrade );
	}
}

/**
 * Removes the upgrade from the player's current primary upgrades
 */
function VSLib::Player::RemovePrimaryUpgrade( upgrade )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
	{
		t["slot0"].RemoveUpgrade( upgrade );
	}
}

/**
 * Get the amount of zombies the survivor has killed
 */
function VSLib::Player::GetZombiesKilled()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ( !("_zombiesKilled" in ::VSLib.EasyLogic.Cache[_idx]) )
		return 0;
	
	return ::VSLib.EasyLogic.Cache[_idx]._zombiesKilled;
}

/**
 * Get the amount of zombies the survivor has killed while being incapacitated
 */
function VSLib::Player::GetZombiesKilledWhileIncapacitated()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ( !("_zombiesKilledWhileIncapacitated" in ::VSLib.EasyLogic.Cache[_idx]) )
		return 0;
	
	return ::VSLib.EasyLogic.Cache[_idx]._zombiesKilledWhileIncapacitated;
}

/**
 * Gets a valid path point within a radius
 */
function VSLib::Player::GetNearbyLocation( radius )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return _ent.TryGetPathableLocationWithin(radius);
}

/**
 * Gets flow distance
 */
function VSLib::Player::GetFlowDistance()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return g_MapScript.GetCurrentFlowDistanceForPlayer(_ent);
}

/**
 * Gets flow percent
 */
function VSLib::Player::GetFlowPercent()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return g_MapScript.GetCurrentFlowPercentForPlayer(_ent);
}

/**
 * Gets the client convar as a string.
 * Only works with client convars with the FCVAR_USERINFO flag.
 */
function VSLib::Player::GetClientConvarValue( name )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	return Convars.GetClientConvarValue(name, _idx);
}

/**
 * Gets the player's current stats.
 */
function VSLib::Player::GetStats()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = {};
	
	t["m_checkpointAwardCounts"] <- GetNetPropInt("m_checkpointAwardCounts");
	t["m_missionAwardCounts"] <- GetNetPropInt("m_missionAwardCounts");
	t["m_checkpointZombieKills"] <- GetNetPropInt("m_checkpointZombieKills");
	t["m_missionZombieKills"] <- GetNetPropInt("m_missionZombieKills");
	t["m_checkpointSurvivorDamage"] <- GetNetPropInt("m_checkpointSurvivorDamage");
	t["m_missionSurvivorDamage"] <- GetNetPropInt("m_missionSurvivorDamage");
	t["m_checkpointMedkitsUsed"] <- GetNetPropInt("m_checkpointMedkitsUsed");
	t["m_missionMedkitsUsed"] <- GetNetPropInt("m_missionMedkitsUsed");
	t["m_checkpointPillsUsed"] <- GetNetPropInt("m_checkpointPillsUsed");
	t["m_missionPillsUsed"] <- GetNetPropInt("m_missionPillsUsed");
	t["m_checkpointMolotovsUsed"] <- GetNetPropInt("m_checkpointMolotovsUsed");
	t["m_missionMolotovsUsed"] <- GetNetPropInt("m_missionMolotovsUsed");
	t["m_checkpointPipebombsUsed"] <- GetNetPropInt("m_checkpointPipebombsUsed");
	t["m_missionPipebombsUsed"] <- GetNetPropInt("m_missionPipebombsUsed");
	t["m_checkpointBoomerBilesUsed"] <- GetNetPropInt("m_checkpointBoomerBilesUsed");
	t["m_missionBoomerBilesUsed"] <- GetNetPropInt("m_missionBoomerBilesUsed");
	t["m_checkpointAdrenalinesUsed"] <- GetNetPropInt("m_checkpointAdrenalinesUsed");
	t["m_missionAdrenalinesUsed"] <- GetNetPropInt("m_missionAdrenalinesUsed");
	t["m_checkpointDefibrillatorsUsed"] <- GetNetPropInt("m_checkpointDefibrillatorsUsed");
	t["m_missionDefibrillatorsUsed"] <- GetNetPropInt("m_missionDefibrillatorsUsed");
	t["m_checkpointDamageTaken"] <- GetNetPropInt("m_checkpointDamageTaken");
	t["m_missionDamageTaken"] <- GetNetPropInt("m_missionDamageTaken");
	t["m_checkpointReviveOtherCount"] <- GetNetPropInt("m_checkpointReviveOtherCount");
	t["m_missionReviveOtherCount"] <- GetNetPropInt("m_missionReviveOtherCount");
	t["m_checkpointFirstAidShared"] <- GetNetPropInt("m_checkpointFirstAidShared");
	t["m_missionFirstAidShared"] <- GetNetPropInt("m_missionFirstAidShared");
	t["m_checkpointIncaps"] <- GetNetPropInt("m_checkpointIncaps");
	t["m_missionIncaps"] <- GetNetPropInt("m_missionIncaps");
	t["m_checkpointDamageToTank"] <- GetNetPropInt("m_checkpointDamageToTank");
	t["m_checkpointDamageToWitch"] <- GetNetPropInt("m_checkpointDamageToWitch");
	t["m_missionAccuracy"] <- GetNetPropInt("m_missionAccuracy");
	t["m_checkpointHeadshots"] <- GetNetPropInt("m_checkpointHeadshots");
	t["m_checkpointHeadshotAccuracy"] <- GetNetPropInt("m_checkpointHeadshotAccuracy");
	t["m_missionHeadshotAccuracy"] <- GetNetPropInt("m_missionHeadshotAccuracy");
	t["m_checkpointDeaths"] <- GetNetPropInt("m_checkpointDeaths");
	t["m_missionDeaths"] <- GetNetPropInt("m_missionDeaths");
	t["m_checkpointMeleeKills"] <- GetNetPropInt("m_checkpointMeleeKills");
	t["m_missionMeleeKills"] <- GetNetPropInt("m_missionMeleeKills");
	t["m_checkpointPZIncaps"] <- GetNetPropInt("m_checkpointPZIncaps");
	t["m_checkpointPZTankDamage"] <- GetNetPropInt("m_checkpointPZTankDamage");
	t["m_checkpointPZHunterDamage"] <- GetNetPropInt("m_checkpointPZHunterDamage");
	t["m_checkpointPZSmokerDamage"] <- GetNetPropInt("m_checkpointPZSmokerDamage");
	t["m_checkpointPZBoomerDamage"] <- GetNetPropInt("m_checkpointPZBoomerDamage");
	t["m_checkpointPZJockeyDamage"] <- GetNetPropInt("m_checkpointPZJockeyDamage");
	t["m_checkpointPZSpitterDamage"] <- GetNetPropInt("m_checkpointPZSpitterDamage");
	t["m_checkpointPZChargerDamage"] <- GetNetPropInt("m_checkpointPZChargerDamage");
	t["m_checkpointPZKills"] <- GetNetPropInt("m_checkpointPZKills");
	t["m_checkpointPZPounces"] <- GetNetPropInt("m_checkpointPZPounces");
	t["m_checkpointPZPushes"] <- GetNetPropInt("m_checkpointPZPushes");
	t["m_checkpointPZTankPunches"] <- GetNetPropInt("m_checkpointPZTankPunches");
	t["m_checkpointPZTankThrows"] <- GetNetPropInt("m_checkpointPZTankThrows");
	t["m_checkpointPZHung"] <- GetNetPropInt("m_checkpointPZHung");
	t["m_checkpointPZPulled"] <- GetNetPropInt("m_checkpointPZPulled");
	t["m_checkpointPZBombed"] <- GetNetPropInt("m_checkpointPZBombed");
	t["m_checkpointPZVomited"] <- GetNetPropInt("m_checkpointPZVomited");
	t["m_checkpointPZHighestDmgPounce"] <- GetNetPropInt("m_checkpointPZHighestDmgPounce");
	t["m_checkpointPZLongestSmokerGrab"] <- GetNetPropInt("m_checkpointPZLongestSmokerGrab");
	t["m_checkpointPZLongestJockeyRide"] <- GetNetPropInt("m_checkpointPZLongestJockeyRide");
	t["m_checkpointPZNumChargeVictims"] <- GetNetPropInt("m_checkpointPZNumChargeVictims");
	
	return t;
}

/**
 * Returns true if the survivor is healing
 */
function VSLib::Player::IsHealing()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return false;
	
	if ("_isHealing" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._isHealing;
	
	return false;
}

/**
 * Returns true if the survivor is being healed
 */
function VSLib::Player::IsBeingHealed()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return false;
	
	if ("_isBeingHealed" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._isBeingHealed;
	
	return false;
}

/**
 * Returns true if the survivor is in the rescue vehicle.
 */
function VSLib::Player::IsInRescue()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inRescue" in ::VSLib.EasyLogic.Cache[_idx])
		return ::VSLib.EasyLogic.Cache[_idx]._inRescue;
	
	return false;
}

/**
 * Prints a chat message as if this player typed it in chat
 */
function VSLib::Player::Say( str, teamOnly = false )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	g_MapScript.Say(_ent, str.tostring(), teamOnly);
}

/**
 * Plays a sound file to the player
 */
function VSLib::Player::PlaySound( file )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (file == "" || !file)
		return;
	
	if ( !(file in ::EasyLogic.PrecachedSounds) )
	{
		printf("VSLib: Precaching named sound: %s", file);
		_ent.PrecacheScriptSound(file);
		::EasyLogic.PrecachedSounds[file] <- 1;
	}
	
	g_MapScript.EmitSoundOnClient(file, _ent);
}


/**
 * Makes the player speak a scene
 */
function VSLib::Player::Speak( scene, delay = 0 )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	delay = delay.tofloat();
	
	local function SpeakScene( params )
	{
		local Name = params.player.GetActorName();
		local Scene = "";
		
		if ( params.scene.find("scenes") != null )
		{
			if ( params.scene.find(".vcd") != null )
				Scene = params.scene;
			else
				Scene = params.scene + ".vcd";
		}
		else
		{
			if ( params.scene.find(".vcd") != null )
				Scene = "scenes/" + Name + "/" + params.scene;
			else
				Scene = "scenes/" + Name + "/" + params.scene + ".vcd";
		}
		
		local vsl_speak =
		[
			{
				name = "VSLibScene",
				criteria =
				[
					[ "Concept", "VSLibScene" ],
					[ "Coughing", 0 ],
					[ "Who", Name ],
				],
				responses =
				[
					{
						scenename = Scene,
					}
				],
				group_params = ::VSLib.ResponseRules.GroupParams({ permitrepeats = true, sequential = false, norepeat = false })
			},
		]
		ResponseRules.ProcessRules( vsl_speak );
		
		params.player.Input("SpeakResponseConcept", "VSLibScene");
	}
	
	if ( delay > 0 )
		::VSLib.Timers.AddTimer(delay, false, SpeakScene { scene = scene, player = this });
	else
		SpeakScene( { scene = scene, player = this } );
}

/**
 * Gives a random melee weapon.
 */
function VSLib::Player::GiveRandomMelee( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local melee = ::VSLib.Entity(g_ModeScript.SpawnMeleeWeapon( "any", Vector(0,0,0), QAngle(0,0,0) ));
	Use(melee);
	melee.Input("Kill");
}

/**
 * The "give" concommand.
 *
 * @param str What to give the entity (for example, "health")
 */
function VSLib::Player::Give(str)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	_ent.GiveItem(str);
}

/**
 * Removes a player's weapon.
 */
function VSLib::Player::Remove(str)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t)
	{
		foreach (item in t)
		{
			if ( item.GetClassname() == str || item.GetClassname() == "weapon_" + str )
				item.Kill();
		}
	}
}

/**
 * Drops a player's weapon
 */
function VSLib::Player::Drop(str = "")
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local wep = "";
	local dummyWep = "";
	local slot = "";
	local t = GetHeldItems();
	
	if ( str != "" )
	{
		if ( (typeof str) == "integer" )
			slot = "slot" + str.tointeger();
		else
		{
			if ( str.find("weapon_") != null )
				wep = str;
			else
				wep = "weapon_" + str;
		}
	}
	else
	{
		if ( GetActiveWeapon() != null )
			wep = GetActiveWeapon().GetClassname();
		else
			return;
	}
	
	if ( slot != "" )
	{
		if (t && slot in t)
			wep = t[slot].GetClassname();
	}
	
	if ( wep == "weapon_pistol" || wep == "weapon_melee" || wep == "weapon_chainsaw" )
		dummyWep = "pistol_magnum";
	else if ( wep == "weapon_pistol_magnum" )
		dummyWep = "pistol";
	else if ( wep == "weapon_first_aid_kit" || wep == "weapon_upgradepack_incendiary" || wep == "weapon_upgradepack_explosive" )
		dummyWep = "defibrillator";
	else if ( wep == "weapon_defibrillator" )
		dummyWep = "first_aid_kit";
	else if ( wep == "weapon_pain_pills" )
		dummyWep = "adrenaline";
	else if ( wep == "weapon_adrenaline" )
		dummyWep = "pain_pills";
	else if ( wep == "weapon_pipe_bomb" || wep == "weapon_vomitjar" )
		dummyWep = "molotov";
	else if ( wep == "weapon_molotov" )
		dummyWep = "pipe_bomb";
	else if ( wep == "weapon_gascan" || wep == "weapon_propanetank" || wep == "weapon_oxygentank" || wep == "weapon_fireworkcrate" || wep == "weapon_cola_bottles" )
		dummyWep = "gnome";
	else if ( wep == "weapon_gnome" )
		dummyWep = "gascan";
	else if ( wep == "weapon_rifle" )
		dummyWep = "smg";
	else
		dummyWep = "rifle";
	
	if (t)
	{
		foreach (item in t)
		{
			if ( item.GetClassname() == wep )
			{
				Give(dummyWep);
				Remove(dummyWep);
				Input( "CancelCurrentScene" );
			}
		}
	}
}

/**
 * Returns true if the player has the item.
 */
function VSLib::Player::HasItem(str)
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t)
	{
		foreach (item in t)
		{
			if ( item.GetClassname() == str || item.GetClassname() == "weapon_" + str )
				return true;
		}
	}
	
	return false;
}

/**
 * Returns true if the player has dual pistols.
 */
function VSLib::Player::HasDualPistols()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ( HasItem( "weapon_pistol" ) )
		return GetHeldItems()["slot1"].GetNetPropBool( "m_hasDualWeapons" );
	
	return false;
}

/**
 * Returns true if the player's primary weapon has a laser sight.
 */
function VSLib::Player::HasLaserSight()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	local t = GetHeldItems();
	
	if (t && "slot0" in t)
		return (t["slot0"].GetNetPropInt( "m_upgradeBitVec" ) & 4) > 0;
	
	return false;
}

/**
 * Get the current state the infected is in
 */
function VSLib::Player::GetInfectedState()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetTeam() != INFECTED)
		return;
	
	return GetNetPropInt( "m_zombieState" );
}





/**
 * Stops Amnesia/HL2 style object pickups
 */
function VSLib::Player::DisablePickups( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (_idx in ::VSLib.EntData._objPickupTimer)
		::VSLib.Timers.RemoveTimer(::VSLib.EntData._objPickupTimer[_idx]);
}

/**
 * Enables Amnesia/HL2 style object pickups
 */
function VSLib::Player::AllowPickups( BTN_PICKUP, BTN_THROW )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	DisablePickups();
	
	::VSLib.EntData._objBtnPickup[_idx] <- BTN_PICKUP;
	::VSLib.EntData._objBtnThrow[_idx] <- BTN_THROW;
	::VSLib.EntData._objOldBtnMask[_idx] <- GetPressedButtons();
	::VSLib.EntData._objHolding[_idx] <- null;
	
	::VSLib.EntData._objPickupTimer[_idx] <- ::VSLib.Timers.AddTimer(0.1, 1, @(pEnt) pEnt.__CalcPickups(), this);
}

/**
 * Instead of using this directly, @see AllowPickups
 */
function VSLib::Player::__CalcPickups( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	// Update global entity cache
	local buttons = GetPressedButtons();
	local OldButtons = ::VSLib.EntData._objOldBtnMask[_idx];
	local btnPickup = ::VSLib.EntData._objBtnPickup[_idx];
	local btnThrow = ::VSLib.EntData._objBtnThrow[_idx];
	local HoldingEntity = ::VSLib.EntData._objHolding[_idx];
	
	// Constants -- \todo @TODO Make these user-configurable
	const DISTANCE_TO_HOLD = 100.0
	const DISTANCE_CLOSE = 256.0;
	const OBJECT_SPEED = 25.0;
	const THROW_SPEED = 1000.0;
	
	// Are they trying to pick up an object?
	if (buttons & btnPickup && !(OldButtons & btnPickup) && HoldingEntity == null && !(buttons & btnThrow) && !IsIncapacitated() && !IsHangingFromLedge())
	{
		// Are they looking at a valid grabbable entity?
		// If so, then cache it.
		local object = GetLookingEntity();
		if (object != null)
			::VSLib.EntData._objHolding[_idx] <- object;
	}
	
	// Are they holding an object?
	else if (buttons & btnPickup && OldButtons & btnPickup && !(buttons & btnThrow) &&
			HoldingEntity != null && !IsIncapacitated() && !IsHangingFromLedge())
	{
		if (HoldingEntity.IsEntityValid())
		{	
			local eyeAngles = GetEyeAngles();
			if (eyeAngles == null) return;
			local vecDir = eyeAngles.Forward();
			
			local vecPos = GetEyePosition();
			if (vecPos == null) return;
			
			local holdPos = HoldingEntity.GetLocation();
			if (holdPos == null) return;
			
			if (::VSLib.Utils.CalculateDistance(vecPos, holdPos) < DISTANCE_CLOSE)
			{
				// update object 
				vecPos.x += vecDir.x * DISTANCE_TO_HOLD;
				vecPos.y += vecDir.y * DISTANCE_TO_HOLD;
				vecPos.z += vecDir.z * DISTANCE_TO_HOLD;
				
				local vecVel = vecPos - holdPos;
				vecVel = vecVel.Scale(OBJECT_SPEED);
				
				HoldingEntity.SetVelocity(vecVel);
			}
			else
			{
				// Entity is no longer valid
				DropPickup();
			}
		}
	}
	// Are they trying to throw the object?
	else if(buttons & btnPickup && OldButtons & btnPickup && buttons & btnThrow && HoldingEntity != null)
	{
		if (HoldingEntity.IsEntityValid())
		{
			// then throw it!
			local eyeAngles = GetEyeAngles();
			if (eyeAngles == null) return;
			local speed = eyeAngles.Forward().Scale(THROW_SPEED);
			HoldingEntity.Push(speed);
			DropPickup();
		}
	}
	// Are they letting go of an object?
	else if (!(buttons & btnPickup) && OldButtons & btnPickup && HoldingEntity != null)
	{
		if (HoldingEntity.IsEntityValid())
		{	
			// let go of the object
			DropPickup();
		}
	}
	
	// Cache old buttons
	::VSLib.EntData._objOldBtnMask[_idx] <- buttons;
}

/**
 * Drops the held HL2/Amnesia physics-based object or the valve-style object
 */
function VSLib::Player::DropPickup( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	// Drop amnesia object
	::VSLib.EntData._objHolding[_idx] <- null;
	
	// Drop valve object
	if (_idx in ::VSLib.EntData._objValveHolding)
	{
		::VSLib.EntData._objValveHolding[_idx].ApplyAbsVelocityImpulse(::VSLib.Utils.VectorFromQAngle(GetEyeAngles(), 100));
		delete ::VSLib.EntData._objValveHolding[_idx];
	}
}


/**
 * Picks up the given VSLib Entity object
 */
function VSLib::Player::NativePickupObject( otherEnt )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	DropPickup();
	
	if (otherEnt.GetClassname() != "prop_physics")
		return;
	
	::VSLib.EntData._objValveHolding[_idx] <- otherEnt.GetBaseEntity();
	PickupObject(_ent, otherEnt.GetBaseEntity());
}

/**
 * Enables Valve-style object pickups
 * @authors Neil, Rectus
 */
function VSLib::Player::BeginValvePickupObjects( pickupSound = "Defibrillator.Use", throwSound = "Adrenaline.NeedleOpen" )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	EndValvePickupObjects();
	
	::VSLib.EntData._objEnableDmg[_idx] <- false;
	::VSLib.EntData._objValveHoldDmg[_idx] <- 5;
	::VSLib.EntData._objValveThrowDmg[_idx] <- 30;
	::VSLib.EntData._objValveThrowPower[_idx] <- 100;
	::VSLib.EntData._objValvePickupRange[_idx] <- 64;
	::VSLib.EntData._objOldBtnMask[_idx] <- GetPressedButtons();
	::VSLib.EntData._objValveTimer[_idx] <- ::VSLib.Timers.AddTimer(0.1, true, @(p) p.ent.__CalcValvePickups(p.ps, p.ts), {ent = this, ps = pickupSound, ts = throwSound});
}

/**
 * Disables Valve-style object pickups
 * @authors Rectus
 */
function VSLib::Player::EndValvePickupObjects( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (_idx in ::VSLib.EntData._objValveTimer)
		::VSLib.Timers.RemoveTimer( ::VSLib.EntData._objValveTimer[_idx] );
}

/**
 * Sets the throwing force for Valve-style object pickups (default 100)
 * @authors Rectus
 */
function VSLib::Player::ValvePickupThrowPower( power )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	::VSLib.EntData._objValveThrowPower[_idx] <- power;
	
	return true;
}

/**
 * Sets the pickup range for Valve-style object pickups (default 64)
 * @authors Rectus
 */
function VSLib::Player::ValvePickupPickupRange( range )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	::VSLib.EntData._objValvePickupRange[_idx] <- range;
	
	return true;
}

/**
 * Sets the throw damage for Valve-style object pickups (default 30)
 */
function VSLib::Player::SetThrowDamage( dmg )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	::VSLib.EntData._objValveThrowDmg[_idx] <- dmg.tointeger();
}

/**
 * Sets the hold damage for Valve-style object pickups (default 5)
 */
function VSLib::Player::SetHoldDamage( dmg )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	::VSLib.EntData._objValveHoldDmg[_idx] <- dmg.tointeger();
}

/**
 * Enables or disables hold/throw damage calculation
 */
function VSLib::Player::SetDamageEnabled( isEnabled )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	::VSLib.EntData._objEnableDmg[_idx] <- isEnabled;
}

/**
 * Instead of using this directly, @see BeginValvePickupObjects
 * @authors Neil, Rectus
 */
function VSLib::Player::__CalcValvePickups( pickupSound, throwSound )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return false;
	}
	
	local curinv = GetHeldItems();
	
	if (_idx in ::VSLib.EntData._objValveHolding && (!("Held" in curinv) || ::VSLib.EntData._objValveHolding[_idx] != curinv["Held"]))
	{
		if (::VSLib.EntData._objEnableDmg[_idx])
			::VSLib.Timers.RemoveTimerByName("vPickup" + _idx);
		
		delete ::VSLib.EntData._objValveHolding[_idx];
		
		return;
	}
	
	local oldbuttons = ::VSLib.EntData._objOldBtnMask[_idx];
	
	local function _calcThrowDmg(params)
	{
		params.ent.HurtAround(params.dmg, 1, "", null, 64.0, [params.ignore]);
	}
	
	if (IsPressingUse() && !(oldbuttons & (1 << 5)))
	{
		local traceTable =
		{
			start = GetEyePosition()
			end = GetEyePosition() + ::VSLib.Utils.VectorFromQAngle(GetEyeAngles(), ::VSLib.EntData._objValvePickupRange[_idx])
			ignore = _ent
			mask = TRACE_MASK_SHOT 
		}

		local result = TraceLine(traceTable);
		
		if (result && "enthit" in traceTable && traceTable.enthit.GetClassname() == "prop_physics")
		{
			::VSLib.EntData._objValveHolding[_idx] <- traceTable.enthit;
			PickupObject(_ent, traceTable.enthit);
			PlaySound(pickupSound);
			
			if (::VSLib.EntData._objEnableDmg[_idx])
				::VSLib.Timers.AddTimerByName( "vPickup" + _idx, 0.1, true, _calcThrowDmg, { ent = ::VSLib.Entity(::VSLib.EntData._objValveHolding[_idx]), ignore = this, dmg = ::VSLib.EntData._objValveHoldDmg[_idx] } );
		}
	}
	else if (IsPressingAttack() && _idx in ::VSLib.EntData._objValveHolding)
	{
		try
		{
			::VSLib.EntData._objValveHolding[_idx].ApplyAbsVelocityImpulse(::VSLib.Utils.VectorFromQAngle(GetEyeAngles(), ::VSLib.EntData._objValveThrowPower[_idx]));
			
			if (::VSLib.EntData._objEnableDmg[_idx])
				::VSLib.Timers.AddTimerByName( "vPickup" + _idx, 0.1, true, _calcThrowDmg, { ent = ::VSLib.Entity(::VSLib.EntData._objValveHolding[_idx]), ignore = this, dmg = ::VSLib.EntData._objValveThrowDmg[_idx] }, TIMER_FLAG_COUNTDOWN, { count = 12 } );
			
			delete ::VSLib.EntData._objValveHolding[_idx];
			PlaySound(throwSound);
		}
		catch (id)
		{
			printl("Impulse failed! " + id);
		}
	
	}
	
	::VSLib.EntData._objOldBtnMask[_idx] <- GetPressedButtons();
}


/**
 * Returns the quantity of the requested inventory item.
 * Inventory items can be spawned with Utils::SpawnInventoryItem().
 */
function VSLib::Player::GetInventory( itemName )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return 0;
	}
	
	if (!(_idx in ::VSLib.EntData._inv))
		return 0;
	
	if (!(itemName in ::VSLib.EntData._inv[_idx]))
		return 0;
	
	return ::VSLib.EntData._inv[_idx][itemName];
}

/**
 * Sets the quantity of the specified inventory item.
 */
function VSLib::Player::SetInventory( itemName, quantity )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (!(_idx in ::VSLib.EntData._inv))
		::VSLib.EntData._inv[_idx] <- {};
	
	::VSLib.EntData._inv[_idx][itemName] <- quantity;
}

/**
 * Returns the player's inventory table. You can use it like this:
 * 
 * 		local inv = player.GetInventoryTable();
 * 		inv["itemName"] <- 25; // change quantity to 25
 */
function VSLib::Player::GetInventoryTable( )
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return 0;
	}
	
	if (!(_idx in ::VSLib.EntData._inv))
		::VSLib.EntData._inv[_idx] <- {};
	
	return ::VSLib.EntData._inv[_idx];
}



//
//  END OF REGULAR FUNCTIONS.
//
//	Below are functions related to query context data retrieved from ResponseRules.
//

/**
 * Returns true if survivor is in safe spot
 */
function VSLib::Player::IsInSafeSpot()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inSafeSpot" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inSafeSpot > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is in start area
 */
function VSLib::Player::IsInStartArea()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inStartArea" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inStartArea > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is in checkpoint
 */
function VSLib::Player::IsInCheckpoint()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inCheckpoint" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inCheckpoint > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is in battlefield
 */
function VSLib::Player::IsInBattlefield()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inBattlefield" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inBattlefield > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if player is in combat
 */
function VSLib::Player::IsInCombat()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ("_inCombat" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inCombat > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is in combat music
 */
function VSLib::Player::IsInCombatMusic()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_inCombatMusic" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._inCombatMusic > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is coughing
 */
function VSLib::Player::IsCoughing()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_coughing" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._coughing > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor is sneaking
 */
function VSLib::Player::IsSneaking()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ("_sneaking" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._sneaking > 0) ? true : false;
	
	return false;
}

/**
 * Get the survivor average intensity time
 */
function VSLib::Player::GetTimeAveragedIntensity()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR)
		return;
	
	if ( !("_timeAveragedIntensity" in ::VSLib.EasyLogic.Cache[_idx]) )
		return;
	
	return ::VSLib.EasyLogic.Cache[_idx]._timeAveragedIntensity;
}

/**
 * Get the time since the survivor was last in combat
 */
function VSLib::Player::GetTimeSinceCombat()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if ( !("_timeSinceCombat" in ::VSLib.EasyLogic.Cache[_idx]) )
		return;
	
	return ::VSLib.EasyLogic.Cache[_idx]._timeSinceCombat;
}

/**
 * Gets the survivor bot's closest visible friend
 */
function VSLib::Player::BotGetClosestVisibleFriend()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ( !("_botClosestVisibleFriend" in ::VSLib.EasyLogic.Cache[_idx]) )
		return null;
	
	local survivor = ::VSLib.EasyLogic.Cache[_idx]._botClosestVisibleFriend;
	
	return ::VSLib.Player(::VSLib.ResponseRules.ExpTargetName[survivor]);
}

/**
 * Gets the survivor bot's closest friend who's in combat
 */
function VSLib::Player::BotGetClosestInCombatFriend()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ( !("_botClosestInCombatFriend" in ::VSLib.EasyLogic.Cache[_idx]) )
		return null;
	
	local survivor = ::VSLib.EasyLogic.Cache[_idx]._botClosestInCombatFriend;
	
	if ( !survivor )
		return;
	
	return ::VSLib.Player(::VSLib.ResponseRules.ExpTargetName[survivor]);
}

/**
 * Gets the survivor bot's team leader
 */
function VSLib::Player::BotGetTeamLeader()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return null;
	
	if ( !("_botTeamLeader" in ::VSLib.EasyLogic.Cache[_idx]) )
		return;
	
	local survivor = ::VSLib.EasyLogic.Cache[_idx]._botTeamLeader;
	
	return ::VSLib.Player(::VSLib.ResponseRules.ExpTargetName[survivor]);
}

/**
 * Returns true if survivor bot is in a narrow corridor
 */
function VSLib::Player::BotIsInNarrowCorridor()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ("_botIsInNarrowCorridor" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._botIsInNarrowCorridor > 0) ? true : false;
	
	return false;
}

/**
 * Returns true if survivor bot is near a checkpoint
 */
function VSLib::Player::BotIsNearCheckpoint()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ("_botIsNearCheckpoint" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._botIsNearCheckpoint > 0) ? true : false;
	
	return false;
}

/**
 * Get the amount of visible friends the survivor bot sees
 */
function VSLib::Player::BotGetNearbyVisibleFriendCount()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ( !("_botNearbyVisibleFriendCount" in ::VSLib.EasyLogic.Cache[_idx]) )
		return null;
	
	return ::VSLib.EasyLogic.Cache[_idx]._botNearbyVisibleFriendCount;
}

/**
 * Get the amount of time since any friend was last seen by the survivor bot
 */
function VSLib::Player::BotGetTimeSinceAnyFriendVisible()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ( !("_botTimeSinceAnyFriendVisible" in ::VSLib.EasyLogic.Cache[_idx]) )
		return;
	
	return ::VSLib.EasyLogic.Cache[_idx]._botTimeSinceAnyFriendVisible;
}

/**
 * Returns true if the survivor bot is available
 */
function VSLib::Player::BotIsAvailable()
{
	if (!IsPlayerEntityValid())
	{
		printl("VSLib Warning: Player " + _idx + " is invalid.");
		return;
	}
	
	if (GetPlayerType() != Z_SURVIVOR || IsHuman())
		return;
	
	if ("_botIsAvailable" in ::VSLib.EasyLogic.Cache[_idx])
		return (::VSLib.EasyLogic.Cache[_idx]._botIsAvailable > 0) ? true : false;
	
	return false;
}





// Allows pickups
::CanPickupObject <- function (object)
{
	local vsent = ::VSLib.Entity(object);
	local classname = object.GetClassname();
	
	foreach (func in ::VSLib.EasyLogic.Notifications.CanPickupObject)
		if (func(vsent, classname))
			return true;
	
	foreach (obj in ::VSLib.EntData._objValveHolding)
		if (obj == object)
			return true;
	
	local canPickup = false;
	if ( "PickupObject" in g_MapScript )
		canPickup = g_MapScript.PickupObject( object );
	
	if ( "ModeCanPickupObject" in g_ModeScript )
		return ModeCanPickupObject(object);
	if ( "MapCanPickupObject" in g_ModeScript )
		return MapCanPickupObject(object);
	
	return canPickup;
}

if ( ("CanPickupObject" in g_ModeScript) && (g_ModeScript.CanPickupObject != getroottable().CanPickupObject) )
{
	g_ModeScript.ModeCanPickupObject <- g_ModeScript.CanPickupObject;
	g_ModeScript.CanPickupObject <- getroottable().CanPickupObject;
}
else if ( ("CanPickupObject" in g_MapScript) && (g_MapScript.CanPickupObject != getroottable().CanPickupObject) )
{
	g_ModeScript.MapCanPickupObject <- g_MapScript.CanPickupObject;
	g_ModeScript.CanPickupObject <- getroottable().CanPickupObject;
}
else
{
	g_ModeScript.CanPickupObject <- getroottable().CanPickupObject;
}




// Add a weakref
::Player <- ::VSLib.Player.weakref();