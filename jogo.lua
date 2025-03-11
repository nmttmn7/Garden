

function JogoNovo()

end

function CarregarJogo()

    local dato = Carregar('jogadora.json')
    Jogadora:Construir(dato['regador'])

end

function SalvarMundo()
    Salvar(gMundo, 'mundo.json')
end