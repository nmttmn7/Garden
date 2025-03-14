
-------------------------------------------------------------------------------------------------------------------------------------
local RegistroDeAcoes = {}
-------------------------------------------------------------------------------------------------------------------------------------
--Wander
function RegistroDeAcoes.Vagar(entidade)

    local memoria = entidade.cerebelo.memoria
    
    local novoPosicao = memoria['IrParaPosicao'] or nil

    
    if novoPosicao == nil then
        novoPosicao = GerarPosicao(entidade)
    end
    print('X: ' .. novoPosicao.x)

    local posicao = entidade:ObtePosicao()

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

    
    if posicao.x == novoPosicao.x and posicao.y == novoPosicao.y then
        entidade.cerebelo.memoria['IrParaPosicao'] = nil
        print("SUCCESS")
       -- return STATES.SUCCESS;
    end
    print("RUNNING")
    return STATES.RUNNING
end

function RegistroDeAcoes.GerarPosicao(entidade)
    print('GerarPosicao')
    local posicao = entidade.posicao

    local xAleatoria = math.random(posicao.x - 10, posicao.x + 100)
    local yAleatoria = math.random(posicao.y - 10, posicao.y + 100)
    --xAleatoria = 1 + posicao.x
    --yAleatoria = 1 + posicao.y
    xAleatoria = math.floor(xAleatoria)
    yAleatoria = math.floor(yAleatoria)

    entidade.cerebelo.memoria['IrParaPosicao'] = {x = xAleatoria, y = yAleatoria}

    return entidade.cerebelo.memoria['IrParaPosicao']
end

--For Food
function RegistroDeAcoes.ParaComida(entity)

    local x = 50
    local y = 50
 
    local posicao = entity:ObtePosicao()

    if posicao.x > x then
        posicao.x = posicao.x - 1
    elseif posicao.x < x then
        posicao.x = posicao.x + 1
    end

    if posicao.y > y then
        posicao.y = posicao.y - 1
    elseif posicao.y < y then
        posicao.y = posicao.y + 1
    end

    print(posicao.x)

    if posicao.x == x then
        return STATES.SUCCESS;
    end

    return STATES.RUNNING
end


function GerarAcoes(NomeDaAcao, ...)
    local registroDeEntidade = RegistroDeEntidade[NomeDaAcao]
    if registroDeEntidade and registroDeEntidade.Construir then
        return registroDeEntidade:Construir(NomeDaAcao,...)
    else
        error("RegistroDeEntidade '" .. tostring(NomeDaAcao) .. "' não encontrado!")
    end
end