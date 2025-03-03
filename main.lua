--require('world')
--require('entity')
--require('node')

require 'constants'
push = require 'push-master/push'

require 'Mundo/mundo'
require 'Criaturas/formiga'

local Entidades = {}

local Tiles = {
    0,0,0,0,0,0,0,0,
    0,0,0,1,0,0,0,0,
    0,0,1,1,0,1,0,0,
    0,0,1,0,0,1,0,0,
    0,0,0,0,0,1,0,0,
    0,0,0,0,0,0,0,0,
}

local gMundo = Mundo:Construir(Tiles,8,6)

function love.load()
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {fullscreen=false,
    vsync=true,
    resizable =true})
    local show_debugging = true

    formiga = Formiga:Construir('Antanas')

    table.insert(Entidades, formiga)
    gMundo:MudarTelha(1,1,2)
    gMundo:MudarTelha(1,3,3)
    
end

function love.update(dt)
    formiga:Update()
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.draw()
    gMundo:Empate()
    --formiga:Draw()
    
end