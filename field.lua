-- ## field.lua ##--

sym = {}
    sym.b =             1
    sym.e =             0
    sym.closed =        9
    sym.hovered =       10
    sym.pressed_down =  11
    sym.bomb =          12
    sym.exploded =      13
    sym.flag =          14
    sym.no_bomb =       15
    sym.empty =         16

function load_images()
    local dir = "assets"
    imgs = {
        love.graphics.newImage(dir .. "/1.png"),
        love.graphics.newImage(dir .. "/2.png"),
        love.graphics.newImage(dir .. "/3.png"),
        love.graphics.newImage(dir .. "/4.png"),
        love.graphics.newImage(dir .. "/5.png"),
        love.graphics.newImage(dir .. "/6.png"),
        love.graphics.newImage(dir .. "/7.png"),
        love.graphics.newImage(dir .. "/8.png"),
        love.graphics.newImage(dir .. "/closed.png"),
        love.graphics.newImage(dir .. "/hovered.png"),
        love.graphics.newImage(dir .. "/pressed_down.png"),
        love.graphics.newImage(dir .. "/bomb.png"),
        love.graphics.newImage(dir .. "/exploded.png"),
        love.graphics.newImage(dir .. "/flag.png"),
        love.graphics.newImage(dir .. "/no_bomb.png"),
        love.graphics.newImage(dir .. "/empty.png"),
    }
end

local function generate_opened()
    field.opened = {}

    for y = 1, field.h do
        local row_x = {}
        for x = 1, field.w do
            table.insert(row_x, sym.e)
        end
        table.insert(field.opened, row_x)
    end

    if debug then
        print("\nOpened field generated")
    end
end

-- debug
local function print_opened()
    if debug then
        print("\n")
        for y = 1, #field.opened do
            local row_x = ""
            for x = 1, #field.opened[1] do
                local cell = field.opened[y][x]
                
                if type(cell) == "number" then
                    row_x = row_x .. " " .. cell .. " "
                else
                    row_x = row_x .. "'" .. cell .. "'"
                end
            end
            print(row_x)
        end
        print("\n")
    end
end

function generateField(number_of_mines)
    --1 = bomb
    field.mines = {}
    local row_print = ""

    for y = 1, field.h do
        local row_x = {}
        for x = 1, field.w do
            table.insert(row_x, sym.e)
        end
        table.insert(field.mines, row_x)
    end

    generate_opened()

    while number_of_mines > 0 do
        local x = love.math.random(1, field.w)
        local y = love.math.random(1, field.h)

        if field.mines[y][x] ~= sym.b then
            field.mines[y][x] = sym.b
            number_of_mines = number_of_mines - 1
        end
    end

    local function check_cells(x, y)
        local cell_sum = 0

        if field.mines[y][x] == sym.b then
            return 0
        else
            -- sqr 1
            if y>1 and x>1 then
                if field.mines[y-1][x-1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 2
            if y>1 then
                if field.mines[y-1][x] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 3
            if y>1 and x<field.w then
                if field.mines[y-1][x+1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 4
            if x>1 then
                if field.mines[y][x-1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 5
            if x<field.w then
                if field.mines[y][x+1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 6
            if x>1 and y<field.h then
                if field.mines[y+1][x-1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 7
            if y<field.h then
                if field.mines[y+1][x] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
            -- sqr 8
            if x<field.w and y<field.h then
                if field.mines[y+1][x+1] == sym.b then
                    cell_sum = cell_sum + 1
                end
            end
        end

        return cell_sum
    end

    -- Lager tala
    for y = 1, field.h do
        for x = 1, field.w do
            local cell = field.mines[y][x]
            local cell_sum = 0

            if cell ~= sym.b and type(cell) == "number" then
                cell_val = check_cells(x, y)

                if cell_val ~= 0 then
                    field.mines[y][x] = tostring(cell_val)
                end
            end
        end
    end

    --------------------------------
    -- printing av field, viss debug
    if debug then
        print("")
        for y = 1, field.h do
            local row_print = ""
            for x = 1, field.w do
                if type(field.mines[y][x]) == "number" then
                    row_print = row_print .. " " .. field.mines[y][x] .. " "
                else
                    row_print = row_print .. "'" .. field.mines[y][x] .. "'"
                end
            end
            print(row_print)
        end
    end
    --------------------------------
end

--[[
function get_texture(x, y)
    local cell = field.mines[y][x]
    if cell == 0 then
        return 9
    elseif type(cell) == "string" then
        if tonumber(cell) >= 1 and onumber(cell) <= 8 then
            return cell
        elseif cell == sym.closed then
            return 9
        elseif cell == sym.hovered then
            return 10
        elseif cell == sym.pressed_down then
            return 11
        elseif cell == sym.exploded then
            return 13
        elseif cell == sym.flag then
            return 14
        elseif cell == sym.no_bomb then
            return 15
        end
    end
end
--]]

function get_texture(x, y)
    local cell = field.opened[y][x]

    if cell == sym.e then
        return 9
    elseif cell == 1 then
        return sym.bomb
    elseif cell == sym.e then
        print("Tile is empty")
        return sym.empty
    elseif cell == sym.empty then
        return 16
    else
        return tonumber(cell)
    end
end

function draw_field()
    local x_pos = 0
    local y_pos = 0

    for y = 1, field.h do
        for x = 1, field.w do
            if field.opened[y][x] == sym.e and mouseX == x and mouseY == y then
                if keyPresses.right then
                    cell = sym.pressed_down
                    if field.mines[y][x] == 0 then
                        field.opened[y][x] = sym.empty
                    else
                        field.opened[y][x] = field.mines[y][x]
                    end
                    
                elseif keyPresses.left then
                    if field.opened[y][x] == sym.e then
                        cell = sym.flag
                        field.opened[y][x] = sym.flag
                    elseif field.opened[y][x] == sym.flag then
                        cell = sym.closed
                        field.opened[y][x] = sym.empty
                    end
                else
                    cell = sym.hovered
                end

                if debug then print_opened() end
                love.graphics.draw(imgs[cell], x_pos, y_pos, 0, field.scale, field.scale)
            else
                love.graphics.draw(imgs[get_texture(x, y)], x_pos, y_pos, 0, field.scale, field.scale)
            end

            x_pos = field.x_start + (field.dim + field.space) * x
        end
        y_pos = field.y_start + (field.dim + field.space) * y
        x_pos = field.x_start
    end
end