

--Wander
function Vagar(entity)

    local memoria = entity.cerebelo.memoria
    
    local novoPosicao = memoria['IrParaPosicao'] or nil

    if novoPosicao == nil then
        
    end
    entity:AdicionarMemoria({['IrParaPosicao'] = 3})
    local posicao = entity:ObtePosicao()
    

    if posicao.x == x then
        return STATES.SUCCESS;
    end

    return STATES.RUNNING
end

function OO(entity)
local posicao = entity.posicao

return 
end

--For Food
function ParaComida(entity)

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
