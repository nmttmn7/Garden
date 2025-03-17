require('Fabrica.salvarcarregarfabrica')
-- Base Node Class
--[[Node Class that is a type = type then has all its children
    Cannot do NODE = SEQUENCE = {}, SELECTOR = {}, ACTION = {}
    BECAUSE THAT MEANS EACH NODE HAS A SEQUENCE, SELECTOR, ACTION]]

-------------------------------------------------------------------------------------------------------------------------------------
--Initialize NODE
local RegistroDeNEURONIOS = {}
--Make A Fuction that constructs what a node is!
RegistroDeNEURONIOS.NEURONIO = {}
RegistroDeNEURONIOS.NEURONIO.__index = RegistroDeNEURONIOS.NEURONIO
function RegistroDeNEURONIOS.NEURONIO:Construir(essencia)
    --a local node that has THE TYPE and THE children table
    local no = { essencia = essencia, filhos  = {} }
    setmetatable(no, self)
    self.__index = self
    return no

end


--Add 
function RegistroDeNEURONIOS.NEURONIO:Adicionar(quantidade)
    table.insert(self.filhos, quantidade)
end
--Delete
function RegistroDeNEURONIOS.NEURONIO:ExcluirIndice(indice)
    table.remove(self.filhos, indice)
end

-------------------------------------------------------------------------------------------------------------------------------------
--STOPS AT FIRST CHILD THAT IS FAILURE OR RUNNING
RegistroDeNEURONIOS.SEQUENCIA = RegistroDeNEURONIOS.NEURONIO:Construir()
RegistroDeNEURONIOS.SEQUENCIA.__index = RegistroDeNEURONIOS.SEQUENCIA

function RegistroDeNEURONIOS.SEQUENCIA:Construir(essencia)
    local esse = RegistroDeNEURONIOS.NEURONIO:Construir(essencia)
    setmetatable(esse,self)
    return esse

end

function RegistroDeNEURONIOS.SEQUENCIA:Correr(entidade)
    for _, q in ipairs(self.filhos) do

        local estado = q:Correr(entidade)

        if estado == ESTADOS.FALHA or estado == ESTADOS.CORRENDO then
            return ESTADOS.FALHA -- Fail if any child fails
        end
    end

    return ESTADOS.SUCESSO -- Succeed if all children succeed
end
-------------------------------------------------------------------------------------------------------------------------------------
--STOPS AT FIRST CHILD THAT IS SUCCESS OR RUNNING
RegistroDeNEURONIOS.SELETOR = RegistroDeNEURONIOS.NEURONIO:Construir()
RegistroDeNEURONIOS.SELETOR.__index = RegistroDeNEURONIOS.SELETOR

function RegistroDeNEURONIOS.SELETOR:Construir(essencia)
    local esse = RegistroDeNEURONIOS.NEURONIO:Construir(essencia)
    setmetatable(esse,self)
    return esse

end

function RegistroDeNEURONIOS.SELETOR:Correr(entidade)

    for _, q in ipairs(self.filhos) do

        local estado = q:Correr(entidade)

        if estado == ESTADOS.SUCESSO or estado == ESTADOS.CORRENDO then
            return ESTADOS.SUCESSO -- SUCCEEDS if any child fails
        end

    end
    
    return ESTADOS.FALHA -- Fails if all children fail
end
-------------------------------------------------------------------------------------------------------------------------------------
--SUCCESS RUNNING FAILURE
RegistroDeNEURONIOS.ACAO = RegistroDeNEURONIOS.NEURONIO:Construir()
RegistroDeNEURONIOS.ACAO.__index = RegistroDeNEURONIOS.ACAO

function RegistroDeNEURONIOS.ACAO:Construir(essencia)
    local esse = RegistroDeNEURONIOS.NEURONIO:Construir(essencia)

    setmetatable(esse,self)
    return esse

end

function RegistroDeNEURONIOS.ACAO:Correr(entidade)
    return self:Ato(entidade)
