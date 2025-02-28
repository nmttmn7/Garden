require 'Nodes/actions'
-- Base Node Class
--[[Node Class that is a type = type then has all its children
    Cannot do NODE = SEQUENCE = {}, SELECTOR = {}, ACTION = {}
    BECAUSE THAT MEANS EACH NODE HAS A SEQUENCE, SELECTOR, ACTION]]

    local WALK_DISTANCE_X = 40
    local WALK_DISTANCE_Y = 40
    local WALK_DISTANCE_Z = 40

--Initialize NODE
Node = {}
--Make A Fuction that constructs what a node is!
function Node:Construir(type)
    --a local node that has THE TYPE and THE children table
    local node = { type = type, children = {} }
    setmetatable(node, self)
    self.__index = self
    return node
end


--Add 
function Node:Adicionar(value)
    table.insert(self.children, value)
end
--Delete
function Node:ExcluirIndice(index)
    table.remove(self.children, index)
end


function Node:ObterIndice(index)
    for k, v in ipairs(self.children) do
        if k == index then
         return v
        end
    end
end


function Node:Ler()
    print('----------------------------------')
    print('[N]: ' .. self.type)
    print('[C]: ')
    for _, v in ipairs(self.children) do
        print(v.type)
    end
    print('----------------------------------')
end

function Node:RecLer()

    print('----------------------------------')
    if #self.children == 0 then
        return
    end


    for _, v in ipairs(self.children) do
        print(v.type)
        print(#v.children)
        v:recLer()
    end
    print('----------------------------------')


end


--STOPS AT FIRST CHILD THAT IS FAILURE OR RUNNING
SEQUENCE = Node:Construir("SEQUENCE")
function SEQUENCE:Correr(entity)
    for _, v in ipairs(self.children) do

        local state = v:Correr(entity)

        if state == STATES.FAILURE or state == STATES.RUNNING then
            return STATES.FAILURE -- Fail if any child fails
        end
    end

    return STATES.SUCCESS -- Succeed if all children succeed
end


--STOPS AT FIRST CHILD THAT IS SUCCESS OR RUNNING
SELECTOR = Node:Construir('SELECTOR')
function SELECTOR:Correr(entity)

    for _, v in ipairs(self.children) do

        local state = v:Correr(entity)

        if state == STATES.SUCCESS or state == STATES.RUNNING then
            return STATES.SUCCESS -- SUCCEEDS if any child fails
        end

    end
    
    return STATES.FAILURE -- Fails if all children fail
end

--SUCCESS RUNNING FAILURE
ACTION = Node:Construir("ACTION")
function ACTION:Construir(func)
    local action = { func = func }
    setmetatable(action, self)
    self.__index = self
    return action
end
function ACTION:Correr(entity)
    return self.func(entity) -- Execute the action
end

-- Example Actions
function ActionTRUE()
    print("Action: SUCCESS")
    return STATES.SUCCESS
end

function ActionFALSE()
    print("Action: FAILURE")
    return STATES.FAILURE
end

function ActionRUNNING()
    print("Action: RUNNING")
    return STATES.RUNNING
end
--For Food
function ParaComida(entity)

    local x = 50
    local y = 50
 
    local posicao = entity:ObtePosicao()

    if posicao.x > x then
        posicao.x = posicao.x - 1
    elseif posicao.x < x then
        posicao.x = posicao.x + 1
    end

    if posicao.y > y then
        posicao.y = posicao.y - 1
    elseif posicao.y < y then
        posicao.y = posicao.y + 1
    end

    print(posicao.x)

    if posicao.x == x then
        return STATES.SUCCESS;
    end

    return STATES.RUNNING
end

STATES = {
    SUCCESS = 'SUCCESS',
    RUNNING = 'RUNNING',
    FAILURE = 'FAILURE'
}