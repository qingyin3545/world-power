﻿------------------------------------------------------------EMP BOMB Mode Switch---------------------------------------------------------------------------

  UnitEmpBombOnButton = {
  Name = "Emp Bomb On",
  Title = "TXT_KEY_SP_BTNNOTE_UNIT_EMP_BOMB_ON_SHORT", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "SP_UNIT_ACTION_ATLAS2", -- 45 and 64 variations required
  PortraitIndex = 28,
  ToolTip = "TXT_KEY_SP_BTNNOTE_UNIT_EMP_BOMB_ON", -- or a TXT_KEY_ or a function
  
 
  
  Condition = function(action, unit)
   return unit:CanMove() and unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_EMP_BOMB"].ID) 
   and not unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_EMP_BOMB_ON"].ID);
  end, -- or nil or a boolean, default is true
  
  Disabled = function(action, unit)   
    return false;
  end, -- or nil or a boolean, default is false
  
  Action = function(action, unit, eClick) 
  	 	
   	unit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_EMP_BOMB_ON"].ID, true) 
  end
};
LuaEvents.UnitPanelActionAddin(UnitEmpBombOnButton);


UnitEmpBombOffButton = {
  Name = "Emp Bomb Mode Off",
  Title = "TXT_KEY_SP_BTNNOTE_UNIT_EMP_BOMB_OFF_SHORT", -- or a TXT_KEY
  OrderPriority = 200, -- default is 200
  IconAtlas = "SP_UNIT_ACTION_ATLAS2", -- 45 and 64 variations required
  PortraitIndex = 11,
  ToolTip = "TXT_KEY_SP_BTNNOTE_UNIT_EMP_BOMB_OFF", -- or a TXT_KEY_ or a function
  

  Condition = function(action, unit)
    return unit:CanMove() and unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_EMP_BOMB_ON"].ID);
  end, -- or nil or a boolean, default is true
  
  Disabled = function(action, unit)   
    return false;
  end, -- or nil or a boolean, default is false

  Action = function(action, unit, eClick) 
  	 	
   	unit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_EMP_BOMB_ON"].ID, false)
   	unit:SetMoves(0)
   	print ("Emp Bomb Off!")	
  end
};
LuaEvents.UnitPanelActionAddin(UnitEmpBombOffButton);








-- ********************************************************
-- 粒子炮
-- ******************************************************** 
local SuperChainButtonOn = {
		Name = "TXT_KEY_NAME_PLASMA_CANNON_ON",
		Title = "TXT_KEY_TITLE_PLASMA_CANNON_ON",
		OrderPriority = 300,
		IconAtlas = "SP_UNIT_ACTION_ATLAS2",
		PortraitIndex = 8,
		ToolTip = "TXT_KEY_SP_BTNNOTE_PLASMA_CANNON_ON", -- or a TXT_KEY_ or a function
		Condition = function(action, unit)
		return   unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_PLASMA_CANNON"].ID) 
        and unit:CanMove()
		and not  unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_PLASMA_CANNON_ON"].ID)  end, 
		Disabled = function(action, unit)   
    return false;
  end, -- or nil or a boolean, default is false
		Action = function(action, unit, eClick)
			unit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_PLASMA_CANNON_ON"].ID, true)
		end
};
LuaEvents.UnitPanelActionAddin( SuperChainButtonOn);

local SuperChainButtonOff = {
		Name = "TXT_KEY_NAME_PLASMA_CANNON_OFF",
		Title = "TXT_KEY_TITLE_PLASMA_CANNON_OFF",
		OrderPriority = 300,
		IconAtlas = "SP_UNIT_ACTION_ATLAS2",
		PortraitIndex = 20,
		ToolTip = "TXT_KEY_SP_BTNNOTE_PLASMA_CANNON_OFF", -- or a TXT_KEY_ or a function
		Condition = function(action, unit)
		return unit:CanMove()  
		and  unit:IsHasPromotion(GameInfo.UnitPromotions["PROMOTION_PLASMA_CANNON_ON"].ID)  end, 
		Disabled = function(action, unit)   
    return false;
  end, -- or nil or a boolean, default is false
		Action = function(action, unit, eClick)
			unit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_PLASMA_CANNON_ON"].ID, false)
			unit:SetMoves(0)
		end
};
LuaEvents.UnitPanelActionAddin(SuperChainButtonOff);




