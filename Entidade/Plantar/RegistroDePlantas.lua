
require('Entidade.Plantar.tulipa')
RegistroDePlantas = {
    Tulipa,
    2
}
RegistroDePlantas.__index = RegistroDePlantas


function OO()
    local s = RegistroDePlantas[1]

    if s == nil then
        print("EMOTY")
    end
    s:OO()
end

OO()