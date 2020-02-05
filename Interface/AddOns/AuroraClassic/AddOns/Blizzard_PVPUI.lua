local F, C = unpack(select(2, ...))

C.themes["Blizzard_PVPUI"] = function()
	local r, g, b = C.r, C.g, C.b

	local PVPQueueFrame = PVPQueueFrame
	local HonorFrame = HonorFrame
	local ConquestFrame = ConquestFrame

	-- Category buttons

	local iconSize = 60-2*C.mult
	for i = 1, 3 do
		local bu = PVPQueueFrame["CategoryButton"..i]
		local icon = bu.Icon
		local cu = bu.CurrencyDisplay

		bu.Ring:Hide()
		F.Reskin(bu, true)
		bu.Background:SetAllPoints(bu.bgTex)
		bu.Background:SetColorTexture(r, g, b, .25)

		icon:SetPoint("LEFT", bu, "LEFT")
		icon:SetSize(iconSize, iconSize)
		F.ReskinIcon(icon)

		if cu then
			local ic = cu.Icon

			ic:SetSize(16, 16)
			ic:SetPoint("TOPLEFT", bu.Name, "BOTTOMLEFT", 0, -8)
			cu.Amount:SetPoint("LEFT", ic, "RIGHT", 4, 0)
			F.ReskinIcon(ic)
		end
	end

	PVPQueueFrame.CategoryButton1.Icon:SetTexture("Interface\\Icons\\achievement_bg_winwsg")
	PVPQueueFrame.CategoryButton2.Icon:SetTexture("Interface\\Icons\\achievement_bg_killxenemies_generalsroom")
	PVPQueueFrame.CategoryButton3.Icon:SetTexture("Interface\\Icons\\ability_warrior_offensivestance")

	hooksecurefunc("PVPQueueFrame_SelectButton", function(index)
		local self = PVPQueueFrame
		for i = 1, 3 do
			local bu = self["CategoryButton"..i]
			if i == index then
				bu.Background:SetAlpha(1)
			else
				bu.Background:SetAlpha(0)
			end
		end
	end)

	PVPQueueFrame.CategoryButton1.Background:SetAlpha(1)
	F.StripTextures(PVPQueueFrame.HonorInset)

	local popup = PVPQueueFrame.NewSeasonPopup
	F.Reskin(popup.Leave)
	popup.NewSeason:SetTextColor(1, .8, 0)
	popup.SeasonDescription:SetTextColor(1, 1, 1)
	popup.SeasonDescription2:SetTextColor(1, 1, 1)

	local SeasonRewardFrame = popup.SeasonRewardFrame
	SeasonRewardFrame.CircleMask:Hide()
	SeasonRewardFrame.Ring:Hide()
	local bg = F.ReskinIcon(SeasonRewardFrame.Icon)
	bg:SetFrameLevel(4)
	select(3, SeasonRewardFrame:GetRegions()):SetTextColor(1, .8, 0)

	local seasonReward = PVPQueueFrame.HonorInset.RatedPanel.SeasonRewardFrame
	seasonReward.Ring:Hide()
	seasonReward.CircleMask:Hide()
	seasonReward.Icon:SetTexCoord(.08, .92, .08, .92)
	F.CreateBDFrame(seasonReward.Icon)

	-- Honor frame

	local BonusFrame = HonorFrame.BonusFrame
	HonorFrame.Inset:Hide()
	BonusFrame.WorldBattlesTexture:Hide()
	BonusFrame.ShadowOverlay:Hide()

	for _, bonusButton in pairs({"RandomBGButton", "RandomEpicBGButton", "Arena1Button", "BrawlButton", "SpecialEventButton"}) do
		local bu = BonusFrame[bonusButton]
		F.Reskin(bu, true)
		bu.SelectedTexture:SetDrawLayer("BACKGROUND")
		bu.SelectedTexture:SetColorTexture(r, g, b, .25)
		bu.SelectedTexture:SetAllPoints(bu.bgTex)

		local reward = bu.Reward
		if reward then
			reward.Border:Hide()
			reward.CircleMask:Hide()
			reward.Icon.bg = F.ReskinIcon(reward.Icon)
		end
	end

	local function reskinConquestBar(bar)
		F.StripTextures(bar.ConquestBar)
		F.CreateBDFrame(bar.ConquestBar, .25)
		bar.ConquestBar:SetStatusBarTexture(C.media.backdrop)
		bar.ConquestBar:GetStatusBarTexture():SetGradient("VERTICAL", 1, .8, 0, 6, .4, 0)
	end
	reskinConquestBar(HonorFrame)

	-- Role buttons

	local function styleRole(self)
		self:DisableDrawLayer("BACKGROUND")
		self:DisableDrawLayer("BORDER")
		F.ReskinRole(self.TankIcon, "TANK")
		F.ReskinRole(self.HealerIcon, "HEALER")
		F.ReskinRole(self.DPSIcon, "DPS")
	end
	styleRole(HonorFrame)
	styleRole(ConquestFrame)

	-- Honor frame specific

	for _, bu in pairs(HonorFrame.SpecificFrame.buttons) do
		bu.Bg:Hide()
		bu.Border:Hide()

		bu:SetNormalTexture("")
		bu:SetHighlightTexture("")

		local bg = F.CreateBDFrame(bu, 0)
		bg:SetPoint("TOPLEFT", 2, 0)
		bg:SetPoint("BOTTOMRIGHT", -1, 2)

		bu.tex = F.CreateGradient(bu)
		bu.tex:SetDrawLayer("BACKGROUND")
		bu.tex:SetPoint("TOPLEFT", bg, C.mult, -C.mult)
		bu.tex:SetPoint("BOTTOMRIGHT", bg, -C.mult, C.mult)

		bu.SelectedTexture:SetDrawLayer("BACKGROUND")
		bu.SelectedTexture:SetColorTexture(r, g, b, .25)
		bu.SelectedTexture:SetAllPoints(bu.tex)

		F.ReskinIcon(bu.Icon)
		bu.Icon:SetPoint("TOPLEFT", 5, -3)
	end

	-- Conquest Frame

	ConquestFrame.Inset:Hide()
	ConquestFrame.RatedBGTexture:Hide()
	ConquestFrame.ShadowOverlay:Hide()

	if AuroraClassicDB.Tooltips then
		F.ReskinTooltip(ConquestTooltip)
	end

	local function ConquestFrameButton_OnEnter(self)
		ConquestTooltip:ClearAllPoints()
		ConquestTooltip:SetPoint("TOPLEFT", self, "TOPRIGHT", 1, 0)
	end
	ConquestFrame.Arena2v2:HookScript("OnEnter", ConquestFrameButton_OnEnter)
	ConquestFrame.Arena3v3:HookScript("OnEnter", ConquestFrameButton_OnEnter)
	ConquestFrame.RatedBG:HookScript("OnEnter", ConquestFrameButton_OnEnter)

	for _, bu in pairs({ConquestFrame.Arena2v2, ConquestFrame.Arena3v3, ConquestFrame.RatedBG}) do
		F.Reskin(bu, true)
		local reward = bu.Reward
		if reward then
			reward.Border:Hide()
			reward.CircleMask:Hide()
			reward.Icon.bg = F.ReskinIcon(reward.Icon)
		end

		bu.SelectedTexture:SetDrawLayer("BACKGROUND")
		bu.SelectedTexture:SetColorTexture(r, g, b, .25)
		bu.SelectedTexture:SetAllPoints(bu.bgTex)
	end

	ConquestFrame.Arena3v3:SetPoint("TOP", ConquestFrame.Arena2v2, "BOTTOM", 0, -1)
	reskinConquestBar(ConquestFrame)

	-- Item Borders for HonorFrame & ConquestFrame
	hooksecurefunc("PVPUIFrame_ConfigureRewardFrame", function(rewardFrame, _, _, itemRewards, currencyRewards)
		local rewardTexture, rewardQuaility = nil, 1

		if currencyRewards then
			for _, reward in ipairs(currencyRewards) do
				local name, _, texture, _, _, _, _, quality = GetCurrencyInfo(reward.id)
				if quality == _G.LE_ITEM_QUALITY_ARTIFACT then
					_, rewardTexture, _, rewardQuaility = CurrencyContainerUtil.GetCurrencyContainerInfo(reward.id, reward.quantity, name, texture, quality)
				end
			end
		end

		local _
		if not rewardTexture and itemRewards then
			local reward = itemRewards[1]
			if reward then
				_, _, rewardQuaility, _, _, _, _, _, _, rewardTexture = GetItemInfo(reward.id)
			end
		end

		if rewardTexture then
			rewardFrame.Icon:SetTexture(rewardTexture)
			local color = BAG_ITEM_QUALITY_COLORS[rewardQuaility]
			rewardFrame.Icon.bg:SetBackdropBorderColor(color.r, color.g, color.b)
		end
	end)

	-- Main style

	F.Reskin(HonorFrame.QueueButton)
	F.Reskin(ConquestFrame.JoinButton)
	F.ReskinDropDown(HonorFrameTypeDropDown)
	F.ReskinScroll(HonorFrameSpecificFrameScrollBar)
	F.ReskinClose(PremadeGroupsPvPTutorialAlert.CloseButton)
end