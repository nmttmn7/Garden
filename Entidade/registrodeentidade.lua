require 'Recursos.constantes'
require('Fabrica.salvarcarregarfabrica')
-------------------------------------------------------------------------------------------------------------------------------------
---Funções Auxiliares

local function AjudaConstruirNome(esse)
 
    
    
    TextoDoUsuario = esse.nome
    ObterEntradadaDoUsuario = true
    coroutine.yield()
    esse.nome = TextoDoUsuario


end

function GerarRotina()
    rotinaAjudaConstruirNome = coroutine.create(AjudaConstruirNome)
end

rotinaAjudaConstruirNome = coroutine.create(AjudaConstruirNome)

-------------------------------------------------------------------------------------------------------------------------------------
local RegistroDeEntidade = {}
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Entidade = {}
RegistroDeEntidade.Entidade.__index = RegistroDeEntidade.Entidade

function RegistroDeEntidade.Entidade:Construir(essencia,nome,saude)

    local x,y = love.mouse.getPosition()

    local esse = {
        essencia = essencia, --essence
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

function RegistroDeEntidade.Entidade:PermitirExistencia(i)
    return false
end

function RegistroDeEntidade.Entidade:Ferir(value)
    self.saude = math.max(self.saude - value, 0)

    if self.saude == 0 then
        self:Morrer()
    end

end

function RegistroDeEntidade.Entidade:Morrer()
    JogoEntidades:Remover(self)
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

function RegistroDeEntidade.Planta:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela['nome'],tabela['saude'])

    esse.aguaMaxima = tabela['aguaMaxima']
    esse.agua = esse.aguaMaxima
    esse.taxaDeAguaDiminui = tabela['taxaDeAguaDiminui']
    esse.cor = tabela['cor']
    esse.telhaPlantavel = tabela['telhaPlantavel']


    setmetatable(esse,self)
    return esse
end

local timer = 0
local interval = 5
function RegistroDeEntidade.Planta:Atualizar(dt)
    timer = timer + dt
    if timer >= interval then 

        self:DiminuirAgua()
        timer = 0
    end
end

function RegistroDeEntidade.Planta:DiminuirAgua()
    if self.agua <= 0 then
        self:Ferir(10)
    end

    self.agua = math.max(self.agua - self.taxaDeAguaDiminui, 0)
end





function RegistroDeEntidade.Planta:Desenhar()
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(Cores[self.cor]))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)
    
    love.graphics.print("Name: " .. self.nome, x + 8,y)

    love.graphics.print("Water: " .. self.agua, x + 8,y + 12)

end

function RegistroDeEntidade.Planta:AjudaConstruir()
    ObterEntradadaDoUsuario = true

    if coroutine.status(rotinaAjudaConstruirNome) =="dead" then
        GerarRotina()
    end
    coroutine.resume(rotinaAjudaConstruirNome, self) 
end

function RegistroDeEntidade.Planta:PermitirExistencia(i)
    local telhaAtual = gMundo:ObterTelaTelha(self.posicao.x, self.posicao.y)
    for _, value in pairs(self.telhaPlantavel) do
        if value == telhaAtual then
            return true
        end
    end

    if type(i) == 'number' then
    JogoEntidades:Remover(i)
    else
        return false 
    end
end

--[[

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
        return registroDeEntidade:Construir(NomeDaEntidade,...)
    else
        error("RegistroDeEntidade '" .. tostring(NomeDaEntidade) .. "' não encontrado!")
    end
end
-------------------------------------------------------------------------------------------------------------------------------------
--[[local e = GerarEntidade("Entidade","Entidade")
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
]]


-------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------
JogoEntidades = {}
-------------------------------------------------------------------------------------------------------------------------------------
function JogoEntidades:Adicionar(value)
    local id = tostring(value)
    JogoEntidades[id] = value
end

function JogoEntidades:Remover(value)

    if type(value) == 'number' then
    table.remove(JogoEntidades,value)
    else
        JogoEntidades[value] = nil
    end
end

-------------------------------------------------------------------------------------------------------------------------------------
DatoDeEntidade = {}

function CarregarDatosDeEntidade()
    local dato = Carregar('datodeentidade.json')
    DatoDeEntidade = dato
end


function GerarJogoEntidade(id)

    local dato = DatoDeEntidade[id]

    local entidade = GerarEntidade(dato['essencia'],dato)
    if entidade:PermitirExistencia() then
        JogoEntidades:Adicionar(entidade)
        entidade:AjudaConstruir()
        entidade:Morrer()
    end
    
    
    entidade:DigarNome()
    
   
    
end

CarregarDatosDeEntidade()



