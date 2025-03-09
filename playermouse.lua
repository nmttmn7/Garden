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



function Teha(x,y)
    local difference = x % 64
    local floor = math.floor(x / 64)

    print(difference .. ' fkoor ' .. floor)

    
end


function Rato:Atualizar() --Mouse:Update


    leftDown = love.mouse.isDown(1)

    if leftDown then
        
        local Lx,Ly = love.mouse.getPosition( )
        
        love.graphics.print(Lx .. " eee " .. Ly)
        GerarEntidade(Lx,Ly)
        MudarTelha(Lx,Ly)

    end



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

function Rato:Empate()

    love.graphics.setColor(love.math.colorFromBytes(CursorTelha))
    local x, y = love.mouse.getPosition()
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y, 10)

end

function CliqueEsquerdo()

end

function CliqueDireito()
    
end

function GerarEntidade(x,y)
    Plantas:Adicionar(Tulipa:Construir('tulipa',x,y))
end