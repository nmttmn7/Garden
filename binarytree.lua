
--BINARY LEAF
NodeBN = {}

function NodeBN:construir(id)
    --a local node that has THE TYPE and THE children table
    local nodeBN = {id = id, esquerdo, direito, altura = 1}
    setmetatable(nodeBN, self)
    self.__index = self
    return nodeBN
end

function NodeBN:Equilibrio()
    local L = 0
    local R = 0
    if self.esquerdo ~= nil then
        L = self.esquerdo.altura
    end
    if self.direito ~= nil then
        R = self.direito.altura
    end
   
    local B = L - R
    print("ID: " .. self.id .. " B: " .. B)
    if B < -1 or B > 1 then
    end
    return B
end
--Add
function NodeBN:Adicionar(value)

    local esquerdo = self.esquerdo
    local direito = self.direito

    

    if value.id < self.id then
        if self.esquerdo ~= nil then
            self.altura = self.altura + 1
            self.esquerdo:Adicionar(value)
        else
            self.altura = self.altura + 1
            self.esquerdo = value
        end
    else
        if self.direito ~= nil then
            self.altura = self.altura + 1
            self.direito:Adicionar(value)
        else
            self.altura = self.altura + 1
            self.direito = value
        end
    end

    self:Equilibrio()
end



function MudarDireito(root)
    local esquerdo = root.esquerdo
    root.esquerdo = nil

    if esquerdo.direito ~= nil then
        root:adicionar(esquerdo.direito)
        esquerdo.direito = nil
    end

    esquerdo.direito = root

end

function MudarEsquerdo(root)
    local direito = root.direito
    root.direito = nil

    if direito.esquerdo ~= nil then
        root:adicionar(direito.esquerdo)
        direito.esquerdo = nil
    end

    direito.esquerdo = root

end

function Procurar(root, id)

    if root == id then
        return root
    end

    if root.id > id then
        Procurar(root.direito, id)
    end
end

function NodeBN:Ler()
--[[    print(self.id)
    print(self.esquerdo.id)
    print(self.esquerdo.direito.id)
    print(self.esquerdo.direito.direito.id)
    ]]
    print("ID: " .. self.id .. " HEIGHT: " .. self.altura)
    if self.esquerdo ~= nil then
        self.esquerdo:Ler()
    end

    if self.direito ~= nil then
        self.direito:Ler()
    end

end
