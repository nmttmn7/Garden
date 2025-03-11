require 'Entidade.entidade'
local Cores = require('Resources.colors')



Tulipa = Entidade:Construir()
Tulipa.__index = Tulipa
Tulipa.PoderPlantar = {Telha.dirt,Telha.grass}
Tulipa.agua = 45
Tulipa.aguaMAX = 69
Tulipa.sede = 2
function Tulipa:Construir(nome,x,y)

    local this = Entidade:Construir(nome, 25, 'Tulipa',x,y)

    this.cor = Cores.warmpurple

    setmetatable(this, self)


    return this
end

function Tulipa:VerificarPoderPlantar(index)
    local telhaAtual = gMundo:ObterTelaTelha(self.posicao.x, self.posicao.y)
    for _, value in pairs(self.PoderPlantar) do
        if value == telhaAtual then
            return
        end
    end

    RegistroDeEntidade:Remover(index)

end

local timer = 0
local interval = 5
function Tulipa:Atualizar(dt)
    timer = timer + dt
    if timer >= interval then 

        self:DiminuirAgua()
        timer = 0
    end
end

function Tulipa:Empate()
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(self.cor))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)



    
    love.graphics.print("Name: " .. self.nome, x + 8,y)

    love.graphics.print("Water: " .. self.agua, x + 8,y + 12)

end

function Tulipa:AumentarAgua(AguaDeQualidade)
    self.agua = math.min(self.agua + AguaDeQualidade, self.aguaMAX)
end

function Tulipa:DiminuirAgua()
    if self.agua <= 0 then
        self:Hurt(10)
    end

    self.agua = math.max(self.agua - self.sede, 0)
end

function Tulipa:Hurt(value)
    self.saude = math.max(self.saude - value, 0)

    if self.saude == 0 then
     --   self:Death()
    end

end

