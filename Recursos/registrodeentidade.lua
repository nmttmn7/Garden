require('Recursos.registrodeneuronio')
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
function ProcurarPredecessor(chave, predecessor)
    for i=1,#predecessor do
        local q = predecessor[i][chave]
        if q then
            return q
        end
    end
    end

    function RegistrarPredecessor(predecessor)
        return {
            __index = function (self,chave)
            return ProcurarPredecessor(chave, predecessor)
        end
    
        }
    end
-------------------------------------------------------------------------------------------------------------------------------------
local RegistroDeEntidade = {}
-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Entidade = {}
RegistroDeEntidade.Entidade.__index = RegistroDeEntidade.Entidade

function RegistroDeEntidade.Entidade:Construir(essencia,tabela)


    local x,y
    local posicao = tabela['posicao']
    if posicao == nil then
    x,y = love.mouse.getPosition()
    else
    x = posicao['x']
    y = posicao['y']
    end

    local esse = {
        essencia = essencia, --essence
        nome = tabela['nome'], --name
        saude = tabela['saude'], --health
        cor = tabela['cor'],
        posicao = {
            x = x,
            y = y,
        },
        
        nomeDaEssencia = tabela['nomeDaEssencia']
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

function RegistroDeEntidade.Entidade:PermitirExistencia(i)
    return true
end

function RegistroDeEntidade.Entidade:Ferir(value)
    

    if self.saude == 0 then
        self:Morrer()
    end

    self.saude = math.max(self.saude - value, 0)

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

RegistroDeEntidade.Planta = {}
RegistroDeEntidade.Planta.__index = RegistroDeEntidade.Planta
RegistroDeEntidade.Planta.predecessores =  RegistrarPredecessor({RegistroDeEntidade.Entidade})
setmetatable(RegistroDeEntidade.Planta,RegistroDeEntidade.Planta.predecessores)


function RegistroDeEntidade.Planta:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela)
    esse = setmetatable(esse, RegistroDeEntidade.Planta)

    esse.aguaMaxima = tabela['aguaMaxima']
    esse.taxaDeAguaDiminui = tabela['taxaDeAguaDiminui']

    local agua = tabela['agua']
    if agua == nil then
        esse.agua = esse.aguaMaxima
    else
        esse.agua = agua
    end


    esse.telhaPlantavel = tabela['telhaPlantavel']

    esse.crescimentoMaxima = tabela['crescimentoMaxima']
    esse.taxaDeCrescimento = tabela['taxaDeCrescimento']

    local crescimento = tabela['crescimento']
    if crescimento == nil then
        esse.crescimento = 0
    else
        esse.crescimento = crescimento
    end

    

    return esse
end

function RegistroDeEntidade.Planta:VerificarAdulto()
    if self.crescimento == self.crescimentoMaxima then
        return true
    end
        return false
end

function RegistroDeEntidade.Planta:Crescer() --To grow
    self.crescimento = math.min(self.crescimento + self.taxaDeCrescimento, self.crescimentoMaxima)
end

local timer = 0
local interval = 5
function RegistroDeEntidade.Planta:Atualizar(dt)
    timer = timer + dt
    if timer >= interval then 

        self:DiminuirAgua()
        self:Crescer()
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
    love.graphics.print("Growth: " .. self.crescimento, x + 8,y + 12 + 12 + 12)

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
-------------------------------------------------------------------------
RegistroDeEntidade.Arvore = {}
RegistroDeEntidade.Arvore.__index = RegistroDeEntidade.Arvore
RegistroDeEntidade.Arvore.predecessores =  RegistrarPredecessor({RegistroDeEntidade.Planta,RegistroDeEntidade.Entidade})
setmetatable(RegistroDeEntidade.Arvore,RegistroDeEntidade.Arvore.predecessores)

function RegistroDeEntidade.Arvore:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Planta:Construir(essencia,tabela)
    esse = setmetatable(esse, RegistroDeEntidade.Arvore)

    esse.objeto = tabela['objeto']

    return esse
end

function RegistroDeEntidade.Arvore:GerarObjeto()
    if self:VerificarAdulto() == false then
        return
    end

    GerarJogoEntidade(self.objeto)
end

local timer = 0
local interval = 5
function RegistroDeEntidade.Arvore:Atualizar(dt)
    timer = timer + dt
    if timer >= interval then 

        self:DiminuirAgua()
        self:Crescer()
        self:GerarObjeto()
        timer = 0
    end
end

