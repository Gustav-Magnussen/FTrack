local function Monitor()
    -- Manual slash command Fallen Charger Monitor
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
    frame:SetScript("OnEvent", function(self, event, message)
        if event == "CHAT_MSG_MONSTER_EMOTE" and message:match("An earsplitting whinny echoes across the Maw as the Fallen Charger begins its ride.") then
            DEFAULT_CHAT_FRAME:AddMessage("Fallen Charger detected!")
            PlaySound(8960, "Master")
        end
    end)
end

local function auto()
    -- Automatic Fallen Charger Monitor when entering The Maw
    local currentZone = GetZoneText()
    if currentZone == "The Maw" then
        DEFAULT_CHAT_FRAME:AddMessage("Fallen Charger Started Monitoring")
        Monitor()
    end
    local zoneFrame = CreateFrame("Frame")
    zoneFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    zoneFrame:SetScript("OnEvent", function(self, event)
        if GetZoneText() == "The Maw" then
            DEFAULT_CHAT_FRAME:AddMessage("Fallen Charger Started Monitoring")
            Monitor()
        end
    end)
end

local function interfacePanel()
    -- Panel
    local panel = CreateFrame("Frame", "FallenMonitorPanel", UIParent)
    panel.name = "Fallen Monitor"
    InterfaceOptions_AddCategory(panel)

    -- Title
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Fallen Monitor")

    -- Description
    local description = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    description:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    description:SetPoint("RIGHT", -32, 0)
    description:SetHeight(32)
    description:SetJustifyH("LEFT")
    description:SetJustifyV("TOP")
    description:SetText("Monitor Fallen Charger and play sound when detected.")
end

interfacePanel()
auto()
