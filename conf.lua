field = {}
    field.mines =   {}
    field.w =       10
    field.h =       10
    field.x_start =  0
    field.y_start =  0
    field.dim =     50
    field.space =    5
    field.scale =    1   
    field.opened =  {}

function love.conf(t)
    t.window.title = "Mines"
    t.window.width =  ((field.dim + field.space) * field.w) - field.space -- 545
    t.window.height = ((field.dim + field.space) * field.h) - field.space -- 545
    t.console = true
end