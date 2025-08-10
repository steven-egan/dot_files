local function copySelected(cb)
	local app = hs.application.frontmostApplication()
    if not app then
        cb(nil, "No frontmost application")
    end

    -- Refocus app in case focus lost
    app:activate()

    -- Wait to ensure app is ready for keystrokes
    hs.timer.doAfter(0.1, function()
        local eventtap = hs.eventtap

        -- Send Cmd+C keydown + keyup
        local keyDown = eventtap.event.newKeyEvent({"cmd"}, "c", true)
        local keyUp = eventtap.event.newKeyEvent({"cmd"}, "c", false)
        keyDown:post()
        keyUp:post()

        -- Wait for clipboard to update
        hs.timer.doAfter(0.2, function()
            local clipboardText = hs.pasteboard.getContents() or ""

            if clipboardText == "" then
				cb(nil, "No text copied")
            elseif clipboardText == lastClipboard then
                hs.alert.show("Clipboard unchanged")
				cb(clipboardText, nil)
            else
                lastClipboard = clipboardText
                cb(clipboardText, nil)
            end
        end)
    end)
end

local function writeToDocument(text, path)
	local file = io.open(path, "a")
	if not file then
		return false, "Failed to open file: " .. path
	end

	file:write("\n" .. text)
	file:close()
	return true, nil
end

-- Function to get an app's icon path by name
local function getAppIconPath(appName)
    -- local app = hs.application.find(appName)
    local bundlePath = nil
    -- if app ~= nil then
    --     bundlePath = app:bundlePath()
    -- end
    if not bundlePath then
        local possiblePaths = {
            -- os.getenv("HOME") .. "/Applications/" .. appName .. ".app",
            "/Applications/" .. appName .. ".app",
            -- "/System/Applications/" .. appName .. ".app",
        }
        for _, path in ipairs(possiblePaths) do
            if hs.fs.attributes(path) then
                bundlePath = path
                break
            end
        end
    end
    if not bundlePath then return nil end

    local resourcesPath = bundlePath .. "/Contents/Resources/"
    for file in hs.fs.dir(resourcesPath) do
        if file:match("%.icns$") then
            return resourcesPath .. file
        end
    end
    return nil
end


local function bounceImage(image)
    -- Define size of icon on screen
    local iconSize = 64

    -- Calculate position: top-right with some margin
    local screen = hs.screen.mainScreen()
    local screenFrame = screen:frame()
    local x = screenFrame.x + screenFrame.w - iconSize - 20
    local y = screenFrame.y + 40

    -- Create the drawing object
    local iconDrawing = hs.drawing.image(hs.geometry.rect(x, y, iconSize, iconSize), image)
    iconDrawing:setLevel(hs.drawing.windowLevels.floating) -- keep it on top
    iconDrawing:show()

    -- Bounce animation parameters
    local bounceHeight = 30
    local duration = 0.6
    local steps = 20
    local stepTime = duration / steps
    local currentStep = 0

    local timer

    timer = hs.timer.doEvery(stepTime, function()
        currentStep = currentStep + 1
        local progress = currentStep / steps
        -- Simple ease-out bounce using sine wave
        local dy = math.sin(progress * math.pi) * bounceHeight

        iconDrawing:setFrame(hs.geometry.rect(x, y - dy, iconSize, iconSize))

        if currentStep >= steps then
            timer:stop()
            iconDrawing:delete()
        end
    end)
end

local function bounceAppIcon(appName)
	local iconPath = getAppIconPath(appName)
	if not iconPath then
		hs.alert.show("Icon not found for " .. appName)
		return
	end

	local image = hs.image.imageFromPath(iconPath)
	if not image then
		hs.alert.show("Failed to load icon image")
		return
	end

	bounceImage(image)
end

return {
    copySelected = copySelected,
    writeToDocument = writeToDocument,
    getAppIconPath = getAppIconPath,   
    bounceAppIcon = bounceAppIcon,
}
