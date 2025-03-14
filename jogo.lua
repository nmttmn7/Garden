

function JogoNovo()
    Claro('mundo.json')
    
end

function CarregarJogo()

    CarregarMundo()
    CarregarJogoEntidades()
    --    local dato = Carregar('jogadora.json')
  --  Jogadora:Construir(dato['regador'])
end

function SalvarJogo()
    Salvar(gMundo, 'mundo.json')
    Salvar(JogoEntidades,'jogoentidades.json')
 --   Salvar(RegistroDeEntidade,'registrodeentidade.json')
   
end

