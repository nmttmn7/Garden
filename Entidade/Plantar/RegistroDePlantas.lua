
local allEntities = {
    'tulipa' == Tulipa:Construir()
}

 RegistroDeEntidade = {}
RegistroDeEntidade.__index = RegistroDeEntidade


function RegistroDeEntidade:Adicionar(value)
    table.insert(RegistroDeEntidade,value)
end

function RegistroDeEntidade:Remover(index)
    table.remove(RegistroDeEntidade,index)
end


function RegistroDeEntidade:Carregar()
    
end
