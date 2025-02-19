--ENTITY
local NODE_Y = {
    SEQUENCE = {},
    SELECTOR = {},
    ACTION = {}
}



-- Base Node Class
local Node = {}
function Node:construir(type)
    local node = { type = type, children = {} }
    setmetatable(node, self)
    self.__index = self
    return node
end

--[[Node Class that is a type = type then has all its children
    Cannot do NODE = SEQUENCE = {}, SELECTOR = {}, ACTION = {}
    BECAUSE THAT MEANS EACH NODE HAS A SEQUENCE, SELECTOR, ACTION]]




local instance = Node.construir('SEQUENCE')

