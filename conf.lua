field = {}
    field.mines = {}
    field.w = 10
    field.h = 10
    field.dim = 50
    field.space = 10

function love.conf(t)
    t.window.width =  (field.dim + field.space) * field.w
    t.window.height = (field.dim + field.space) * field.h
    t.console = true
end