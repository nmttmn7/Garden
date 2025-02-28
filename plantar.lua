require('entidade')
Plantar = Entidade



function Plantar:Construir(nome, saude, essencia, fome, sede)
        local self = setmetatable({}, Plantar)

        self.nome = nome --name
        self.saude = saude --health
        self.essencia = essencia --essence

        self.fome = fome --hunger
        self.sede = sede -- thirst

        self.posicao = { X = 0, Y = 0 } --position

        return self

end

function Asteriod()

end

local p = Plantar:Construir('Nome', 12, "w2")

