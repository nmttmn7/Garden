require 'Recursos.constantes'
require('Fabrica.salvarcarregarfabrica')
local RegistroDeEntidade = {}
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Entidade = {}
RegistroDeEntidade.Entidade.__index = RegistroDeEntidade.Entidade

function RegistroDeEntidade.Entidade:Construir(nome,saude,x,y)
    local esse = {
        nome = nome, --name
        saude = saude, --health

        posicao = {
            x = x,
            y = y,
        }
    }
    setmetatable(esse,self)
    return esse
end

function RegistroDeEntidade.Entidade:ObterPosicao()
    return self.posicao
end

function RegistroDeEntidade.Entidade:DigarNome() --say name
    print('Meu nome e ' .. self.nome)
end
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Entidade.Dog = setmetatable({}, { __index = RegistroDeEntidade.Entidade })
RegistroDeEntidade.Entidade.Dog.__index = RegistroDeEntidade.Entidade.Dog

function RegistroDeEntidade.Entidade.Dog:new(name, breed)
    local self = setmetatable(RegistroDeEntidade.Entidade:new(name), self)
    self.breed = breed
    return self
end

function RegistroDeEntidade.Entidade.Dog:OO()
    print('WOWOWOWO')
end
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Planta = RegistroDeEntidade.Entidade:Construir()
RegistroDeEntidade.Planta.__index = RegistroDeEntidade.Planta

function RegistroDeEntidade.Planta:Construir(nome,saude,x,y,aguaMaxima,taxaDeAguaDiminui,cor,telhaPlantavel)
    local esse = RegistroDeEntidade.Entidade:Construir(nome,saude,x,y)

    esse.aguaMaxima = aguaMaxima
    esse.taxaDeAguaDiminui = taxaDeAguaDiminui
    esse.cor =cor
    esse.telhaPlantavel = telhaPlantavel


    setmetatable(esse,self)
    return esse
end

--[[
function RegistroDeEntidade.Planta:Empate()
    local posicao = self:ObterPosicao()

    love.graphics.setColor(love.math.colorFromBytes(self.cor))
    love.graphics.circle('fill', posicao.x, posicao.y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', posicao.x, posicao.y,  10)



    
    love.graphics.print("Name: " .. self.nome, x + 8,y)

    love.graphics.print("Water: " .. self.agua, x + 8,y + 12)

end
]]
function RegistroDeEntidade.Planta:DigarNome()
    print('Meu nome e ' .. self.nome)
end
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Criatura = RegistroDeEntidade.Entidade:Construir()
RegistroDeEntidade.Criatura.__index = RegistroDeEntidade.Criatura

function RegistroDeEntidade.Criatura:Construir(nome)
    local esse = RegistroDeEntidade.Entidade:Construir(nome)
    setmetatable(esse,self)
    return esse
end

function RegistroDeEntidade.Criatura:DigarNome()
    print('Meu nome e ' .. self.nome)
end
-------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------


function GerarEntidade(NomeDaEntidade, ...)
    local registroDeEntidade = RegistroDeEntidade[NomeDaEntidade]
    if registroDeEntidade and registroDeEntidade.Construir then
        return registroDeEntidade:Construir(...)
    else
        error("RegistroDeEntidade '" .. tostring(NomeDaEntidade) .. "' não encontrado!")
    end
end
-------------------------------------------------------------------------------------------------------------------------------------
local e = GerarEntidade("Entidade","Entidade")
e:DigarNome()

local p = GerarEntidade("Planta","Nome",25,3,4,90,2,Cores['roxoQuente'],{Telha['sujeira'],Telha['grama']})
--Plantas precisam 
    --Nome
    --Saude
    --x
    --y
    --água máxima
    --Taxa de agua diminui
    --Cor
    --telha plantável


p:DigarNome()

-------------------------------------------------------------------------------------------------------------------------------------
JogoEntidades = {}
-------------------------------------------------------------------------------------------------------------------------------------
function JogoEntidades:Adicionar(value)
    table.insert(JogoEntidades,value)
end

function JogoEntidades:Remover(index)
    table.remove(JogoEntidades,index)
end

function GerarJogoEntidade()
    
    local entidade = GerarEntidade("Planta","Nome",25,3,4,90,2,Cores['roxoQuente'],{Telha['sujeira'],Telha['grama']})
    JogoEntidades:Adicionar(entidade)
end
-------------------------------------------------------------------------------------------------------------------------------------
DatoDeEntidade = {}

function CarregarDatosDeEntidade()
    local dato = Carregar('datodeentidade.json')
    DatoDeEntidade = dato
end

CarregarDatosDeEntidade()
local t = DatoDeEntidade['tulipa']
print(t['essencia'])