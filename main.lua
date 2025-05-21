local menus = require "menus"
local player_h = require "player"
local tileset_h = require "tileset"

function love.load()
    math.randomseed(os.time())
    -- Set up the game window
    love.window.setMode(800, 600, {vsync = true, msaa = 2})
    love.window.setTitle("Lua Frogger")

    -- Set up the game object
    game = {}
    game.running = false
    game.title_screen = true
    game.main_menu = false
    game.paused = false
    game.debug = true

    if game.title_screen then
        screen_timer = 0
    end

    -- Set up the player object
    player = player_h.createNewInstance()

    -- Set up the mobs list
    mob_timer = 0
    mobs_list = {}

    current_input = ""
end

function love.update(dt)
    if game.running and (game.paused == false) and (game.main_menu == false) then
        -- Generate cars to hit the player
        if mob_timer == 60 then
            tileset_h.spawnMob()
            mob_timer = 0
        else
            mob_timer = mob_timer + 1
        end

        -- Move the mobs right to left
        for _, mob in pairs(mobs_list) do
            mob.x = mob.x - 50 * dt
        end
    end

    -- show the title screen but only for a few seconds before moving onto the main menu
    if game.title_screen then
        if screen_timer > 180 then
            game.title_screen = false
            game.main_menu = true

            screen_timer = nil -- unset this. we don't need it anymore.
        else
            screen_timer = screen_timer + 1
        end
    end
end

function love.mousepressed()
    -- Mouse press can be handled here
end

function love.keypressed(key)
    current_input = key

    if game.running and game.paused == false and game.main_menu == false then
        -- Keybinds for the main game
        if key == "escape" or key == "p" then
            game.paused = true
        end
    elseif game.paused then
        -- Keybinds for the pause screen
        if key == "escape" or key == "p" then
            game.paused = false
        elseif key == "q" then
            love.event.quit()
        end
    elseif game.main_menu then
        -- Keybinds for main menu
        if key == "space" then
            game.main_menu = false
            game.paused = false
            game.running = true
        end
    end
end

function love.keyreleased(key)
    current_input = ""
end

function love.draw()
    if game.running then
        tileset_h.updateDimensions()
        -- Show the game window
        tileset_h.drawBackground()

        -- and the tileset
        tileset_h.drawMap()

        -- draw the mobs
        for _, mob in pairs(mobs_list) do
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle('fill', mob.x, mob.y, 35, 35)

            if game.debug then
                love.graphics.setColor(0,0,0)
                love.graphics.print("Y: " .. tostring(mob.y), mob.x, mob.y)
            end
        end

        -- draw the player


        -- draw the scoreboard
        -- bkg
        tileset_h.drawScoreboard()

        -- draw the controls
        menus.controlPanel()
    end

    if game.paused then
        -- Show the pause screen
        menus.pauseScreen()
    end

    if game.title_screen then
        -- Show the title screen
        menus.titleScreen()
    end

    if game.main_menu then
        menus.mainMenu()
    end
end