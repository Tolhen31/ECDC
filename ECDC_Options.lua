
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

AceConfig:RegisterOptionsTable("ECDC_Main", {
    type = "group",
    name = "ECDC",
    args = {
        dummy = {
            type = "description",
            name = "ECDC loaded",
            order = 1,
        }
    }
})

local ADDON_NAME, addon = ...
local L = addon.L
addon.version = GetAddOnMetadata(ADDON_NAME, "Version")

local classPanels = { --defaults
	[L["Druid"]] = {
		[L["Barkskin"]] = true, 
		[L["Faerie Fire"]] = false,
		[L["Hurricane"]] = true,
		[L["Nature's Grasp"]] = true,
		[L["Bash"]] = true,
		[L["Challenging Roar"]] = false,
		[L["Cower"]] = false,
		[L["Dash"]] = true,
		[L["Enrage"]] = true,
		[L["Frenzied Regeneration"]] = true,
		[L["Prowl"]] = true,
		[L["Tiger's Fury"]] = false,
		[L["Rebirth"]] = true,
		[L["Tranquility"]] = true,
		[L["Innervate"]] = true,
		[L["Faerie Fire (Feral)"]] = false,
		[L["Feral Charge"]] = true,
		[L["Swiftmend"]] = true,
		[L["Nature's Swiftness"]] = true
		},
		
	[L["Hunter"]] = {
		[L["Scare Beast"]] = true,
		[L["Tranquilizing Shot"]] = true,
		[L["Arcane Shot"]] = false,
		[L["Concussive Shot"]] = true,
		[L["Distracting Shot"]] = false,
		[L["Flare"]] = true,
		[L["Multi-Shot"]] = true,
		[L["Rapid Fire"]] = true,
		[L["Volley"]] = true,
		[L["Counterattack"]] = false,
		[L["Disengage"]] = false,
		[L["Explosive Trap"]] = true,
		[L["Feign Death"]] = true,
		[L["Freezing Trap"]] = true,
		[L["Frost Trap"]] = true,
		[L["Immolation Trap"]] = true,
		[L["Mongoose Bite"]] = false,
		[L["Raptor Strike"]] = false,
		[L["Wyvern Sting"]] = true,
		[L["Bestial Wrath"]] = true,
		[L["Intimidation"]] = true,
		[L["Deterrence"]] = true,
		[L["Scatter Shot"]] = true,
		[L["Aimed Shot"]] = true
		},
		
	[L["Mage"]] = {
		[L["Blink"]] = true, 
		[L["Blast Wave"]] = true,
		[L["Fire Blast"]] = true,
		[L["Fire Ward"]] = true,
		[L["Cone of Cold"]] = true,
		[L["Frost Nova"]] = true,
		[L["Frost Ward"]] = true,
		[L["Ice Barrier"]] = true,
		[L["Counterspell"]] = true,
		[L["Evocation"]] = true,
		[L["Presence of Mind"]] = true,
		[L["Arcane Power"]] = true,
		[L["Combustion"]] = true,
		[L["Cold Snap"]] = true,
		[L["Ice Block"]] = true
		},
		
	[L["Paladin"]] = {
		[L["Consecration"]] = false,
		[L["Exorcism"]] = false,
		[L["Hammer of Wrath"]] = true,
		[L["Holy Wrath"]] = false,
		[L["Lay on Hands"]] = true,
		[L["Turn Undead"]] = false,
		[L["Blessing of Freedom"]] = true,
		[L["Blessing of Protection"]] = true,
		[L["Divine Intervention"]] = true,
		[L["Divine Protection"]] = true,
		[L["Divine Shield"]] = true,
		[L["Hammer of Justice"]] = true,
		[L["Judgement"]] = true,
		[L["Forbearance"]] = true,
		[L["Divine Favor"]] = true,
		[L["Holy Shock"]] = true,
		[L["Holy Shield"]] = true,
		[L["Repentance"]] = true
		},
		
	[L["Priest"]] = {
		[L["Elune's Grace"]] = true,
		[L["Feedback"]] = true,
		[L["Power Word: Shield"]] = false,
		[L["Desperate Prayer"]] = true,
		[L["Fear Ward"]] = true,
		[L["Devouring Plague"]] = true,
		[L["Fade"]] = false,
		[L["Mind Blast"]] = true,
		[L["Psychic Scream"]] = true,
		[L["Inner Focus"]] = true,
		[L["Power Infusion"]] = true,
		[L["Silence"]] = true
		},
		
	[L["Rogue"]] = {
		[L["Kidney Shot"]] = true,
		[L["Evasion"]] = true,
		[L["Feint"]] = false,
		[L["Gouge"]] = true,
		[L["Kick"]] = true,
		[L["Sprint"]] = true,
		[L["Blind"]] = true,
		[L["Distract"]] = true,
		[L["Stealth"]] = true,
		[L["Vanish"]] = true,
		[L["Blade Flurry"]] = true,
		[L["Adrenaline Rush"]] = true,
		[L["Preparation"]] = true,
		[L["Ghostly Strike"]] = true,
		[L["Premeditation"]] = true,
		[L["Cold Blood"]] = true
		},
		
	[L["Shaman"]] = {
		[L["Reincarnation"]] = true,
		[L["Chain Lightning"]] = true,
		[L["Earth Shock"]] = true,
		[L["Earthbind Totem"]] = true,
		[L["Fire Nova Totem"]] = true,
		[L["Flame Shock"]] = true,
		[L["Frost Shock"]] = true,
		[L["Stoneclaw Totem"]] = false,
		[L["Astral Recall"]] = false,
		[L["Grounding Totem"]] = true,
		[L["Mana Tide Totem"]] = true,
		[L["Elemental Mastery"]] = true,
		[L["Stormstrike"]] = true,
		[L["Nature's Swiftness"]] = true
		},
		
	[L["Warlock"]] = {
		[L["Soulstone Resurrection"]] = true,
		[L["Curse of Doom"]] = true,
		[L["Death Coil"]] = true,
		[L["Howl of Terror"]] = true,
		[L["Inferno"]] = true,
		[L["Ritual of Doom"]] = true,
		[L["Shadow Ward"]] = true,
		[L["Conflagrate"]] = true,
		[L["Shadowburn"]] = true,
		[L["Soul Fire"]] = true,
		[L["Devour Magic"]] = true,
		[L["Spell Lock"]] = true,
		[L["Lash of Pain"]] = true,
		[L["Soothing Kiss"]] = false,
		[L["Fel Domination"]] = true,
		[L["Amplify Curse"]] = true
		},
		
	[L["Warrior"]] = {
		[L["Charge"]] = true,
		[L["Mocking Blow"]] = false,
		[L["Mortal Strike"]] = false,
		[L["Overpower"]] = false,
		[L["Retaliation"]] = true,
		[L["Thunder Clap"]] = false,
		[L["Berserker Rage"]] = true,
		[L["Bloodthirst"]] = false,
		[L["Challenging Shout"]] = false,
		[L["Intercept"]] = true,
		[L["Intimidating Shout"]] = true,
		[L["Pummel"]] = true,
		[L["Recklessness"]] = true,
		[L["Whirlwind"]] = true,
		[L["Bloodrage"]] = true,
		[L["Disarm"]] = true,
		[L["Revenge"]] = false,
		[L["Shield Bash"]] = true,
		[L["Shield Block"]] = true,
		[L["Shield Slam"]] = false,
		[L["Shield Wall"]] = true,
		[L["Last Stand"]] = true,
		[L["Sweeping Strikes"]] = true,
		[L["Death Wish"]] = true,
		[L["Concussion Blow"]] = true
		},
	
	[L["Racials"]] = {
		[L["Will of the Forsaken"]] = true,
		[L["Perception"]] = true,
		[L["War Stomp"]] = true,
		[L["Stoneform"]] = true,
		[L["Cannibalize"]] = true,
		[L["Blood Fury"]] = true,
		[L["Berserking"]] = true,
		[L["Shadowmeld"]] = true,
		[L["Escape Artist"]] = true
		},
	
	[L["Trinkets"]] = {
		[L["Brittle Armor"]] = false,
		[L["Unstable Power"]] = true,
		--[L["Restless Strength"]] = false,
		[L["Ephemeral Power"]] = true,
		--[L["Massive Destruction"]] = false,
		--[L["Arcane Potency"]] = false,
		--[L["Energized Shield"]] = false,
		--[L["Brilliant Light"]] = false,
		--[L["Mar'li's Brain Boost"]] = false,
		[L["Burst of Energy"]] = true,
		[L["Refocus"]] = true,
		[L["Venomous Totem"]] = true,
		[L["Mind Quickening"]] = true,
		[L["Gift of Life"]] = true,
		[L["Blinding Light"]] = true,
		[L["Nature Aligned"]] = true,
		[L["Earthstrike"]] = true,
		[L["Badge of the Swarmguard"]] = true,
		[L["Immune Root/Snare/Stun"]] = true,
		[L["Immune Fear/Polymorph/Snare"]] = true,
		[L["Immune Charm/Fear/Stun"]] = true,
		[L["Immune Charm/Fear/Polymorph"]] = true,
		[L["Immune Fear/Polymorph/Stun"]] = true,
		[L["Tidal Charm"]] = false,
		[L["Diamond Flask"]] = false,
		[L["Fearless"]] = false,
		[L["Net-o-Matic"]] = true,
		[L["The Burrower's Shell"]] = true,
		[L["Aura of Protection"]] = true,
		[L["The Eye of the Dead"]] = false,
		[L["Essence of Sapphiron"]] = false,
		[L["Persistent Shield"]] = false,
		[L["Slayer's Crest"]] = false,
		[L["Kiss of the Spider"]] = false,
		[L["Frost Reflector"]] = true,
		[L["Shadow Reflector"]] = true,
		[L["Fire Reflector"]] = true
		},
	
	[L["Miscellaneous"]] = {
		[L["Healing Potion"]] = true,
		[L["Healing Draught"]] = true,
		[L["Restore Mana"]] = true,
		[L["Free Action"]] = true,
		[L["Living Free Action"]] = true,
		[L["Invulnerability"]] = true,
		[L["Restoration"]] = true,
		[L["Restore Energy"]] = true,
		[L["Recently Bandaged"]] = true,
		[L["Iron Grenade"]] = true,
		[L["Thorium Grenade"]] = true,
		[L["Goblin Sapper Charge"]] = true,
		[L["Flash Bomb"]] = true,
		[L["Arcane Bomb"]] = true,
		[L["Sleep"]] = true,
		[L["Flee"]] = true,
		[L["Gnomish Rocket Boots"]] = true,
		[L["Goblin Rocket Boots"]] = true,
		[L["Running Speed"]] = true,
		[L["Gnomish Mind Control Cap"]] = true,
		[L["Reckless Charge"]] = true
		}
}

