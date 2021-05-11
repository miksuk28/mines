function love.load()
    require "field"
    load_images()
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

function love.draw(dt)
    draw_field()
end

function love.keypressed(k)
    table.insert(keyPresses, k)
end