Modulos = {x,y,cor}
Modulos.__index = Modulos


theta = 2 * math.pi

function Modulos:Construir(x,y,cor)

    local this = {x=x,y=y,cor=cor}

    setmetatable(this, self)


    return this
end


function Modulos:Draw()
    local opacity = 1
    love.graphics.setColor(love.math.colorFromBytes(self.cor))
    love.graphics.circle('fill', self.x, self.y, 20)
    love.graphics.setColor(0,0,0,1)
    love.graphics.circle('line', self.x, self.y, 20)
    
end

function Modulos:Update()


end

function Modulos:Move(mod,x,y,novoTheta)
    local radius = 50
    
    mod.x = x + radius * math.cos(novoTheta)
    mod.y = y + radius * math.sin(novoTheta)
end

function Modulos:Order(list,x,y)
    local count = #list
    local construirValue = theta
    construirValue = construirValue / count
    love.graphics.print(count .. " eee " .. construirValue)
    for index, value in ipairs(list) do
        self:Move(value,x,y,construirValue * index)
    end
end