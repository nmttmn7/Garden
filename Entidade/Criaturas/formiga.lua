require 'entidade'
require 'Nodes/node'
--local love = require 'love'

Formiga = Entidade:Construir()
Formiga.__index = Formiga

function Formiga:Construir(nome)

    local this = Entidade:Construir(nome, 25, 'Formiga')

    local cerebelo = {memoria = {}, ArvoreDeComportamento = GerarArvoreDeComportamento()}
    this.cerebelo = cerebelo
    this.velocidade = 10

    setmetatable(this, self)


    return this
end

function Formiga:AdicionarMemoria(value)
    table.insert(self.cerebelo.memoria, value)
end

function Formiga:RemoverMemoria(value)
    local memoria = self.cerebelo.memoria

    local i = 1;
    for k, v in pairs(memoria) do

        if k == value then 
            table.remove(memoria,i)
        end
    i = i+1
    end
end
function Formiga:Empate()
    local opacity = 1

    love.graphics.setColor(1,1,1,opacity)

    love.graphics.circle('fill', self.posicao.x, self.posicao.y, 20)

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

--[[
local l = Formiga:Construir("NAME")
l:Update("NAME")
l:Update("NAME")
l:Update("NAME")
l:Update("NAME")
]]