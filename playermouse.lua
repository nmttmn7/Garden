require 'module'
require 'UI/colors'


Rato = {}
Rato.__index = Rato


M = {Modulos:Construir(0,0, Cores.dirtbrown),
Modulos:Construir(0,0, Cores.grassgreen),
Modulos:Construir(0,0, Cores.waterblue)}

PosicaoRato = nil

function Rato:Load()
    love.mouse.isVisible(false)
    
end

function Rato:Update()
    
end


function Rato:Draw()





    down = love.mouse.isDown(2)

    if down then
        if x == nil then
            x,y = love.mouse.getPosition( )
            Modulos:Order(M,x,y)
        end
        
       -- Rato:OO(x,y)
       for _, value in ipairs(M) do
            value:Draw()
       end
    else
        x,y = nil
    end
end

function Telha(x,y)
    local difference = x % 64
    local floor = math.floor(x / 64)

    print(difference .. ' fkoor ' .. floor)

    
end

function Rato:CirleModules()

end

function Rato:OO(x,y)
    local opacity = 1
    love.graphics.setColor(1,1,1,opacity)
    love.graphics.circle('fill', x, y, 20)

    local s = Modulos[1]
    x, y = love.mouse.getPosition()
    s:MO(Modulos)
    s:Draw()
end

Telha(100,5)