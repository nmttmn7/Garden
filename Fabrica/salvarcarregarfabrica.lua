Dkjson = require "Libraries.dkjson"
local SalvarCarregarFabrica = {}

function Salvar(data,caminhoDoArquivo)
    
    
    caminhoDoArquivo = 'Data/' .. caminhoDoArquivo

    local arquivo = io.open(caminhoDoArquivo, 'w')

    if arquivo then
        
        local encoded = Dkjson.encode(data, { indent = true })

        arquivo:write(encoded)

        arquivo:close()

    end
end

function Carregar(caminhoDoArquivo)
    
    caminhoDoArquivo = 'Data/' .. caminhoDoArquivo

    local arquivo = io.open(caminhoDoArquivo, 'r')

    if not arquivo then 
        error('Could not open file: ' .. caminhoDoArquivo) 
    end

    local contente = arquivo:read('*a')
    arquivo:close()
    
    return Decodificar(contente)
end

function Decodificar(contente)
    local dato, posicao, err = Dkjson.decode(contente, 1, nil)
    if err then
        error('Error parsing Json: ' .. err)
    end

    return dato
end

function Claro(caminhoDoArquivo)

    caminhoDoArquivo = 'Data/' .. caminhoDoArquivo

    local arquivo = io.open(caminhoDoArquivo, 'w')

    if arquivo then

        arquivo:write('{}')

        arquivo:close()

    end


end

return SalvarCarregarFabrica