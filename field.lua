sym = {}
    sym.b = 1
    sym.e = 0

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