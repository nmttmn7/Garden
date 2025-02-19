require('entity')
require('node')



function TestEntity()
    local entity = Entity.construir("nome", "essencia", 25, 90, 1)
    if entity.nome ~= "nome" or entity.essencia ~= "essencia" or entity.fome ~= 25 or entity.sede ~= 90 or entity.velocidade ~= 1 then
        error("!!!!!!!!!ATRIBUTOS DA ENTIDADE NAO CORRESPONDEM!!!!!!!!!")
        --error("!!!!!!!!!ENTITY's ATTRIBUTES ARE NOT MATCHING!!!!!!!!!")
    end


    entity.arvoreDeComportamento = TestCerebral()
    local cerebro = entity.arvoreDeComportamento

    print("TEST----")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)
    print("------------------")
    cerebro:correr(entity)

    
    print("TEST----")
    --print(cerebro:ler())
    --entity.construirCerebro(root)


    print("entityTEST.lua Completo!")
end


function TestCerebral()

    local root = SEQUENCE:construir()
    local actionT = ACTION:construir(ActionTRUE)
    local actionF = ACTION:construir(ActionFALSE)
    local actionR = ACTION:construir(ActionRUNNING)

    root:adicionar(actionT)
    root:adicionar(ACTION:construir(ParaComida))
    root:adicionar(actionT)
    
    local selector =  SELECTOR:construir()
    root:adicionar(selector)

    selector:adicionar(actionT)
    selector:adicionar(actionT)
    selector:adicionar(ACTION:construir(ParaComida))
    selector:adicionar(actionR)
    selector:adicionar(actionF)

    --[[
    root:ler(root)
    root:recLer(root)

    root:correr()

    root:excluirIndice(1)
    --root:ler()
    ]]
    print("nodeTEST.lua Completo!")
    return root
end



TestEntity()