local function createNewInstance()
    player = {}
    player.score = 0
    player.x = 0
    player.y = 0
    player.rotation = 0
    player.radius = 25

    return player
end

return {
    createNewInstance = createNewInstance
}