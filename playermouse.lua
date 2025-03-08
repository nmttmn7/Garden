require 'module'
local Cores = require('Resources.colors')


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

       for _, value in ipairs(M) do
            value:Draw()
       end
    else
        x,y = nil
    end
end

function Teha(x,y)
    local difference = x % 64
    local floor = math.floor(x / 64)

    print(difference .. ' fkoor ' .. floor)

    
end


