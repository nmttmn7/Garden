
require('Recursos.constantes')
require('Fabrica.salvarcarregarfabrica')

local Mundo = {}
Mundo.__index = Mundo

local Telhas = {}

TamanhoDaCelula = 40

local MundoX, MundoY = love.window.getDesktopDimensions()

function Mundo:Construir(telhas,largura,altura)
    local this = {
        telhas = telhas, --Tiles
        largura = largura, --Width
        altura = altura, --Height
        tamanhoDaCelula = TamanhoDaCelula --CellSize
    }
    setmetatable(this,self)

    return this
end


function Mundo:Empate()
    for row=0,self.altura-1 do 
        for col=0,self.largura-1 do
            local sx = col * self.tamanhoDaCelula
            local sy = row * self.tamanhoDaCelula
            local telha = self:ObterTelha(col,row)

       
                
                --love.graphics.rectangle('line',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)

            love.graphics.setColor(love.math.colorFromBytes(telha))
            love.graphics.rectangle('fill',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)
            love.graphics.setColor(1,1,1,1)
            
            
        end
    end
end

function Mundo:ObterTelha(x,y)

    if x < 0 or y < 0 or x > self.largura-1 or y > self.altura-1 then
        return -1
    end

    return self.telhas[y * self.largura + x + 1]
end

function Mundo:ObterTelaTelha(x,y)

    local floorX = math.floor(x / TamanhoDaCelula)
    local floorY = math.floor(y / TamanhoDaCelula)

    return self:ObterTelha(floorX,floorY)
end



function Mundo:MudarTelha(x,y,tileType)
    if x < 0 or y < 0 or x > self.largura-1 or y > self.altura-1 then
        return false
    end

    self.telhas[y * self.largura + x + 1] = tileType

   
   
    for index, value in ipairs(RegistroDeEntidade) do

        value:VerificarPoderPlantar(index)

    end

    return true
end






local function GerarTelha()
    
    local dato = Carregar('mundo.json')
    
if #dato['telhas'] == nil then
        
    
    local mX = MundoX / TamanhoDaCelula
    local mY = MundoY / TamanhoDaCelula
    for y = 1, mY do
    for x = 1, mX do
        table.insert(Telhas, Telha['sujeira'])
    end
    end

    gMundo = Mundo:Construir(Telhas,mX,mY)

else
    gMundo = Mundo:Construir(dato['telhas'],dato['largura'],dato['altura'])
end

end

function CarregarMundo()
    GerarTelha()
end

return Mundo