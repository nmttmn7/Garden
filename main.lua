--require('world')
--require('entity')
--require('node')

require 'constants'

push = require 'push-master/push'

require 'Mundo/mundo'
require 'Entidade.Plantar.tulipa'
require 'playermouse'

local Telha = require('telha')
local Criaturas = {}
local Plantas = {Tulipa:Construir('tulipa',0,0)}


local Telhas = {}

CursorTelha = Telha.water


local MundoX, MundoY = love.window.getDesktopDimensions()

function Plantas:Adicionar(value)
    table.insert(Plantas,value)
end

function GerarTelha()
    local mX = MundoX / TamanhoDaCelula
    local mY = MundoY / TamanhoDaCelula
    for y = 1, mY do
    for x = 1, mX do
        table.insert(Telhas, Telha.dirt)
    end
    end


    gMundo = Mundo:Construir(Telhas,mX,mY)
end



function love.load()

    text = "Type away! -- "

    GerarTelha()
    love.mouse.setVisible(false)
 
    
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
    {fullscreen=true,
    vsync=true,
    resizable =true})
    

    --formiga = Formiga:Construir('Antanas')

   -- table.insert(Criaturas, formiga)

end

function love.textinput(t)
    text = text .. t
end

function love.update(dt)
 
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.resize(w,h)
   -- push:resize(w,h)
end
function love.draw()
   -- push:start()
    
    gMundo:Empate()
   -- Rato:Draw()

    EntidadeEmpate()

    Rato:Atualizar()
    Rato:Empate()
    
    leftDown = love.mouse.isDown(1)

    if leftDown then
        
        local Lx,Ly = love.mouse.getPosition( )
        
        love.graphics.print(Lx .. " eee " .. Ly)
        
        MudarTelha(Lx,Ly)

    end

    love.graphics.printf(text, 0, 0, love.graphics.getWidth())

    
  --  push:finish()
end

function EntidadeEmpate()
    
    for _, c in ipairs(Criaturas) do
        c:Empate()
    end

    for _, p in ipairs(Plantas) do
        p:Empate()
    end
end



function MudarTelha(x,y)

    local floorX = math.floor(x / TamanhoDaCelula)
    local floorY = math.floor(y / TamanhoDaCelula)


    gMundo:MudarTelha(floorX,floorY,CursorTelha)
    
end
