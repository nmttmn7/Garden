
-- Base Node Class
--[[Node Class that is a type = type then has all its children
    Cannot do NODE = SEQUENCE = {}, SELECTOR = {}, ACTION = {}
    BECAUSE THAT MEANS EACH NODE HAS A SEQUENCE, SELECTOR, ACTION]]


--Initialize NODE
Node = {}
--Make A Fuction that constructs what a node is!
function Node:construir(type)
    --a local node that has THE TYPE and THE children table
    local node = { type = type, children = {} }
    setmetatable(node, self)
    self.__index = self
    return node
end

--Add 
function Node:adicionar(value)
    table.insert(self.children, value)
end
--Delete
function Node:excluirIndice(index)
    table.remove(self.children, index)
end


function Node:obterIndice(index)
    for k, v in pairs(self.children) do
        if k == index then
         return v
        end
    end
end


function Node:ler()
    print('----------------------------------')
    print('[N]: ' .. self.type)
    print('[C]: ')
    for _, v in pairs(self.children) do
        print(v.type)
    end
    print('----------------------------------')
end

function Node:recLer()

    print('----------------------------------')
    if #self.children == 0 then
        return
    end


    for _, v in pairs(self.children) do
        print(v.type)
        print(#v.children)
        v:recLer()
    end
    print('----------------------------------')
    

end


-- Sequence Node: Runs children in order, fails if any child fails
SEQUENCE = Node:construir("SEQUENCE")
function SEQUENCE:correr()
    for _, child in pairs(self.children) do
        if not child:correr() then
            return false -- Fail if any child fails
        end
    end
    return true -- Succeed if all children succeed
end


--STOPS AT FIRST CHILD THAT IS SUCCESS OR RUNNING
SELECTOR = Node:construir('SELECTOR')
function SELECTOR:correr()

    for _, v in pairs(self.children) do

        local state = v.correr()

        if state == true then
            return true
        end

    end
    
    return false
end

--SUCCESS RUNNING FAILURE
ACTION = Node:construir("ACTION")
function ACTION:construir(func)
    local action = { func = func }
    setmetatable(action, self)
    self.__index = self
    return action
end
function ACTION:correr()
    return self.func() -- Execute the action
end

-- Example Actions
function ActionTRUE()
    print("Action 1: Succeeded")
    return true
end

function ActionFALSE()
    print("Action 2: Failed")
    return false
end

function Action3()
    print("Action 3: Succeeded")
    return true
end
