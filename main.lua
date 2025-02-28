--require('world')
--require('entity')
--require('node')

require 'constants'
require 'push-master/push'

require 'Criaturas/formiga'

local Entidades = {}


function love.load()

    local show_debugging = true

    formiga = Formiga:Construir('Antanas')

    table.insert(Entidades, formiga)
    
end

function love.update(dt)
    formiga:Update()
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end
end

function love.draw()
    formiga:Draw()
    
end