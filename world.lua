

MundoEstatico = {}
MundoNovo = {}
Entidade = {}

--MundoDeMaxX = 40
--MundoDeMaxY = 7

local aguaDeMax = 20
local aguaDeMin = 2


function GerarMundo(MundoDeMaxY, MundoDeMaxX)
    for y = 1, MundoDeMaxY do
        MundoEstatico[y] = {}
        for x = 1, MundoDeMaxX do
            MundoEstatico[y][x] = '-'
        end
    end
    MundoNovo = MundoEstatico
end


function LerMundo()

    print('\n' .. '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!MAP')

    for y = 1, #MundoNovo do
        if y ~= 1 then
            io.write("\n")
        end
        for x = 1, #MundoNovo[y] do
            io.write(MundoNovo[y][x])
        end
    end
    print('\n' .. '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!END')
end

function MudarEntidadePosicao(entity)

    MundoNovo[entity.posicao.Y][entity.posicao.X] = entity.representacao

end


function AdicionarEntidade(entity)
    table.insert(Entidade, entity)
end

function VerificarListaDeEntidade()
    MundoNovo = MundoEstatico

    for _, v in pairs(Entidade) do
        MudarEntidadePosicao(v)
    end
end

function GerarPosicionamentoAleatorioDeEntidade()

    for _, v in pairs(Entidade) do
        v.posicao.Y = math.random(1, #MundoEstatico)
        v.posicao.X = math.random(1, #MundoEstatico[v.posicao.Y])
    end

end


