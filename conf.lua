field = {}
    field.mines = {}
    field.w = 10
    field.h = 10
    field.dim = 50
    field.space = 5
    field.opened = {}

function love.conf(t)
    t.window.title = "Mines"
    t.window.width =  (field.dim + field.space) * field.w
    t.window.height = (field.dim + field.space) * field.h
    t.console = true
end