-- ****************************************
-- 异种研究所
-- ****************************************	
function JurassicParkBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer == nil or (not pPlayer:IsMajorCiv()) then
	 	return
	         end
    if pPlayer:GetCurrentEra()~=GameInfoTypes.ERA_FUTURE  then
			return
	   end
	if  pPlayer:HasWonder(GameInfoTypes.BUILDING_FW_JURASSIC_PARK)  then

		local iCheckForDinos = LocalizingRandom(1, 100)
		if (iCheckForDinos < 90) then
			local tPlots ={}
			local tPlots2 ={}
			for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_FW_JURASSIC_PARK) then	
						local pCentralPlot = pCity:Plot()
			             for pPlot in PlotAreaSpiralIterator(pCentralPlot, 4, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local iTerrain = pPlot:GetTerrainType()
							local iOwner = pPlot:GetOwner()
							if (((iTerrain == GameInfoTypes.TERRAIN_PLAINS) or 
							(iTerrain == GameInfoTypes.TERRAIN_GRASS)) 
							and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) and not (pPlot:IsMountain())) then
								table.insert(tPlots, pPlot)
								end
                            if (((iTerrain == GameInfoTypes.TERRAIN_OCEAN) ) 
							and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) 
							and not (pPlot:IsMountain())) then
								table.insert(tPlots2, pPlot)
								end
								--print("Inserted plot")
							end
						end
					end
				--end
			--end
			if #tPlots > 0 then
				local randomNumber = LocalizingRandom(1, #tPlots)
				local tPlot = tPlots[randomNumber]
				local iDinoNumber = LocalizingRandom(1, 100)
				--print("单位种类 " .. 根据随机数确定)
				if (iDinoNumber >= 80) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_ALIEN_SIEGE_WORM.ID) == 0 ) then 
					iDinoType = GameInfoTypes.UNIT_ALIEN_SIEGE_WORM
					local nUnit = pPlayer:InitUnit(iDinoType, tPlot:GetX(), tPlot:GetY())
				end
				if (iDinoNumber <= 10) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_HOVER_WORM.ID) == 0 ) 
				and pPlayer:IsHasTech(GameInfo.Technologies["TECH_COGNITIVE"].ID) then 
					iDinoType3 = GameInfoTypes.UNIT_HOVER_WORM
					local nUnit3 = pPlayer:InitUnit(iDinoType3, tPlot:GetX(), tPlot:GetY())
					end
				end
             if #tPlots2 > 0 then
				local randomNumber = LocalizingRandom(1, #tPlots2)
				local tPlot2 = tPlots2[randomNumber]
				local iDinoNumber = ROG_GetTrueRandom(1, 100)
				if (iDinoNumber <= 15) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_NAVAL_MONSTER.ID) == 0 ) 
				and pPlayer:IsHasTech(GameInfo.Technologies["TECH_MATTERTRANSMISSION"].ID) then 
					iDinoType2 = GameInfoTypes.UNIT_NAVAL_MONSTER
					local nUnit2 = pPlayer:InitUnit(iDinoType2, tPlot2:GetX(), tPlot2:GetY())
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JurassicParkBonus)







local tMissions = {
iMove = MissionTypes.MISSION_MOVE_TO,
iRoute = MissionTypes.MISSION_ROUTE_TO,
iMovetoUnit = MissionTypes.MISSION_MOVE_TO_UNIT,
iSwap = MissionTypes.MISSION_SWAP_UNITS
}

function ImmobileWhileDamaged(iPlayer, iUnit, iMission)
local pPlayer = Players[iPlayer]
local pUnit = pPlayer:GetUnitByID(iUnit)

if (pUnit:IsHasPromotion(iImmobileWhileDamaged)) and (pUnit:GetCurrHitPoints() < pUnit:GetMaxHitPoints()) then
for sKey, iValue in pairs(tMissions) do
if iMission == iValue then
return false
end
end
end

return true

