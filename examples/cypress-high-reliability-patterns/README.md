# Cypress: Estratégias de Alta Confiabilidade (High Reliability)

Este blueprint demonstra padrões avançados de arquitetura de testes E2E utilizados para garantir que a automação seja resiliente, rápida e livre de "flakiness" (testes que falham de forma intermitente).

## 🛡️ Padrões de Resiliência Aplicados

### 1. Gestão de Estado e Limpeza de Banco (Idempotência)
Para garantir que o teste possa ser executado infinitas vezes com o mesmo dado (como um CPF específico), utilizamos integração direta com o banco de dados via `cy.task`.
*   **Ação:** Antes de iniciar o fluxo de registro, o framework consulta o banco. Se o usuário já existir, ele é removido via API/DB.
*   **Benefício:** Elimina a dependência de "geradores de massa" aleatórios que podem dificultar a depubação.

### 2. Tratamento de Detached DOM (React/Modern Frameworks)
Em SPAs modernas, os elementos podem ser re-renderizados rapidamente, causando o erro `element is detached from the DOM`.
*   **Solução:** Implementamos seletores robustos com asserções encadeadas (`.should()`) que aguardam o estado final do elemento (visível e habilitado) antes da interação.

### 3. Stubs de Geolocalização e Sensores
Muitas aplicações exigem a localização do usuário para liberar fluxos de negócio. 
*   **Solução:** Utilizamos `cy.stub` no objeto `navigator.geolocation` para simular coordenadas geográficas fidedignas no momento do carregamento da página.

### 4. Bypass de Modais e Consentimentos
Interagir com popups de cookies ou modais de boas-vindas em cada teste consome tempo e gera instabilidade.
*   **Solução:** Injetamos configurações diretamente no `localStorage` ou enviamos cookies de consentimento via `request` antes da visita, focando o teste apenas no fluxo de negócio.
