Jogadora = {}
Jogadora.__index = Jogadora

function Jogadora:Construir(regador)
    local this = {
        regador = regador
    }
    setmetatable(this,self)
    return this
end
