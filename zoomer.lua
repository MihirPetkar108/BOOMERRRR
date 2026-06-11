local spotlightEnabled = false
local overlay = nil
local timer = nil

local RECT_W = 400
local RECT_H = 250
local DIM_ALPHA = 0.85

local function destroySpotlight()
    if timer then
        timer:stop()
        timer = nil
    end

    if overlay then
        overlay:delete()
        overlay = nil
    end
end

local function createSpotlight()
    local screenFrame = hs.screen.mainScreen():fullFrame()

    overlay = hs.canvas.new(screenFrame)

    overlay:level(hs.canvas.windowLevels.overlay)
    overlay:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces)
    overlay:show()

    timer = hs.timer.doEvery(0.01, function()
        local pos = hs.mouse.absolutePosition()

        local left = pos.x - RECT_W / 2
        local top = pos.y - RECT_H / 2

        overlay:replaceElements({
            -- Top
            {
                type = "rectangle",
                action = "fill",
                fillColor = {
                    red = 0,
                    green = 0,
                    blue = 0,
                    alpha = DIM_ALPHA,
                },
                frame = {
                    x = 0,
                    y = 0,
                    w = screenFrame.w,
                    h = math.max(0, top),
                },
            },

            -- Bottom
            {
                type = "rectangle",
                action = "fill",
                fillColor = {
                    red = 0,
                    green = 0,
                    blue = 0,
                    alpha = DIM_ALPHA,
                },
                frame = {
                    x = 0,
                    y = top + RECT_H,
                    w = screenFrame.w,
                    h = math.max(0, screenFrame.h - (top + RECT_H)),
                },
            },

            -- Left
            {
                type = "rectangle",
                action = "fill",
                fillColor = {
                    red = 0,
                    green = 0,
                    blue = 0,
                    alpha = DIM_ALPHA,
                },
                frame = {
                    x = 0,
                    y = top,
                    w = math.max(0, left),
                    h = RECT_H,
                },
            },

            -- Right
            {
                type = "rectangle",
                action = "fill",
                fillColor = {
                    red = 0,
                    green = 0,
                    blue = 0,
                    alpha = DIM_ALPHA,
                },
                frame = {
                    x = left + RECT_W,
                    y = top,
                    w = math.max(
                        0,
                        screenFrame.w - (left + RECT_W)
                    ),
                    h = RECT_H,
                },
            },

            -- Border
            {
                type = "rectangle",
                action = "stroke",
                strokeWidth = 2,
                strokeColor = {
                    white = 1,
                    alpha = 0.15,
                },
                frame = {
                    x = left,
                    y = top,
                    w = RECT_W,
                    h = RECT_H,
                },
            },
        })
    end)
end


local function smoothZoom(direction, steps)
    local key = direction == "in" and "=" or "-"

    hs.timer.doEvery(0.05, function(t)
        hs.eventtap.keyStroke({"alt", "cmd"}, key)

        steps = steps - 1
        if steps <= 0 then
            t:stop()
        end
    end)
end

local function toggleSpotlight()
    spotlightEnabled = not spotlightEnabled

    if spotlightEnabled then
        createSpotlight()
        smoothZoom("in", 6)

    else
        destroySpotlight()
        smoothZoom("out", 6)

        -- Disable macOS Zoom completely
        hs.eventtap.keyStroke({"alt", "cmd"}, "8")
    end
end

hs.hotkey.bind({"ctrl", "alt"}, "space", toggleSpotlight)