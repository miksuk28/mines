sym = {}
    sym.b = 1
    sym.e = 0

function generateField(mines)
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

    while mines > 0 do
        local x = love.math.random(1, field.w)
        local y = love.math.random(1, field.h)

        if field.mines[y][x] ~= sym.b then
            field.mines[y][x] = sym.b
            mines = mines - 1
        end
    end

    -- Lager tala
    for y = 1, field.h do
        for x = 1, field.w do
            local cell = field.mines[y][x]
            local cell_sum = 0

            if cell ~= sym.b and type(cell) == "number" then
--[[1]]         if y>1 and x>1             then this_cell = field.mines[y-1][x-1]  ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[2]]         if y>1                     then this_cell = field.mines[y-1][x]    ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[3]]         if y>1 and x<field.w       then this_cell = field.mines[y-1][x+1]  ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[4]]         if x>1                     then this_cell = field.mines[y][x-1]    ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[5]]         if x<field.w               then this_cell = field.mines[y][x+1]    ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[6]]         if x>1 and y<field.h       then this_cell = field.mines[y+1][x-1]  ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[7]]         if y<field.h               then this_cell = field.mines[y+1][x]    ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
--[[8]]         if x<field.w and y<field.h then this_cell = field.mines[y+1][x+1]  ; if type(this_cell) == "number" then cell_sum = cell_sum + this_cell end
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
                row_print = row_print .. field.mines[y][x] .. " "
            end
            print(row_print)
        end
    end
    --------------------------------
end