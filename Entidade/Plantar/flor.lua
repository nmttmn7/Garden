require 'Entidade.entidade'




Flor = Entidade:Construir()
Flor.__index = Flor

function Flor:Construir(nome, saude, essencia, x, y, cor)

    local this = Entidade:Construir(nome, saude, essencia,x,y)

    this.cor = cor

    setmetatable(this, self)


    return this
end

function Flor:Empate()

    love.graphics.setColor(love.math.colorFromBytes(self.cor))
    love.graphics.circle('fill', self.posicao.x, self.posicao.y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', self.posicao.x, self.posicao.y,  10)

end


