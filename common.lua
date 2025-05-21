local function getTableSize(T)
    local count = 0
    for _, _ in pairs(T) do
        count = count + 1
    end
    return count
end

return {
    getTableSize = getTableSize
}