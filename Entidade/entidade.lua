--[[
    Classe Base Da Entidade
    Entity Base Class
]]

Entidade = {}
Entidade.__index = Entidade

function Entidade:Construir(nome,saude,essencia,x,y)
    local this = {
        nome = nome, --name
        saude = saude, --health
        essencia = essencia, --essence

        posicao = {
            x = x,
            y = y,
        }
    }

    setmetatable(this, self)

    return this
end

function Entidade:ObtePosicao()
    return self.posicao
end

