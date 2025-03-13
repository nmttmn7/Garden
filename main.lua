--require('world')
--require('entity')
--require('node')

require 'Recursos.constantes'

push = require 'Libraries.push'


require 'Entidade.Plantar.tulipa'
require 'Entidade.Plantar.flor'
require 'playermouse'

require 'Entidade.Plantar.registrodeplantas'
require 'Entidade.registrodeentidade'
local Criaturas = {}


require 'Mundo.mundo'

require 'jogo'
CursorTelha = 'grama'


-------------------------------------Texto
TextoDoUsuario = ''
ObterEntradadaDoUsuario = false
-------------------------------------
function love.load()



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

    if ObterEntradadaDoUsuario == true then

    TextoDoUsuario = TextoDoUsuario .. t

    end
end

function love.update(dt)
    for _, e in ipairs(JogoEntidades) do
        e:Atualizar(dt)
    end

    
end

function love.keypressed(key)


    if key == 'escape' then 
        love.event.quit()
    end

    if key == 'return' then 
        ObterEntradadaDoUsuario = false
        coroutine.resume(rotinaAjudaConstruirNome)
    elseif ObterEntradadaDoUsuario == true then
        return
    end

    if key == 'x' then 
        GerarJogoEntidade('tulipa')
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
    
    gMundo:Desenhar()
   -- Rato:Draw()

   DesenharEntidades()

    Rato:Atualizar()
    Rato:Desenhar()
    
    leftDown = love.mouse.isDown(1)

    if leftDown then
        
        local Lx,Ly = love.mouse.getPosition( )
        
        love.graphics.print(Lx .. " eee " .. Ly)
        
        MudarTelha(Lx,Ly)

    end

    love.graphics.printf("Name: " .. TextoDoUsuario, 0, 0, love.graphics.getWidth())

    
  --  push:finish()

end

function DesenharEntidades()
    

    for _, e in ipairs(JogoEntidades) do
        e:Desenhar()
    end
end



function MudarTelha(x,y)

    local floorX = math.floor(x / TamanhoDaCelula)
    local floorY = math.floor(y / TamanhoDaCelula)


    gMundo:MudarTelha(floorX,floorY,CursorTelha)
    
end
