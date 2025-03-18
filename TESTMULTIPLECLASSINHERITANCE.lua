--[[
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

function RegistroDeEntidade.Entidade:Construir(essencia,nome,saude,cor,posicao)

    local x,y

    if posicao == nil then
    x,y = love.mouse.getPosition()
    else
    x = posicao['x']
    y = posicao['y']
    end

    local esse = {
        essencia = essencia, --essence
        nome = nome, --name
        saude = saude, --health
        cor = cor,
        posicao = {
            x = x,
            y = y,
        }
    }
    setmetatable(esse,self)
    return esse
end

function RegistroDeEntidade.Entidade:Desenhar()
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(Cores[self.cor]))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)
    
    love.graphics.print("Name: " .. self.nome, x + 8,y)
    love.graphics.print("Health: " .. self.saude, x + 8,y + 12)


end

function RegistroDeEntidade.Entidade:ObterPosicao()
    return self.posicao
end

function RegistroDeEntidade.Entidade:DigarNome() --say name
    print('Meu nome e ' .. self.nome)
end

function RegistroDeEntidade.Entidade:PermitirExistencia(i)
    return true
end

function RegistroDeEntidade.Entidade:Ferir(value)
    self.saude = math.max(self.saude - value, 0)

    if self.saude == 0 then
        self:Morrer()
    end

end

function RegistroDeEntidade.Entidade:Morrer()
    RemoverJogoEntidades(self)
end

function RegistroDeEntidade.Entidade:AjudaConstruir()
    ObterEntradadaDoUsuario = true

    if coroutine.status(rotinaAjudaConstruirNome) =="dead" then
        GerarRotina()
    end
    coroutine.resume(rotinaAjudaConstruirNome, self) 
end

-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Objeto = RegistroDeEntidade.Entidade:Construir()
RegistroDeEntidade.Objeto.__index = RegistroDeEntidade.Objeto

function RegistroDeEntidade.Objeto:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela['nome'],tabela['saude'],tabela['cor'],tabela['posicao'])
    esse.wow = 3
    setmetatable(esse,self)
    return esse
end
function RegistroDeEntidade.Objeto:Atualizar(dt)
    
end
function RegistroDeEntidade.Objeto:Desenhar()

    
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(Cores[self.cor]))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)
    
    love.graphics.print("Name: " .. self.nome, x + 8,y)
    love.graphics.print("Health: " .. self.saude, x + 8,y + 12)
end

function RegistroDeEntidade.Objeto:PermitirExistencia(boolean)
    return true
end
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Planta = RegistroDeEntidade.Entidade:Construir()
RegistroDeEntidade.Planta.__index = RegistroDeEntidade.Planta
--Flores,árvore,PlantaMal

--Plantas precisam 
    --Nome
    --Saude

    --água máxima
    --Taxa de agua diminui
    --Cor
    --telha plantável

    --Adulto
    --taxa de crescimento
    --Todas as plantas podem ser comidas

    --árvore precisam
    --Gerar comida

    --PlantaMal precisam
    --Gerar outras plantas
function RegistroDeEntidade.Planta:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela['nome'],tabela['saude'],tabela['cor'],tabela['posicao'])

    esse.aguaMaxima = tabela['aguaMaxima']

    local agua = tabela['agua']
    if agua == nil then
        esse.agua = esse.aguaMaxima
    else
        esse.agua = agua
    end

    esse.taxaDeAguaDiminui = tabela['taxaDeAguaDiminui']
    esse.telhaPlantavel = tabela['telhaPlantavel']

    esse.taxaDeCrescimento = tabela['taxaDeCrescimento']

    local crescimento = tabela['crescimento']
    if crescimento == nil then
        esse.crescimento = 0
    else
        esse.crescimento = crescimento
    end

    esse.crescimentoMaxima = tabela['crescimentoMaxima']

    setmetatable(esse,self)
    return esse
end

function RegistroDeEntidade.Planta:VerificarAdulto()
    if self.crescimento == self.crescimentoMaxima then
        return true
    end
        return false
end