end
GameEvents.CanStartMission.Add(ImmobileWhileDamaged)









	if (eIndex == YIELD_HERESY)
	{
		iValue += getHeresyFromDiscord();
	}


	<Row Tag="TXT_KEY_CITYVIEW_BASE_YIELD_TT_FROM_DISCORD">
			<Text>[NEWLINE][ICON_BULLET]{1_Num}{2_IconString} 来自异教徒</Text>
		</Row>


		-- Collect founded religions
	local foundedReligions = {}
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do	
		local pPlayer = Players[iPlayer] 
		if (pPlayer:IsEverAlive() and pPlayer:HasCreatedReligion()) then
			foundedReligions[pPlayer:GetReligionCreatedByPlayer()] = true 
		end
	end

	-- Update instances
	local isHolyCity = currentCity:IsHolyCityAnyReligion()
	Controls.HolyCityWarning:SetHide(not isHolyCity)

	conversionsManager:ResetInstances() 
	for _, v in ipairs(data.religions) do
		if foundedReligions[v.ID] then
			local instance = conversionsManager:GetInstance() 
			if instance then
				instance.Header:SetText(v.iconString) 
				local update = HookNumericBox("Conversion", 
					function() return currentCity:GetNumFollowers(v.ID) end, 
					function(amount) SetFollowers(v.ID, amount) end, 
					0, currentCity:GetPopulation(), 1, instance) 
				update(currentCity:GetNumFollowers(v.ID)) 
				instance.MinButton:RegisterCallback(Mouse.eLClick, function() SetMinFollowers(v.ID) end) 
				instance.MaxButton:RegisterCallback(Mouse.eLClick, function() SetMaxFollowers(v.ID) end) 

				instance.NumericBox:SetToolTipString(L("TXT_KEY_IGE_FOLLOWERS", Game.GetReligionName(v.ID))) 
				instance.MinButton:SetToolTipString(L("TXT_KEY_IGE_FOLLOWERS_MIN_HELP", Game.GetReligionName(v.ID))) 
				instance.MaxButton:SetToolTipString(L("TXT_KEY_IGE_FOLLOWERS_MAX_HELP", Game.GetReligionName(v.ID))) 
			end
		end
	end
end














