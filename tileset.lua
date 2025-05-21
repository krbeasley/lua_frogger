local common = require "common"

local winW = love.graphics.getWidth()
local winH = love.graphics.getHeight()

local grass = {
    r = 37/256,
    g = 172/256,
    b = 26/256,
}

local road = {
    r = 50/256,
    g = 50/256,
    b = 50/256,
}

local background = {
    r = 119/256,
    g = 221/256,
    b = 236/256,
}

local lanes = {}

local function updateDimensions()
    winH = love.graphics.getHeight()
    winW = love.graphics.getWidth()
end

local function drawBackground()
    love.graphics.setBackgroundColor(background.r, background.g, background.b)
end

local function drawScoreboard()
    love.graphics.setColor(.12, .112, .122)
    love.graphics.rectangle('fill', 0, 0, 300, 600)

    -- title & score
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Lua Frogger", 25, 25, 0, 2)
    love.graphics.print("Score: " .. player.score, 25, 60, 0, 1.5)

    if game.debug then
        love.graphics.print("Mobs No: " .. common.getTableSize(mobs_list), 25, 80)
        love.graphics.print("Input: " .. current_input, 25, 100)
        love.graphics.print("Running: " .. tostring(game.running), 25, 120)
        love.graphics.print("Paused: " .. tostring(game.paused), 25, 140)
    end
end

local function drawMap()
    local row_height = winH / 9
    local y_offset = 0

    for i = 1, 9, 1 do
        local lane_y_val = (row_height * y_offset) + ((row_height / 2) / 2)

        if y_offset == 0 or y_offset % 2 == 0 then
            love.graphics.setColor(grass.r, grass.g, grass.b)
            table.insert(lanes, { isRoad = false, y = lane_y_val })
        else
            love.graphics.setColor(road.r, road.g, road.b)
            table.insert(lanes, { isRoad = true, y =  lane_y_val })
        end

        love.graphics.rectangle('fill', winW - winH, (row_height * y_offset), winH, row_height)

        if game.debug then
            love.graphics.setColor(0,0,0)
            love.graphics.print("Is Road: " .. tostring(lanes[i].isRoad), 500, (row_height * y_offset))
            love.graphics.print("Y Value: " .. tostring(lanes[i].y), 500, (row_height * y_offset) + 20)
        end

        y_offset = i
    end
end

local function spawnMob()
    local road_lanes = {}

    for _, lane in pairs(lanes) do
        if lane.isRoad == true then
            table.insert(road_lanes, lane)
        end
    end

    local lane_no = math.random(common.getTableSize(road_lanes))
    local target_lane = road_lanes[lane_no]

    table.insert(mobs_list, {x = winW, y = target_lane.y, visible = false})
end

return {
    drawBackground = drawBackground,
    drawScoreboard = drawScoreboard,
    drawMap = drawMap,
    updateDimensions = updateDimensions,
    spawnMob = spawnMob
}