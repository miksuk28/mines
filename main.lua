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

    mouseX = math.floor(love.mouse.getX() / (field.dim + field.space)) + 1
    mouseY = math.floor(love.mouse.getY() / (field.dim + field.space)) + 1
    
    if debug then print("X: " .. mouseX .. " " .. "Y: " .. mouseY) end
end

function love.draw(dt)
    draw_field()
end

function love.keypressed(k)
    table.insert(keyPresses, k)
end