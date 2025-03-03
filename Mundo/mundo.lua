Mundo = {}
Mundo.__index = Mundo

function Mundo:Construir(telhas,largura,altura)
    local this = {
        telhas = telhas,
        largura = largura, --Width
        altura = altura, --Height
        tamanhoDaCelula = 64
    }
    setmetatable(this,self)

    return this
end

function Mundo:Empate()
    for row=0,self.altura-1 do 
        for col=0,self.largura-1 do
            local sx = col * self.tamanhoDaCelula
            local sy = row * self.tamanhoDaCelula
            local tile = self:ObterTelha(col,row)
            if tile == 0 then
                
                love.graphics.rectangle('line',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)
              
            elseif tile == 1 then
                love.graphics.setColor(love.math.colorFromBytes(56,25,10))
                love.graphics.rectangle('fill',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)
                love.graphics.setColor(1,1,1,1)
            elseif tile == 2 then
                love.graphics.setColor(love.math.colorFromBytes(56,128,4))
                love.graphics.rectangle('fill',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)
                love.graphics.setColor(1,1,1,1)
            elseif tile == 3 then
                love.graphics.setColor(love.math.colorFromBytes(56,128,4))
                love.graphics.rectangle('fill',sx,sy,self.tamanhoDaCelula,self.tamanhoDaCelula)
                love.graphics.setColor(1,1,1,1)
            end
            
        end
    end
end

function Mundo:ObterTelha(x,y)

    if x < 0 or y < 0 or x > self.largura-1 or y > self.altura-1 then
        return -1
    end

    return self.telhas[y * self.largura + x + 1]
end

function Mundo:MudarTelha(x,y,tileType)
    if x < 0 or y < 0 or x > self.largura-1 or y > self.altura-1 then
        return false
    end

    self.telhas[y * self.largura + x + 1] = tileType
    return true
end