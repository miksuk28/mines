function love.load()
    require "field"
    keyPresses = {}

    debug = true
    generateField(20)
end

function love.update(dt)
    for i = 1, #keyPresses do
        local key = keyPresses[i]

        if key == "escape" then love.event.quit() end
        print(key)
        table.remove(keyPresses, i)
        print(#keyPresses)
    end
end

function love.draw()

end

function love.keypressed(k)
    table.insert(keyPresses, k)
end