function getTableLength(t)
	local count = 0;
	for _ in pairs(t) do 
		count = count + 1 
	end
	return count
end

function tableContainsKey(t, key)
	for k in pairs(t) do
		if k == key then
			return true
		end
	end
	return false
end

function ECDC_UpdateSavedVariables()
	-- Look for added stuff in classPanels and add it to savedOptions
	for k,v in pairs(classPanels) do
		if not tableContainsKey(savedOptions, k) then
			savedOptions[k] = v
			break;
		end
		for i,j in pairs(v) do
			if not tableContainsKey(savedOptions[k], i) then
				savedOptions[k][i] = j
			end
		end
	end
	
	-- Look for removed stuff in classPanels and remove it from savedOptions
	for k,v in pairs(savedOptions) do
		if not tableContainsKey(classPanels, k) then
			savedOptions[k] = nil
			break;
		end
		for i,j in pairs(v) do
			if not tableContainsKey(classPanels[k], i) then
				savedOptions[k][i] = nil
			end
		end
	end
end

function ECDC_CreateOptionsMenu()
	if addon.panel then return end -- évite double exécution
	if not savedOptions or savedOptions == nil then
		savedOptions = classPanels
	end
	
	if savedVersion == nil or savedVersion ~= addon.version then
		ECDC_UpdateSavedVariables()
		savedVersion = addon.version
		print("|cff1a9fc0ECDC|r: Variables reloaded.")
	end
	
	classPanels = savedOptions

	-- Main panel
	addon.panel = CreateFrame("Frame", ADDON_NAME.."panel")
	addon.panel.name = ADDON_NAME
	addon.panel:Hide()
	
	local p1 = addon.panel
	
	p1.checkbox1 = CreateFrame("CheckButton", ADDON_NAME.."_p1_checkbox1", p1, "ChatConfigCheckButtonTemplate")
	local texture = p1.checkbox1:CreateTexture(nil, "BACKGROUND")
	texture:SetHeight(45)
	texture:SetWidth(40)
	texture:SetTexture("Interface\\Buttons\\UI-MicroButton-Abilities-Up.blp")
	p1.checkbox1:SetPoint("TOPLEFT", p1, 50, -70)
	_G[p1.checkbox1:GetName().."Text"]:SetText(L["Hide the fist icon: "])
	_G[p1.checkbox1:GetName().."Text"]:SetPoint("LEFT",  p1.checkbox1, "RIGHT", 3, 1)
	texture:SetPoint("LEFT", _G[p1.checkbox1:GetName().."Text"], "RIGHT", 3, 8)
	p1.checkbox1.tooltip = L["Check to hide the fist icon."]
	p1.checkbox1:Show()
	if ECDC_Visi == "hide" then
		p1.checkbox1:SetChecked(true)
	else
		p1.checkbox1:SetChecked(false)
	end
	p1.checkbox1:SetScript("OnClick", function(self, button, down)
		if  p1.checkbox1:GetChecked() then
			addon.ECDC_ToggleVisi("hide")
		else
			addon.ECDC_ToggleVisi("show")
		end
	end)
	
	p1.checkbox2 = CreateFrame("CheckButton", ADDON_NAME.."_p1_checkbox2", p1, "ChatConfigCheckButtonTemplate")
	p1.checkbox2:SetPoint("TOPLEFT", p1.checkbox1, 300, 0)
	_G[p1.checkbox2:GetName().."Text"]:SetText(L["Show test icons"])
	_G[p1.checkbox2:GetName().."Text"]:SetPoint("LEFT",  p1.checkbox2, "RIGHT", 3, 1)
	p1.checkbox2.tooltip = L["Check to show test icons."]
	p1.checkbox2:Show()
	if ECDC_ShowTestIcons == true then
		p1.checkbox2:SetChecked(true)
	else
		p1.checkbox2:SetChecked(false)
	end
	p1.checkbox2:SetScript("OnClick", function(self, button, down)
		if  p1.checkbox2:GetChecked() then
			ECDC_ShowTestIcons = true
			for i = 1, 10 do
				_G[("ECDC_Tex"..i)]:Show();
			end
		else
			ECDC_ShowTestIcons = false
			for i = 1, 10 do
				_G[("ECDC_Tex"..i)]:Hide();
			end
		end
	end)
	
	p1.checkbox3 = CreateFrame("CheckButton", ADDON_NAME.."_p1_checkbox3", p1, "ChatConfigCheckButtonTemplate")
	p1.checkbox3:SetPoint("TOPLEFT", p1.checkbox2, 0, -50)
	_G[p1.checkbox3:GetName().."Text"]:SetText(L["Hide blizzard icon borders"])
	_G[p1.checkbox3:GetName().."Text"]:SetPoint("LEFT",  p1.checkbox3, "RIGHT", 3, 1)
	p1.checkbox3.tooltip = L["Check to hide the blizzard icon borders."]
	p1.checkbox3:Show()
	if ECDC_Border == true then
		p1.checkbox3:SetChecked(true)
	else
		p1.checkbox3:SetChecked(false)
	end
	p1.checkbox3:SetScript("OnClick", function(self, button, down)
		if  p1.checkbox3:GetChecked() then
			ECDC_Border = true
		else
			ECDC_Border = false
		end
	end)
	
	p1.checkbox4 = CreateFrame("CheckButton", ADDON_NAME.."_p1_checkbox4", p1, "ChatConfigCheckButtonTemplate")
	p1.checkbox4:SetPoint("TOPLEFT", p1.checkbox3, 0, -50)
	_G[p1.checkbox4:GetName().."Text"]:SetText(L["Enable vertical grow"])
	_G[p1.checkbox4:GetName().."Text"]:SetPoint("LEFT",  p1.checkbox4, "RIGHT", 3, 1)
	p1.checkbox4.tooltip = L["Check to enable vertical grow instead of horizontal."]
	p1.checkbox4:Show()
	if ECDC_Pos == "Verti" then
		p1.checkbox4:SetChecked(true)
	else
		p1.checkbox4:SetChecked(false)
	end
	p1.checkbox4:SetScript("OnClick", function(self, button, down)
		if  p1.checkbox4:GetChecked() then
			addon.ECDC_ToggleStack("Verti")
		else
			addon.ECDC_ToggleStack("Hori")
		end
	end)
	
	p1.slider1 = CreateFrame("Slider", ADDON_NAME.."slider1", p1, "OptionsSliderTemplate")
	p1.slider1:SetPoint("TOPLEFT", p1.checkbox1, 3, -50)
	_G[p1.slider1:GetName().."Text"]:SetText(L["Icon size: "] .. string.format("%.0f", ECDC_Size*100).."%")
	p1.slider1.tooltipText = L["Drag to set icon size"]
	_G[p1.slider1:GetName().."Low"]:SetText("50%")
	_G[p1.slider1:GetName().."High"]:SetText("150%")
	p1.slider1:SetWidth(150)
	p1.slider1:SetMinMaxValues(0.5, 1.5)
	p1.slider1:SetValue(ECDC_Size)
	p1.slider1:SetValueStep(0.1)
	p1.slider1:SetScript("OnValueChanged", function(self, value)
		_G[p1.slider1:GetName().."Text"]:SetText(L["Icon size: "] .. string.format("%.0f", math.round(value, 0.1)*100).."%")
		addon.ECDC_SetSize(math.round(value, 0.1))
		p1.slider1:SetValue(math.round(value, 0.1))
	end)
	
	p1.slider2 = CreateFrame("Slider", ADDON_NAME.."slider2", p1, "OptionsSliderTemplate")
	p1.slider2:SetPoint("TOPLEFT", p1.slider1, 0, -50)
	_G[p1.slider2:GetName().."Text"]:SetText(L["Rows: "] .. ECDC_Row)
	p1.slider2.tooltipText = L["Drag to set the amount of rows"]
	_G[p1.slider2:GetName().."Low"]:SetText("1")
	_G[p1.slider2:GetName().."High"]:SetText("2")
	p1.slider2:SetWidth(150)
	p1.slider2:SetMinMaxValues(1, 2)
	p1.slider2:SetValue(ECDC_Row)
	p1.slider2:SetValueStep(1)
	p1.slider2:SetScript("OnValueChanged", function(self, value)
		_G[p1.slider2:GetName().."Text"]:SetText(L["Rows: "] .. value)
		addon.ECDC_Rows(math.round(value, 1))
		p1.slider2:SetValue(math.round(value, 1))
	end)
	
	p1.slider3 = CreateFrame("Slider", ADDON_NAME.."slider3", p1, "OptionsSliderTemplate")
	p1.slider3:SetPoint("TOPLEFT", p1.slider2, 0, -50)
	_G[p1.slider3:GetName().."Text"]:SetText(L["Padding: "] .. ECDC_Padding)
	p1.slider3.tooltipText = L["Drag to adjust padding between icons."]
	_G[p1.slider3:GetName().."Low"]:SetText("0")
	_G[p1.slider3:GetName().."High"]:SetText("5")
	p1.slider3:SetWidth(150)
	p1.slider3:SetMinMaxValues(0, 5)
	p1.slider3:SetValue(ECDC_Padding)
	p1.slider3:SetValueStep(1)
	p1.slider3:SetScript("OnValueChanged", function(self, value)
		_G[p1.slider3:GetName().."Text"]:SetText(L["Padding: "] .. value)
		ECDC_Padding = math.round(value, 1)
		addon.ECDC_ToggleStack(ECDC_Pos)
		p1.slider3:SetValue(math.round(value, 1))
	end)
	
	p1.button1 = CreateFrame("Button", ADDON_NAME.."button1", p1, "UIPanelButtonTemplate")
	p1.button1:SetPoint("TOPLEFT", p1.checkbox4, 20, -50)
	_G[p1.button1:GetName().."Text"]:SetText(L["Reload Variables"])
	p1.button1:SetSize(122, 22)
	p1.button1:SetScript("OnClick", function()
		ECDC_UpdateSavedVariables()
		print("|cff1a9fc0ECDC|r: Variables reloaded.")
	end)
	
	p1.info = p1:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	p1.info:SetPoint("CENTER", p1, 0, -20)
	p1.info:SetText("|cff1a9fc0Hold left-click|r on the fist button to drag it around. \n"..
					"|cff1a9fc0Right-click|r the fist button once to enable/disable the addon temporarily. \n"..
					"|cff1a9fc0Shift + Right-click|r the CD icons will remove them. \n")
	
	local stub = AceConfigDialog:AddToBlizOptions("ECDC_Main", "ECDC")
	stub:HookScript("OnShow", function()
	  addon.panel:SetParent(stub)
	  addon.panel:SetAllPoints()
	  addon.panel:Show()
	end)

	stub:HookScript("OnHide", function()
	  addon.panel:Hide()
	end)

	---- Subpanels
	for class, spells in pairsByKeys(classPanels) do
		local subPanel = CreateFrame("Frame", ADDON_NAME.."_"..class.."Panel")
		subPanel.name = class
		subPanel:Hide()

		local index, row, col = 1, 1, 1

		for spell in pairsByKeys(spells) do
			if spell ~= "" then
				local checkbox = CreateFrame("CheckButton", ADDON_NAME.."_"..class.."_checkbox"..index, subPanel, "ChatConfigCheckButtonTemplate")
				checkbox.text = spell
				local texture = checkbox:CreateTexture(nil, "BACKGROUND")
				texture:SetSize(16, 16)
				texture:SetPoint("LEFT", checkbox, "RIGHT", 3, 1)

				if row > 11 then
					col = col + 20
					row = 1
				end
				checkbox:SetPoint("TOPLEFT", subPanel, 10 * col, -60 - (25 * (row - 1)))

				if string.len(spell) > 24 then
					_G[checkbox:GetName().."Text"]:SetText(spell:sub(1, 20) .. "...")
				else
					_G[checkbox:GetName().."Text"]:SetText(spell)
				end
				_G[checkbox:GetName().."Text"]:SetPoint("LEFT", texture, "RIGHT", 3, 1)

				addon.ECDC_LoadSkills()
				for _, v in pairs(ECDC_Skills) do
					if spell == v.name then
						texture:SetTexture("Interface\\Icons\\" .. v.icon)
						checkbox.tooltip = v.desc
					end
				end

				checkbox:SetChecked(spells[spell])
				checkbox:SetScript("OnClick", function(self)
					for c, s in pairs(savedOptions) do
						if s[spell] ~= nil then
							s[spell] = self:GetChecked()
						end
					end
				end)

				checkbox:Show()
				row = row + 1
				index = index + 1
			end
		end

		-- Enregistrement Ace3 pour sous-catégorie
		local stubID = ADDON_NAME.."_"..class.."_Stub"
		AceConfig:RegisterOptionsTable(stubID, { type = "group", name = class, args = {} })
		local stub = AceConfigDialog:AddToBlizOptions(stubID, class, ADDON_NAME)

		stub:HookScript("OnShow", function()
			subPanel:SetParent(stub)
			subPanel:SetAllPoints()
			subPanel:Show()
		end)
		stub:HookScript("OnHide", function()
			subPanel:Hide()
		end)
	end
end

function pairsByKeys(t, f) -- Used for sorting the panels and spells by name
	local a = {}
	if (t == classPanels) then
		for n in pairs(t) do
			if n ~= L["Miscellaneous"] and n ~= L["Racials"] and n ~= L["Trinkets"] then
				table.insert(a, n)
			end
		end
		table.sort(a, f)
		table.insert(a, L["Racials"])
		table.insert(a, L["Trinkets"])
		table.insert(a, L["Miscellaneous"])
	else
		for n in pairs(t) do
			table.insert(a, n)
		end
		table.sort(a, f)
	end
    local i = 0
    local iter = function()
        i = i + 1
        if a[i] == nil then 
			return nil
        else 
			return a[i], t[a[i]]
        end
     end
     return iter
end

--Fix for weird slider value
function math.sign(v)
	return (v >= 0 and 1) or -1
end

function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end