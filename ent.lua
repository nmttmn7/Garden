require('world')
--ENTITY
Entity = {

    nome,                  --name
    saude,                 --health
    essencia,              --essence
    representacao,         --representacao
    fome,                  --hunger
    sede,                  --thirst
    velocidade,            --speed
    arvoreDeComportamento, --Behavior Tree

    posicao = { X = 0, Y = 0 },


}

function Entity.construir(nome, saude, essencia, representacao, fome, sede, velocidade)
    local self = setmetatable({}, Entity)

    self.nome = nome
    self.saude = saude
    self.essencia = essencia
    self.representacao = representacao
    self.fome = fome
    self.sede = sede
    self.velocidade = velocidade


    return self
end

function Entity.construirCerebro(cerebro)
    local self = setmetatable({}, Entity)

    self.arvoreDeComportamento = cerebro

    return self
end

function Entity:ler()
    for k, v in pairs(self) do
        print(k .. ": " .. v)
    end
end

function Entity.__index(tab, key)
    return Entity[key]
end
