--[[
    Classe Base Da Entidade
    Entity Base Class
]]

Entidade = {}
Entidade.__index = Entidade

function Entidade:Construir()
    local this = {
        nome = nome, --name
        saude = saude, --health
        essencia = essencia, --essence

        posicao = {
            x = 0,
            y = 0,
        }
    }

    setmetatable(this, self)

    return this
end

function Entidade:ObtePosicao()
    return self.posicao
end

