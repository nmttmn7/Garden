--ENTITY
Entity = {
    nome, --name
    essencia, -- essence
    fome, --hunger
    sede,  --thirst
    arvoreDeComportamento --Behavior Tree
}

function Entity.construir(nome, essencia, fome, sede)
    local self = setmetatable({}, Entity)

    self.nome = nome
    self.essencia = essencia
    self.fome = fome
    self.sede = sede

    return self
end

function Entity.construirCerebro(cerebro)
    local self = setmetatable({}, Entity)
    
    self.arvoreDeComportamento = cerebro

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

function Entity:ler()

    --[[Note that you cannot guarantee any order in keyset. 
        If you want the keys in sorted order, then 
         sort keyset with table.sort(keyset).]]

    for k, v in pairs(self) do
        print(k .. ": " .. v)
    end
end

--ENTITY.__index = ENTITY (Does same this as this) Kinda like a pointer points to this method and links it with class
function Entity.__index(tab,key)
    return Entity[key]
end