-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Criatura = {}
RegistroDeEntidade.Criatura.__index = RegistroDeEntidade.Criatura
RegistroDeEntidade.Criatura.predecessores =  RegistrarPredecessor({RegistroDeEntidade.Entidade})
setmetatable(RegistroDeEntidade.Criatura,RegistroDeEntidade.Criatura.predecessores)

function RegistroDeEntidade.Criatura:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela)
    esse = setmetatable(esse, RegistroDeEntidade.Criatura)

    esse.aguaMaxima = tabela['aguaMaxima']

    local agua = tabela['agua']
    if agua == nil then
        esse.agua = esse.aguaMaxima
    else
        esse.agua = agua
    end

    esse.taxaDeAguaDiminui = tabela['taxaDeAguaDiminui']

    esse.telhaAtravessavel = tabela['telhaAtravessavel']

    local root = GerarNeuronios('SELETOR')
    local casa = GerarNeuronios('SEQUENCIA')
    casa:Adicionar(GerarNeuronios('ProcurerCasaACAO'))
    casa:Adicionar(GerarNeuronios('IrParaCasaACAO'))
    casa:Adicionar(GerarNeuronios('EntreEmCasaACAO'))
    root:Adicionar(casa)
    
    esse.cerebelo = { memoria = {}, arvoreDeComportamento = root}

    esse.tempo = tabela['tempo']
    
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

-------------------------------------------------------------------------------------------------------------------------------------
RegistroDeEntidade.Objeto = {}
RegistroDeEntidade.Objeto.__index = RegistroDeEntidade.Objeto
RegistroDeEntidade.Objeto.predecessores =  RegistrarPredecessor({RegistroDeEntidade.Entidade})
setmetatable(RegistroDeEntidade.Objeto,RegistroDeEntidade.Objeto.predecessores)

function RegistroDeEntidade.Objeto:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela)
    esse = setmetatable(esse, RegistroDeEntidade.Objeto)
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
RegistroDeEntidade.Casa = {}
RegistroDeEntidade.Casa.__index = RegistroDeEntidade.Casa
RegistroDeEntidade.Casa.predecessores =  RegistrarPredecessor({RegistroDeEntidade.Entidade})
setmetatable(RegistroDeEntidade.Casa,RegistroDeEntidade.Casa.predecessores)

function RegistroDeEntidade.Casa:Construir(essencia,tabela)
    local esse = RegistroDeEntidade.Entidade:Construir(essencia,tabela)
    esse = setmetatable(esse, RegistroDeEntidade.Casa)

    local listaDeCriatura = tabela['listaDeCriatura']
    if listaDeCriatura == nil then
        esse.listaDeCriatura = {}
    else
        esse.listaDeCriatura = listaDeCriatura
    end

    esse.criatura = tabela['criatura']
    
    return esse
end

function RegistroDeEntidade.Casa:Atualizar(dt)
    
end

function RegistroDeEntidade.Casa:Desenhar()

    
    local x = self.posicao.x
    local y = self.posicao.y
    love.graphics.setColor(love.math.colorFromBytes(Cores[self.cor]))
    love.graphics.circle('fill', x, y, 10)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', x, y,  10)
    
    love.graphics.print("Name: " .. self.nome, x + 8,y)
    love.graphics.print("Health: " .. self.saude, x + 8,y + 12)
end
function RegistroDeEntidade.Casa:AdicionarEntidades(value)
    local id = tostring(value)
    self.listaDeCriatura[id] = value
end
function RegistroDeEntidade.Casa:PermitirExistencia(boolean)
    return true
end

function RegistroDeEntidade.Casa:SairDeCasa()
    if self.listaDeCriatura == nil then return end
    for _, value in ipairs(self.listaDeCriatura) do
        local dato = Decodificar(value)
        AdicionarJogoEntidades(GerarEntidade(dato['essencia'],dato))
    end

    self.listaDeCriatura = {}
end
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
    dato['nomeDaEssencia'] = id
    local entidade = GerarEntidade(dato['essencia'],dato)
    
    if entidade:PermitirExistencia(false) then
        
        AdicionarJogoEntidades(entidade)
        entidade:AjudaConstruir()
        
    end
    
    
    return entidade

   
    
end

function CarregarJogoEntidades()
    local dato = Carregar('jogoentidades.json')
    

    for _, value in pairs(dato) do

        local entidade = GerarEntidade(value['essencia'],value)
        AdicionarJogoEntidades(entidade)
        
    end
end
CarregarDatosDeEntidade()


