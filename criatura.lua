local love = require 'entidade'
local love = require 'love'

Criatura = Entidade:Construir()
Criatura.__index = Criatura

function Criatura:Construir(nome, saude, essencia, cerebelo)
    local this = Entidade:Construir(nome, saude, essencia)
    setmetatable(this, self)
    
    this.cerebelo = cerebelo

    return this
end

function Criatura:Draw()
    local opacity = 1

    love.graphics.setColor(1,1,1,opacity)

    love.graphics.rectangle('line', 50, 50, 50 ,50)

end

function Criatura:Update(dt)

end

function Criatura:Decidir()

end
--[[


--Make A Fuction that constructs what a node is!
function Criatura:E(type)
    --a local node that has THE TYPE and THE children table
    local TamanhoDaCriatura = 30
    local AnguloDeVisao = math.rad(90)
    
    local node = { type = type, x = love.graphics.getWidth() / 2,
    y = love.graphics.getWidth() / 2,
    radius = TamanhoDaCriatura / 2,
    angle = AnguloDeVisao,
    rotation = 0, }
    setmetatable(node, self)
    self.__index = self
    return node
end




function OO()
    
end
function Criatura(debugging)
    local TamanhoDaCriatura = 30
    local AnguloDeVisao = math.rad(90)

    
    return{
        x = love.graphics.getWidth() / 2,
        y = love.graphics.getWidth() / 2,
        radius = TamanhoDaCriatura / 2,
        angle = AnguloDeVisao,
        rotation = 0,
        

        draw = function (self)
            local opacity = 1

            love.graphics.setColor(1,1,1,opacity)
            
            love.graphics.polygon('line',
            self.x + ((4/3) * self.radius) * math.cos(self.angle),
            self.y + ((4/3) * self.radius) * math.sin(self.angle),
            self.x - self.radius * (2 / 3 * math.cos(self.angle) + math.sin(self.angle)),
            self.y + self.radius * (2 / 3 * math.sin(self.angle) + math.cos(self.angle)),
            self.x - self.radius * (2 / 3 * math.cos(self.angle) + math.sin(self.angle)),
            self.y + self.radius * (2 / 3 * math.sin(self.angle) + math.cos(self.angle))
        )




        end
    }

end

]]