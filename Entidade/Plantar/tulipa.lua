require 'Entidade.entidade'
local Cores = require('Resources.colors')



Tulipa = Entidade:Construir()
Tulipa.__index = Tulipa

function Tulipa:Construir(nome,x,y)

    local this = Entidade:Construir(nome, 25, 'Tulipa',x,y)

    this.cor = Cores.warmpurple

    setmetatable(this, self)


    return this
end

function Tulipa:Empate()

    love.graphics.setColor(love.math.colorFromBytes(self.cor))
    love.graphics.circle('fill', self.posicao.x, self.posicao.y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', self.posicao.x, self.posicao.y,  10)

end

function Tulipa:OO()
    print("Tulipa")
end

