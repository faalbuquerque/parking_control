# Parking Control

### O projeto consiste em criar uma API de controle de estacionamento 


#### Regras:

● Deve registrar entrada, saída e pagamento por placa;

● Não deve liberar saída sem pagamento;

● Deve fornecer um histórico por placa.

● Essa api deve respeitar os status http corretamente, deve aceitar e responder por json.


### Principais tecnologias utilizadas:

✓ Ruby
✓ Sinatra
✓ Webrick
✓ Mongo
✓ Rspec
✓ Rubocop
✓ Simplecov
✓ Docker
✓ Docker Compose

### Configuraçoes iniciais

Clone o repositório:
```
git@github.com:faalbuquerque/parking_control.git
```

Acesse a pasta do repositório clonado:
```
parking_control parking_control
```

Dê as permissoes necessárias:
```
sudo chmod -R +x ./bin/
```

Rode o arquivo de ENVs:
```
cp .env.sample .env
```

Suba a aplicação:
```
bin/setup
```

### Utilizando os endpoints

Como criar entrada de estacionamento:
```
curl -X POST -d '{"plate": "aaa-1234"}' -H 'Content-type:application/json' http://127.0.0.1:4567/parking
```

Como ver histórico por placa:
```
curl http://127.0.0.1:4567/parking/aaa-1234
```

Como pagar:
```
curl -X PUT -d {} http://127.0.0.1:4567/parking/aaa-1234/pay
```

Como sair:
```
curl -X PUT -d {} http://127.0.0.1:4567/parking/aaa-1234/out
```

### Como testar( Em desenvolvimento ⌛)

Para rodar testes execute:
```
docker-compose exec web rspec
```

Para rodar Rubocop execute:
```
docker-compose exec web rubocop
