require 'module'
require('Recursos.constantes')


Rato = {}
Rato.__index = Rato


M = {Modulos:Construir(0,0, 'sujeira'),
Modulos:Construir(0,0, 'grama'),
Modulos:Construir(0,0, 'agua')}

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
      --  GerarEntidade(Lx,Ly)
        --MudarTelha(Lx,Ly)
        RegarAsPlantas()

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



function Rato:Desenhar()

    love.graphics.setColor(love.math.colorFromBytes(Telha[CursorTelha]))
    local x, y = love.mouse.getPosition()
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y, 10)

end

function CliqueEsquerdo()

end

function CliqueDireito()
    
end

function GerarEntWPWPWPWPWPPWPidade(x,y)

    local Rx,Ry = love.mouse.getPosition( )
    
    
    local ratoTelha = gMundo:ObterTelaTelha(Rx,Ry)

    for _, value in pairs(Tulipa.PoderPlantar) do
        
        if value == ratoTelha then
            RegistroDeEntidade:Adicionar(Tulipa:Construir('tulipa',Rx,Ry))
            --Plantas:Adicionar(Tulipa:Construir('tulipa',Rx,Ry))
        end

    end
    
end

function RegarAsPlantas() -- Water(verb) The Plants
    for _, value in ipairs(RegistroDeEntidade) do
        local posicao = value:ObterPosicao()
        local x = posicao.x
        local y = posicao.y
        local Rx, Ry = love.mouse.getPosition()
        local range = 60
        if Rx + range > x and Rx - range < x and Ry + range > y and Ry - range < y then 
            value:AumentarAgua(5)
        end
    end
end