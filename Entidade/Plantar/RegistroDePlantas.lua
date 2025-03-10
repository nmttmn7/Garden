
RegistroDePlantas = {}
RegistroDePlantas.__index = RegistroDePlantas


function RegistroDePlantas:Adicionar(value)
    table.insert(RegistroDePlantas,value)
end

function RegistroDePlantas:Remover(index)
    table.remove(RegistroDePlantas,index)
end

function RegistroDePlantas:DiminuirTodaAgua()
    for _, value in ipairs(RegistroDePlantas) do
        value:DiminuirAgua()
    end 
end