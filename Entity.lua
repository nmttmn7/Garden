--ENTITY
local ENTITY = {
    nome, --name
    essencia, -- essence
    fome, --hunger
    sede  --thirst
    --Behavior Tree
}

function ENTITY.construir(nome, essencia)
    local self = setmetatable({}, ENTITY)

    self.nome = nome
    self.essencia = essencia

    return self
end


--[[Just remeber this can be done 
function ENTITY.construct(...)
    local self = setmetatable({}, ENTITY)
    
    local args = {...}
    for _, v in pairs(args) do
        
    end

    print('[1]' .. args[1])
    
end   ENTITY.construct({nome = 'hello'})]]

function ENTITY:ler()

    --[[Note that you cannot guarantee any order in keyset. 
        If you want the keys in sorted order, then 
         sort keyset with table.sort(keyset).]]

    for k, v in pairs(self) do
        print(k .. ": " .. v)
    end
end

--ENTITY.__index = ENTITY (Does same this as this) Kinda like a pointer points to this method and links it with class
function ENTITY.__index(tab,key)
    return ENTITY[key]
end



local instance = ENTITY.construir("Onyx", "Rock")
instance:ler()