end

function RegistroDeNEURONIOS.ACAO:Ato(entidade)
    print("ACAO: SUCESSO")
    return ESTADOS.SUCESSO
end
-------------------------------------------------------------------------------------------------------------------------------------
--SUCCESS RUNNING FAILURE
RegistroDeNEURONIOS.VagarACAO = RegistroDeNEURONIOS.NEURONIO:Construir()
RegistroDeNEURONIOS.VagarACAO.__index = RegistroDeNEURONIOS.VagarACAO

function RegistroDeNEURONIOS.VagarACAO:Construir(essencia)
    local esse = RegistroDeNEURONIOS.NEURONIO:Construir(essencia)

    setmetatable(esse,self)
    return esse

end

function RegistroDeNEURONIOS.VagarACAO:Correr(entidade)
    if entidade == nil then
        error("Entidade e NIL")
    else
    return self:Ato(entidade)
    end
end

function RegistroDeNEURONIOS.VagarACAO:Ato(entidade)

    local memoria = entidade.cerebelo.memoria
    
    local novoPosicao = memoria['IrParaPosicao'] or nil

    
    if novoPosicao == nil then
        novoPosicao = self:GerarPosicao(entidade)
    end


    local posicao = entidade:ObterPosicao()

    if posicao.x > novoPosicao.x then
        posicao.x = posicao.x - 1
    elseif posicao.x < novoPosicao.x then
        posicao.x = posicao.x + 1
    end

    if posicao.y > novoPosicao.y then
        posicao.y = posicao.y - 1
    elseif posicao.y < novoPosicao.y then
        posicao.y = posicao.y + 1
    end

    local MundoX, MundoY = love.window.getDesktopDimensions()

    if posicao.x > MundoX then
        posicao.x = 0
    elseif posicao.x < 0 then
        posicao.x = MundoX
    end 
    if posicao.y > MundoY then
        posicao.y = 0
    elseif posicao.y < 0 then
        posicao.y = MundoY
    end 
    if posicao.x == novoPosicao.x and posicao.y == novoPosicao.y then
        entidade.cerebelo.memoria['IrParaPosicao'] = nil
        return ESTADOS.SUCESSO;
    end


    return ESTADOS.CORRENDO
end

function RegistroDeNEURONIOS.VagarACAO:GerarPosicao(entidade)

    local posicao = entidade.posicao

    local MundoX, MundoY = love.window.getDesktopDimensions()

    local xAleatoria = math.random(math.max(posicao.x - 10, 0), math.min(posicao.x + 100,MundoX))
    local yAleatoria = math.random(math.max(posicao.y - 10, 0), math.min(posicao.y + 100,MundoY))
    --xAleatoria = 1 + posicao.x
    --yAleatoria = 1 + posicao.y
    xAleatoria = math.floor(xAleatoria)
    yAleatoria = math.floor(yAleatoria)

    entidade.cerebelo.memoria['IrParaPosicao'] = {x = xAleatoria, y = yAleatoria}

    return entidade.cerebelo.memoria['IrParaPosicao']
end
-------------------------------------------------------------------------------------------------------------------------------------
function GerarNeuronios(NomeDeNeuronios)
    local registroDeNeuronios = RegistroDeNEURONIOS[NomeDeNeuronios]
    if registroDeNeuronios and registroDeNeuronios.Construir then
        return registroDeNeuronios:Construir(NomeDeNeuronios)
    else
        error("RegistroDeNeuronios '" .. tostring(NomeDeNeuronios) .. "' não encontrado!")
    end
end
-------------------------------------------------------------------------------------------------------------------------------------

ESTADOS = {
    SUCESSO = 'SUCESSO',
    CORRENDO = 'CORRENDO',
    FALHA = 'FALHA'
}

local root = GerarNeuronios('SEQUENCIA')
local actionT = GerarNeuronios('ACAO')
root:Adicionar(actionT)
root:Correr()
Salvar(root,'OO.json')