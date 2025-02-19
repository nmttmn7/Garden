
-- Base Node Class
--[[Node Class that is a type = type then has all its children
    Cannot do NODE = SEQUENCE = {}, SELECTOR = {}, ACTION = {}
    BECAUSE THAT MEANS EACH NODE HAS A SEQUENCE, SELECTOR, ACTION]]

    local WALK_DISTANCE_X = 40
    local WALK_DISTANCE_Y = 40
    local WALK_DISTANCE_Z = 40

--Initialize NODE
posicao = {}
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
    for k, v in ipairs(self.children) do
        if k == index then
         return v
        end
    end
end


function Node:ler()
    print('----------------------------------')
    print('[N]: ' .. self.type)
    print('[C]: ')
    for _, v in ipairs(self.children) do
        print(v.type)
    end
    print('----------------------------------')
end

function Node:recLer()

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
SEQUENCE = Node:construir("SEQUENCE")
function SEQUENCE:correr(entity)
    for _, v in ipairs(self.children) do

        local state = v:correr(entity)

        if state == STATES.FAILURE or state == STATES.RUNNING then
            return STATES.FAILURE -- Fail if any child fails
        end
    end

    return STATES.SUCCESS -- Succeed if all children succeed
end


--STOPS AT FIRST CHILD THAT IS SUCCESS OR RUNNING
SELECTOR = Node:construir('SELECTOR')
function SELECTOR:correr(entity)

    for _, v in ipairs(self.children) do

        local state = v:correr(entity)

        if state == STATES.SUCCESS or state == STATES.RUNNING then
            return STATES.SUCCESS -- SUCCEEDS if any child fails
        end

    end
    
    return STATES.FAILURE -- Fails if all children fail
end

--SUCCESS RUNNING FAILURE
ACTION = Node:construir("ACTION")
function ACTION:construir(func)
    local action = { func = func }
    setmetatable(action, self)
    self.__index = self
    return action
end
function ACTION:correr(entity)
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

    local x = 0
    local y = 0
    local z = 0


    if entity.posicao.X > x then
        entity.posicao.X = entity.posicao.X - 1
    elseif entity.posicao.X < x then
        entity.posicao.X = entity.posicao.X + 1
    end

    print(entity.posicao.X)

    if entity.posicao.X == x then
        return STATES.SUCCESS;
    end

    return STATES.RUNNING
end

function Walk(entity)

    local X = WALK_DISTANCE_X * entity.velocidade
    local Y = WALK_DISTANCE_Y * entity.velocidade
    local Z = WALK_DISTANCE_Z * entity.velocidade

    entity.posicao.X = entity.posicao.X - X
    entity.posicao.Y = entity.posicao.Y - Y
    entity.posicao.Z = entity.posicao.Z - Z

    if entity.posicao.X == x and entity.posicao.Y == y and entity.posicao.Z == z then
        return true
    end

        return false

end



function claraMem()
    Memory = {}
end


STATES = {
    SUCCESS = 'SUCCESS',
    RUNNING = 'RUNNING',
    FAILURE = 'FAILURE'
}