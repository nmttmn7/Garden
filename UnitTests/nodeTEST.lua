require('node')

function NodeTest()
    local root = SEQUENCE:construir()
    local action = ACTION:construir(Action2)
    root:adicionar(action)
    root:adicionar(ACTION:construir(Action3))
    root:ler()
    root:excluirIndice(action)
    root:ler()
    print("nodeTEST.lua Completo!")
end

NodeTest()