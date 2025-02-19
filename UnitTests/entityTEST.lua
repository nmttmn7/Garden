require('entity')
require('node')

function EntityTest()
    local entity = Entity.construir("nome", "essencia", 25, 90)
    if entity.nome ~= "nome" or entity.essencia ~= "essencia" or entity.fome ~= 25 or entity.sede ~= 90 then
        error("!!!!!!!!!ATRIBUTOS DA ENTIDADE NAO CORRESPONDEM!!!!!!!!!")
        --error("!!!!!!!!!ENTITY's ATTRIBUTES ARE NOT MATCHING!!!!!!!!!")
    end

    local root = SEQUENCE:construir()
    local actionT = ACTION:construir(ActionTRUE)
    local actionF = ACTION:construir(ActionFALSE)
    
    root:adicionar(actionT)
    root:adicionar(actionT)
    local selector =  SEQUENCE:construir()
    root:adicionar(selector)

    selector:adicionar(actionT)
    selector:adicionar(actionF)

    root:ler(root)
    root:recLer(root)

    root:excluirIndice(1)
    --root:ler()


    entity.construirCerebro(root)

    print("nodeTEST.lua Completo!")
    print("entityTEST.lua Completo!")
end

EntityTest()