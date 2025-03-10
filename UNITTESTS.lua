require('binarytree')
require('world')
require('entity')
require('node')

local visible = true

function UnitTest()
    TestMundo()
end

function TestMundo()

    GerarMundo(5,5)
    if #MundoEstatico[1] ~= 5 or #MundoEstatico ~= 5 then
        error('!!!!!!!!!OS LIMITES MUNDIAIS NÃO ESTÃO COMBINANDO!!!!!!!!!')
        --error('!!!!!!!!!THE WORLD BOUNDRIES ARE NOT MATCHING!!!!!!!!!')
    end


    local entity = TestEntity()


    AdicionarEntidade(entity)
    if #Entidade ~= 1  or Entidade[1] ~= entity then
        error('!!!!!!!!!OS LIMITES MUNDIAIS NÃO ESTÃO COMBINANDO!!!!!!!!!')
        --error('!!!!!!!!!THE WORLD BOUNDRIES ARE NOT MATCHING!!!!!!!!!')
    end



end

function TestEntity()
    local entity = Entity.construir("nome", 45,"essencia", ":", 25, 90, 1)
    if entity.nome ~= "nome" or entity.saude ~= 45 or entity.essencia ~= "essencia" or entity.representacao ~= ":" or entity.fome ~= 25 or entity.sede ~= 90 or entity.velocidade ~= 1 then
        error('!!!!!!!!!ATRIBUTOS DA ENTIDADE NAO CORRESPONDEM!!!!!!!!!')
        --error('!!!!!!!!!ENTITY's ATTRIBUTES ARE NOT MATCHING!!!!!!!!!')
    end

    entity.posicao.X = 4
    entity.posicao.Y = 4

    if visible == true then
        LerMundo()
    end

    entity.arvoreDeComportamento = TestBT()
    
    return entity

end


function TestBT()
    local root = SEQUENCE:construir()

    if root ~= SEQUENCE.type then
        error('!!!!!!!!!RAIZ NAO CORESPONDE!!!!!!!!!')
        --error('!!!!!!!!!ROOT NOT MATCHING!!!!!!!!!')
    end

    local actionT = ACTION:construir(ActionTRUE)

    if actionT ~= ACTION then
        error('!!!!!!!!!ACAO NAO CORESPONDE!!!!!!!!!')
        --error('!!!!!!!!!ACTION NOT MATCHING!!!!!!!!!')
    end

    local actionF = ACTION:construir(ActionFALSE)

    if actionF ~= ACTION then
        error('!!!!!!!!!ACAO NAO CORESPONDE!!!!!!!!!')
        --error('!!!!!!!!!ACTION NOT MATCHING!!!!!!!!!')
    end

    local actionR = ACTION:construir(ActionRUNNING)

    if actionR ~= ACTION then
        error('!!!!!!!!!ACAO NAO CORESPONDE!!!!!!!!!')
        --error('!!!!!!!!!ACTION NOT MATCHING!!!!!!!!!')
    end
    
    root:adicionar(actionT)
    root:adicionar(ACTION:construir(ParaComida))
    root:adicionar(actionT)

    local selector = SELECTOR:construir()
    root:adicionar(selector)

    selector:adicionar(actionT)
    selector:adicionar(actionT)
    selector:adicionar(ACTION:construir(ParaComida))
    selector:adicionar(actionR)
    selector:adicionar(actionF)


    return root
end


function NewTest()

    local root = NodeBN:construir(1)
    print("------------------------")
    root:Adicionar(NodeBN:construir(2))
    print("------------------------")
   -- root:Adicionar(NodeBN:construir(3))
    print("------------------------")
   
    root:Ler()
end

--UnitTest()
NewTest()
