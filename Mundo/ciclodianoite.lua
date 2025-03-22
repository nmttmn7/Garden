require('Recursos.constantes')
function math.lerp(a,b,t)
    return a + (b-a) * t
end

DiaNoite = {
    listaDeTempo = {},
    indice = 1,
    ativoTempo = {cor = {0,0,0}, alfa = 0, tempo = 0.01, essencia = 'dia'},
}

function DiaNoite:AdicionarCor(cor,alfa,tempo,essencia)
    local novo = {
        cor = cor,
        alfa = alfa,
        tempo = tempo,
        essencia = essencia
    }
    table.insert(DiaNoite.listaDeTempo,novo)
end

function DiaNoite:ObterAtivoTempo()
    return DiaNoite.ativoTempo
end

function DiaNoite:ObterAtivoCor()
    return DiaNoite.ativoTempo.cor[1],DiaNoite.ativoTempo.cor[2],DiaNoite.ativoTempo.cor[3],DiaNoite.ativoTempo.alfa
end

local tempo = 0.01
DiaNoite:AdicionarCor(Cores['pretaNoite'],20,tempo,'noite')
DiaNoite:AdicionarCor(Cores['brancaNuvem'],0,tempo,'dia')

DiaNoite.ativoTempo.tempo = DiaNoite.listaDeTempo[1].tempo
DiaNoite.ativoTempo.essencia = DiaNoite.listaDeTempo[1].essencia

local function VerificarCasas()

    for _, casa in pairs(JogoEntidades) do
        if casa.SairDeCasa ~= nil then
            casa:SairDeCasa()
        end
    end

end

local i = 1
function DiaNoite:Atualizar(dt)

    local ativoCor = DiaNoite.ativoTempo
    local c2 = DiaNoite.listaDeTempo[i]

    ativoCor.alfa = math.lerp(ativoCor.alfa,c2.alfa,ativoCor.tempo)

    if math.floor(ativoCor.alfa) == math.floor(c2.alfa) or math.floor(ativoCor.alfa) + 1 == math.floor(c2.alfa) then

        
        if i < #DiaNoite.listaDeTempo then
            i = i + 1
            ativoCor.tempo = DiaNoite.listaDeTempo[i].tempo
            ativoCor.essencia = DiaNoite.listaDeTempo[i].essencia
            VerificarCasas()
        else
            i = 1
            ativoCor.tempo = DiaNoite.listaDeTempo[i].tempo
            ativoCor.essencia = DiaNoite.listaDeTempo[i].essencia
            VerificarCasas()
        end
        

    end   

        
end



function DiaNoite:Desenhar()
    
    love.graphics.setColor(love.math.colorFromBytes(DiaNoite:ObterAtivoCor()))
    love.graphics.rectangle('fill',0,0,MundoX,MundoY)
end
--[[
return DiaNoite
--[[

DiaNoite33 = {
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

function DiaNoite:Atualizar(dt)
    c:lerp(s,0.001)
end


function DiaNoite:Desenhar()
    
    love.graphics.setColor(love.math.colorFromBytes(c:Obter()))
    love.graphics.rectangle('fill',0,0,MundoX,MundoY)
end

return DiaNoite
]]