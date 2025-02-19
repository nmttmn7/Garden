Node_types = {
    SEQUENCE = {},
    SELECTOR = {},
    ACTION = {}
}

function Node_types.construir(Node_types, ...)
    local self = setmetatable({}, Node_types)
    self.Node_types = Node_types
    --node_types = ...
    return self
end

function Node_types:ler()

    --[[Note that you cannot guarantee any order in keyset. 
        If you want the keys in sorted order, then 
         sort keyset with table.sort(keyset).]]
        print("NO")
end

function Node_types.__index(tab,key)
    return Node_types[key]
end

local instance = Node_types.construir(Node_types.SEQUENCE, Node_types.SELECTOR,Node_types.ACTION)
instance:ler()