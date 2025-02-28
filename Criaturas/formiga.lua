require 'entidade'
require 'Nodes/node'
--local love = require 'love'

Formiga = Entidade:Construir()
Formiga.__index = Formiga

function Formiga:Construir(nome)

    local this = Entidade:Construir(nome, 25, 'Formiga')

    local cerebelo = {memoria = {}, ArvoreDeComportamento = GerarArvoreDeComportamento()}
    this.cerebelo = cerebelo
    --cerebelo:Correr(se)
    setmetatable(this, self)


    return this
end

function Formiga:AdicionarMemoria(value)
    table.insert(self.cerebelo.memoria, value)
end
function Formiga:Draw()
    local opacity = 1

    love.graphics.setColor(1,1,1,opacity)

    love.graphics.circle('fill', self.posicao.x, self.posicao.y, 50)

end

function Formiga:Update(dt)
   -- self.timer = self.timer + dt
   local l = self.cerebelo;
   
   self.cerebelo.ArvoreDeComportamento:Correr(self)

end

function Formiga:Decidir()
    local cerebelo = self.cerebelo;
    cerebelo:Correr(self)
end

function GerarArvoreDeComportamento()
    local root = SEQUENCE:Construir()

    root:Adicionar(ACTION:Construir(Vagar))

    return root
end

local l = Formiga:Construir("NAME")
l:Update("NAME")
