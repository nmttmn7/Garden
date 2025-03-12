--require('world')
--require('entity')
--require('node')

require 'Recursos.constantes'

push = require 'Libraries.push'


require 'Entidade.Plantar.tulipa'
require 'Entidade.Plantar.flor'
require 'playermouse'

require 'Entidade.Plantar.registrodeplantas'
local Criaturas = {}


require 'Mundo.mundo'

require 'jogo'
CursorTelha = Telha['agua']



function love.load()

    text = "Type away! -- "

    CarregarMundo()
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
    for _, p in ipairs(RegistroDeEntidade) do
        p:Atualizar(dt)
    end

    
end

function love.keypressed(key)
    if key == 'x' then 
        GerarEntidade(0,0)
    end
    if key == 'escape' then 
        love.event.quit()
    end

    if key == 'r' then 
        JogoNovo()
    end

    if key == 's' then 
        SalvarJogo()
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

    for _, p in ipairs(RegistroDeEntidade) do
        p:Empate()
    end
end



function MudarTelha(x,y)

    local floorX = math.floor(x / TamanhoDaCelula)
    local floorY = math.floor(y / TamanhoDaCelula)


    gMundo:MudarTelha(floorX,floorY,CursorTelha)
    
end