----------------------------------------------------------------晋升对晋升的显示效果----------------------------------------------------------------
		-- Promotions
		local otherPromotions = {};
		local otherPromotions2 = {};
		local otherPromotions3 = {};
			for row in GameInfo.UnitPromotions_PromotionModifiers() do
			local PromotionInfo = GameInfo.UnitPromotions[row.OtherPromotionType] 
			local PromotionInfoMain = GameInfo.UnitPromotions[row.PromotionType]
			if PromotionInfo~=nil then 
		    if pTheirUnit:IsHasPromotion(PromotionInfo.ID) then
			if pMyUnit:IsHasPromotion(PromotionInfoMain.ID) then



			if (row.Modifier > 0) then
				row.Modifier = "[COLOR_POSITIVE_TEXT]+" .. row.Modifier .. "[ENDCOLOR]";
			elseif (row.Modifier < 0) then
				row.Modifier = "[COLOR_NEGATIVE_TEXT]" .. row.Modifier .. "[ENDCOLOR]";
			   end
			
			if (row.Attack > 0) then
				row.Attack = "[COLOR_POSITIVE_TEXT]+" .. row.Attack .. "[ENDCOLOR]";
			elseif (row.Attack < 0) then
				row.Attack = "[COLOR_NEGATIVE_TEXT]" .. row.Attack .. "[ENDCOLOR]";
				end
			
	
			if (row.Defense > 0) then
				row.Defense = "[COLOR_POSITIVE_TEXT]+" .. row.Defense .. "[ENDCOLOR]";
			elseif (row.Defense < 0) then
				row.Defense = "[COLOR_NEGATIVE_TEXT]" .. row.Defense .. "[ENDCOLOR]";
				end
			
			            if row.Modifier~=0 then
						table.insert( otherPromotions, PromotionInfo.IconString2 .." :  " .. Locale.ConvertTextKey( row.Modifier.. "%" ) );
						end
						if row.Attack~=0 then
						table.insert( otherPromotions2, PromotionInfo.IconString2 .." :  " ..Locale.ConvertTextKey( row.Attack.. "%"  ) );
						end
						if row.Defense~=0 then
						table.insert( otherPromotions3, PromotionInfo.IconString2 .." :  ".. Locale.ConvertTextKey( row.Defense.. "%" ) );
						end

					end
				end
			end
		end
		local promotionText = {};
		local promotionText2 = {};
		local promotionText3 = {};
		for _,promotion in pairs(otherPromotions) do
			table.insert(promotionText, promotion);
		end
		for _,promotion in pairs(otherPromotions2) do
			table.insert(promotionText2, promotion);
		end
		for _,promotion in pairs(otherPromotions3) do
			table.insert(promotionText3, promotion);
		end


			-- UnitPromotions_PromotionModifiers 
		    local iModifier =0
			for row in GameInfo.UnitPromotions_PromotionModifiers() do
			local PromotionInfo = GameInfo.UnitPromotions[row.OtherPromotionType] 
			local PromotionInfoMain = GameInfo.UnitPromotions[row.PromotionType] 
		    if PromotionInfo~=nil then
		    if pTheirUnit:IsHasPromotion(PromotionInfo.ID) then
			if pMyUnit:IsHasPromotion(PromotionInfoMain.ID) then
			iModifier=iModifier+row.Modifier 
			         end
			      end
			   end
			end
	      	if (iModifier ~= 0) then
				controlTable = g_MyCombatDataIM:GetInstance();			
				controlTable.Text:LocalizeAndSetText( Locale.ConvertTextKey("TXT_KEY_EUPANEL_BONUS_VS_OTHER_PROMOTION").."".."[NEWLINE]" ..table.concat( promotionText, "[NEWLINE]" ) );
				controlTable.Value:SetText( GetFormattedText(strText, iModifier, true, true) );
            end

   			-- UnitPromotions_PromotionAttack
		    local iModifier =0
			for row in GameInfo.UnitPromotions_PromotionModifiers() do
			local PromotionInfo = GameInfo.UnitPromotions[row.OtherPromotionType] 
			local PromotionInfoMain = GameInfo.UnitPromotions[row.PromotionType] 
		    if PromotionInfo~=nil then
		    if pTheirUnit:IsHasPromotion(PromotionInfo.ID) then
			if pMyUnit:IsHasPromotion(PromotionInfoMain.ID) then
			iModifier=iModifier+row.Attack 
			         end
			      end
			   end
			end
	      	if (iModifier ~= 0) then
				controlTable = g_MyCombatDataIM:GetInstance();
				controlTable.Text:LocalizeAndSetText( Locale.ConvertTextKey("TXT_KEY_EUPANEL_BONUS_VS_OTHER_PROMOTION_ATTACK").."".."[NEWLINE]" ..table.concat( promotionText2, "[NEWLINE]" ) )
				controlTable.Value:SetText( GetFormattedText(strText, iModifier, true, true) );
            end


    		
   ----------------------------------------------------------------晋升对晋升的显示效果end----------------------------------------------------------------
   int CvCity::getDiseaseFromConnectionAndTradeRoute() const
{
	int DiseaseFromConnectionAndTradeRoute = 0;


	CvCity* theCapital = GET_PLAYER(getOwner()).getCapitalCity();

	if (theCapital != NULL && !isCapital() && theCapital->HasPlague() && IsConnectedToCapital() )
	{
		int diseaseConnections = ((theCapital->getYieldRate(YIELD_DISEASE, false) * GC.getHEALTH_DISEASE_CONNECTION_MOD()) / 100);
		DiseaseFromConnectionAndTradeRoute += std::max(0, (int)ceil(diseaseConnections / 1.0));
	}

	CvGameTrade* pTrade = GC.getGame().GetGameTrade();
	for (uint ui = 0; ui < pTrade->m_aTradeConnections.size(); ui++)
	{
		if (pTrade->IsTradeRouteIndexEmpty(ui))
		{
			continue;
		}

		TradeConnection* pConnection = &(pTrade->m_aTradeConnections[ui]);

		CvCity* pFromCity = GC.getMap().plot(pConnection->m_iOriginX, pConnection->m_iOriginY)->getPlotCity();
		CvCity* pToCity = GC.getMap().plot(pConnection->m_iDestX, pConnection->m_iDestY)->getPlotCity();

		if (pFromCity == this);
		{
			DiseaseFromConnectionAndTradeRoute += std::max(0, (pToCity->getYieldRate(YIELD_DISEASE, false) * GC.getHEALTH_DISEASE_TRADE_MOD() / 100));
		}
	}

	return DiseaseFromConnectionAndTradeRoute;
}


	<Row Tag="TXT_KEY_PRODMOD_YIELD_FROM_INTER_TRADE_MOD">
			<Text>[NEWLINE][ICON_BULLET]国际商路数量的修正值: {1_Num}%</Text>
		</Row>

		TXT_KEY_PRODMOD_YIELD_FROM_INTER_TRADE_MOD


		int CvCity::getDiseaseFromConnectionAndTradeRoute() const
{
	int DiseaseFromConnectionAndTradeRoute = 0;
	DiseaseFromConnectionAndTradeRoute -= getTradeRouteNum() * getPopulation() * GC.getHEALTH_DISEASE_CONNECTION_MOD() / 100;
	return DiseaseFromConnectionAndTradeRoute;
}



		HEALTH_DISEASE_TRADE_MOD=100