--require('world')
--require('entity')
--require('node')

require 'constants'

push = require 'Libraries.push'


require 'Entidade.Plantar.tulipa'
require 'Entidade.Plantar.flor'
require 'playermouse'
require('telha')
require 'Entidade.Plantar.registrodeplantas'
local Criaturas = {}


local Mundo = require('Mundo.mundo')

local Telhas = {}

CursorTelha = Telha.water


local MundoX, MundoY = love.window.getDesktopDimensions()



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

local timer = 0
local interval = 60
function love.textinput(t)
   -- text = text .. t
end

function love.update(dt)
    for _, p in ipairs(RegistroDePlantas) do
        p:Atualizar(dt)
    end

    
end

function love.keypressed(key)
    if key == 'r' then 
        GerarEntidade(0,0)
    end
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

    --love.graphics.printf(text, 0, 0, love.graphics.getWidth())

    
  --  push:finish()
end

function EntidadeEmpate()
    
    for _, c in ipairs(Criaturas) do
        c:Empate()
    end

    for _, p in ipairs(RegistroDePlantas) do
        p:Empate()
    end
end



function MudarTelha(x,y)

    local floorX = math.floor(x / TamanhoDaCelula)
    local floorY = math.floor(y / TamanhoDaCelula)


    gMundo:MudarTelha(floorX,floorY,CursorTelha)
    
end
