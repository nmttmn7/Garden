

function JogoNovo()
    Claro('mundo.json')
    
end

function CarregarJogo()

    local dato = Carregar('jogadora.json')
    Jogadora:Construir(dato['regador'])

end

function SalvarJogo()
    Salvar(gMundo, 'mundo.json')
    
 --   Salvar(RegistroDeEntidade,'registrodeentidade.json')
   
end

