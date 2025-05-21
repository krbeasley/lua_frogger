local xMargin = 25
local yMargin = 25
local winW = love.graphics.getWidth()
local winH = love.graphics.getHeight()

local function titleScreen()
    love.graphics.print("Lua Frogger", xMargin, yMargin, 0, 2)
    love.graphics.print("Make it to the end!", xMargin, yMargin + 36)

    love.graphics.print("Version: 0.1.0", xMargin, winH - (yMargin + 20), 0, 1)
    love.graphics.print("Written with love by Kyle Beasley <3", xMargin, winH - yMargin, 0, 1)
end

local function pauseScreen()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', 0, 0, winW, winH)

    love.graphics.setColor(1,1,1)
    love.graphics.print("Game Paused", xMargin, yMargin)
    love.graphics.print("[ESC / P] Resume       [Q] Quit", xMargin, winH - yMargin)
end

local function mainMenu()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', 0, 0, winW, winH)

    love.graphics.setColor(1,1,1)
    love.graphics.print("Main Menu", xMargin, yMargin, 0, 2)
    love.graphics.print("Press SPACE to begin", xMargin, yMargin + 36)
end

local function controlPanel()
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle('fill', 0, winH - 25, 200, 200)

    love.graphics.setColor(1,1,1)
    love.graphics.print("[WASD/←↑↓→]    Move ", 20, winH - 40)
    love.graphics.print("[ESC / P]      Pause ", 20, winH - 20)
end

return {
    titleScreen = titleScreen,
    pauseScreen = pauseScreen,
    mainMenu = mainMenu,
    controlPanel = controlPanel
}