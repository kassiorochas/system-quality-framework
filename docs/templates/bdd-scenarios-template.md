# BDD Scenarios — Template

## Cenário 1 — Fluxo principal
**Dado** que o usuário acessa o fluxo com os pré-requisitos válidos  
**Quando** realiza a ação principal  
**Então** o sistema deve concluir o processo com sucesso

## Cenário 2 — Permissão insuficiente
**Dado** que o usuário não possui a permissão necessária  
**Quando** tenta acessar ou executar a funcionalidade  
**Então** o sistema deve impedir a ação conforme a regra definida

## Cenário 3 — Dados inválidos
**Dado** que existem campos obrigatórios ou regras de validação  
**Quando** valores inválidos são enviados  
**Então** o sistema deve exibir a resposta adequada sem quebrar o fluxo

## Cenário 4 — Idempotência
**Dado** que a mesma ação é enviada mais de uma vez  
**Quando** o sistema recebe requisições repetidas  
**Então** o comportamento deve seguir a regra de idempotência definida

## Cenário 5 — Integração externa
**Dado** que o fluxo depende de um provedor externo  
**Quando** a integração responde com sucesso ou erro  
**Então** o sistema deve tratar corretamente os dois comportamentos