function RegistroDeEntidade.Planta:Crescer(dt)
    self.crescimento = math.min(self.crescimento + self.taxaDeCrescimento, self.crescimentoMaxima)
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

function RegistroDeEntidade.Planta:AumentarAgua(quantidade)
    self.agua = math.min(self.agua + quantidade, self.aguaMaxima)
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
    love.graphics.print("Health: " .. self.saude, x + 8,y + 12)
    love.graphics.print("Water: " .. self.agua, x + 8,y + 12 + 12)

end


function RegistroDeEntidade.Planta:PermitirExistencia(boolean)
    local telhaAtual = gMundo:ObterTelaTelha(self.posicao.x, self.posicao.y)
    for _, value in pairs(self.telhaPlantavel) do
        if value == telhaAtual then
            return true
        end
    end

    if boolean then
        RemoverJogoEntidades(self)
    else
        return false 
    end
end


-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Criatura = RegistroDeEntidade.Entidade:Construir()
RegistroDeEntidade.Criatura.__index = RegistroDeEntidade.Criatura

function RegistroDeEntidade.Criatura:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela['nome'],tabela['saude'],tabela['cor'],tabela['posicao'])


    esse.aguaMaxima = tabela['aguaMaxima']

    local agua = tabela['agua']
    if agua == nil then
        esse.agua = esse.aguaMaxima
    else
        esse.agua = agua
    end

    esse.taxaDeAguaDiminui = tabela['taxaDeAguaDiminui']

    esse.telhaAtravessavel = tabela['telhaAtravessavel']

    local root = GerarNeuronios('SEQUENCIA')
    root:Adicionar(GerarNeuronios('VagarACAO'))
    
    esse.cerebelo = { memoria = {}, arvoreDeComportamento = root}
    
    setmetatable(esse,self)
    return esse
end

local timer = 0
local interval = 5
function RegistroDeEntidade.Criatura:Atualizar(dt)
    self.cerebelo.arvoreDeComportamento:Correr(self)
    timer = timer + dt
    if timer >= interval then 

        --self:DiminuirAgua()
        timer = 0
    end
end

function RegistroDeEntidade.Criatura:Desenhar()
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(Cores[self.cor]))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)
    
    love.graphics.print("Name: " .. self.nome, x + 8,y)
    love.graphics.print("Health: " .. self.saude, x + 8,y + 12)
    love.graphics.print("Water: " .. self.agua, x + 8,y + 12 + 12)

end


function RegistroDeEntidade.Criatura:PermitirExistencia(boolean)
    local telhaAtual = gMundo:ObterTelaTelha(self.posicao.x, self.posicao.y)
    for _, value in pairs(self.telhaAtravessavel) do
        if value == telhaAtual then
            return true
        end
    end

    if boolean then
        RemoverJogoEntidades(self)
    else
        return false 
    end
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
--Flores,árvore,PlantaMal

--Plantas precisam 
    --Nome
    --Saude

    --água máxima
    --Taxa de agua diminui
    --Cor
    --telha plantável

    --Adulto
    --taxa de crescimento
    --Todas as plantas podem ser comidas

    --árvore precisam
    --Gerar comida

    --PlantaMal precisam
    --Gerar outras plantas


p:DigarNome()






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

-------------------------------------------------------------------------------------------------------------------------------------
JogoEntidades = {}
-------------------------------------------------------------------------------------------------------------------------------------
function AdicionarJogoEntidades(value)
    local id = tostring(value)
    JogoEntidades[id] = value
end

function RemoverJogoEntidades(value)
    local id = tostring(value)
    JogoEntidades[id] = nil
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
    
    if entidade:PermitirExistencia(false) then
        
        AdicionarJogoEntidades(entidade)
        entidade:AjudaConstruir()
        
    end
    
    
    
    entidade:DigarNome()
    
   
    
end

function CarregarJogoEntidades()
    local dato = Carregar('jogoentidades.json')
    

    for _, value in pairs(dato) do

        local entidade = GerarEntidade(value['essencia'],value)
        AdicionarJogoEntidades(entidade)
        
    end
end
CarregarDatosDeEntidade()
]]