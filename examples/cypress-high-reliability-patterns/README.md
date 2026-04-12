# Cypress: Padrões de Alta Confiabilidade (Reliability)

Este exemplo demonstra as estratégias que utilizo para garantir que a automação de testes seja resiliente e livre de falhas intermitentes (*flakiness*). O foco aqui é criar testes que sejam rápidos e que reflitam situações reais do dia a dia.

---

## 🛡️ Estratégias de Resiliência

### 1. Limpeza de Dados e Idempotência
Para garantir que um teste possa ser executado diversas vezes com o mesmo dado (como um CPF específico), utilizamos uma integração via `cy.task`.
*   **O que faz:** Antes de iniciar o teste, o framework verifica no banco de dados se aquele usuário já existe. Se existir, ele é removido automaticamente.
*   **Benefício:** Elimina a necessidade de criar dados aleatórios e garante que o ambiente esteja sempre limpo para o teste.

### 2. Tratamento de Elementos Instáveis (Detached DOM)
Em aplicações modernas, é comum que elementos desapareçam e reapareçam rapidamente, o que pode causar erros nos testes.
*   **Solução:** Implementamos seletores que aguardam o estado ideal do elemento (visível e habilitado) antes de qualquer interação, garantindo estabilidade.

### 3. Simulação de Geolocalização (Stubs)
Aplicações que dependem da posição do usuário podem ser difíceis de testar. 
*   **Solução:** Simulamos as coordenadas geográficas diretamente no carregamento da página, permitindo validar fluxos de localização sem depender do GPS real.

### 4. Configuração Prévia via LocalStorage
Muitas vezes, popups de cookies ou telas de boas-vindas atrapalham a execução.
*   **Solução:** Injetamos as configurações necessárias diretamente no `localStorage` antes de abrir a página, focando o teste apenas no que realmente importa: a regra de negócio.
