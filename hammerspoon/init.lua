hs = hs
local config = require("config")
local utils = require("utils")

local soundFile = os.getenv("HOME") .. "/Music/SomeBod.mp3"

-- Load sound
local snd = hs.sound.getByFile(soundFile)

local lastClipboard = ""

-- hammerspoon can be your next app launcher!!!!
hs.hotkey.bind({"cmd", "alt"}, "B", function()
    hs.application.launchOrFocus("Arc")
    local arc = hs.appfinder.appFromName("Arc")
    arc:selectMenuItem({"Tabs", "Next Tab"})
end)

hs.hotkey.bind({"cmd", "alt"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

-- Copy selected and append to daily note
hs.hotkey.bind({"cmd", "alt"}, "C", function()
    utils.copySelected(function(clipboardText, err)
        if err then
            hs.alert.show("Error: " .. err)
        else
            local today = os.date("%Y-%m-%d")
            local notePath = obsidianDailyNotePath .. today .. ".md"

            -- if snd then
            --     snd:play()
            --     hs.timer.doAfter(0.8, function()
            --         snd:stop()
            --     end)
            -- else
            --     hs.alert.show("Sound file not found")
            -- end
			utils.bounceAppIcon("Obsidian")

            local err = utils.writeToDocument(clipboardText, notePath)
            if err then
                hs.alert.show("Failed to write to note: " .. err)
            end
        end
    end)
end)
