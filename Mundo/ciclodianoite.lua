require('Recursos.constantes')
function math.lerp(a,b,t)
    return a + (b-a) * t
end
DiaNoite = {
    dia = {essencia = 'dia', quantidade = 20.00},
    noite = {essencia = 'noite', quantidade = 20.00},

    AdicionarCor = function(self, cor,opacidade)
        local cornovo = {}

        cornovo.r = cor[1] or 0
        cornovo.g = cor[2] or 0
        cornovo.b = cor[3] or 0
        cornovo.a = opacidade or 255
        
        function cornovo:lerp(c2,t)
            self.r = math.lerp(self.r,c2.r,t)
            self.g = math.lerp(self.g,c2.g,t)
            self.b = math.lerp(self.b,c2.b,t)
            self.a = math.lerp(self.a,c2.a,t)

        end
        function cornovo:Obter()
            return self.r,self.g,self.b,self.a
        end


        return cornovo
    end

}

local c = DiaNoite:AdicionarCor(Cores['brancaNuvem'],255)
local s = DiaNoite:AdicionarCor(Cores['vermelhaRosa'],255)
DiaNoite.ativo = DiaNoite.dia
DiaNoite.substituir = function ()
    if DiaNoite.ativo == DiaNoite.dia then
        DiaNoite.ativo = DiaNoite.noite
    else
        DiaNoite.ativo = DiaNoite.dia
    end
end

DiaNoite.__index = DiaNoite

--[[
local timer = 0
function DiaNoite:Atualizar(dt)
    timer = timer + dt
    if timer >= interval then
        timer = 0
    end
end
]]
function DiaNoite:Atualizar(dt)
    c:lerp(s,0.001)
end


function DiaNoite:Desenhar()
    
    love.graphics.setColor(love.math.colorFromBytes(c:Obter()))
    love.graphics.rectangle('fill',0,0,MundoX,MundoY)
end

return DiaNoite