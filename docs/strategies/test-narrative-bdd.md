⬅️ [Voltar para o Início](../../README.md)

# Metodologia: Narrativa de Testes (Full-Stack Quality)

**Conceito Central:**
> "A qualidade sistêmica é alcançada quando o teste valida não apenas o comportamento visual, mas a integridade da jornada completa: da Interface ao Banco de Dados."

Este documento detalha meu workflow operacional para execução de tarefas de qualidade, utilizando uma abordagem de **Narrativa de Testes** que integra refinamento de requisitos (Shift-Left), execução em BDD e validação técnica profunda.

---

## 🏗️ Os Dois Estágios da Operação

Ao assumir uma tarefa no Jira, o processo é dividido em dois documentos vivos:

### 1. QA Notes (Fase de Descoberta/Refinamento)
Criado no início do ciclo da tarefa. O objetivo é mapear o "o quê" e o "como" antes da execução propriamente dita.
- **Objetivo:** Descrição clara do benefício ou funcionalidade sendo validada.
- **Escopo e Escopo Negativo:** O que será testado e, crucialmente, o que *não* será (limitação de riscos).
- **Dependências:** Mapeamento de pre-requisitos (ambientes, usuários específicos, massa prévia).
- **Pontos de Atenção:** Identificação proativa de riscos de regressão e efeitos colaterais.

### 2. QA Execução (Fase de Validação Técnica)
Documento focado na evidência e na rastreabilidade, organizado por blocos lógicos.
- **Estrutura BDD (Behavior-Driven Development):** Escrita baseada em cenários (Dado/Quando/Então) usando linguagem ubíqua para facilitar o entendimento de todos os stakeholders.
- **Rastreabilidade:** Cada bloco de execução é vinculado a evidências técnicas (logs, prints, links de ferramentas de captura).

---

## 🔍 Validação Full-Stack: Além da Tela

Um diferencial sênior deste framework é a profundidade da validação técnica em cada cenário:

### Validação de Banco de Dados (Database Testing)
Utilizo ferramentas como **HeidiSQL** para validar se as operações realizadas na interface persistiram corretamente no banco de dados.
- **Consultas Customizadas:** Escrita de queries SQL para validar integridade de registros, tabelas de log e alterações de estado.
- **Idempotência:** Garantir que o estado final do banco após o teste permite a reprodutibilidade do cenário.

### Validação de Backend e Network (API Testing)
Uso extensivo do **DevTools** e logs de servidor para validar o tráfego de dados.
- **Payloads e Contratos:** Verificação se os dados enviados nas requisições (JSON) estão de acordo com o esperado e se os status codes retornados condizem com as regras de negócio.
- **Observabilidade:** Análise de logs de rede para diagnosticar erros que podem não ser visíveis visualmente no frontend.

---

## 📝 Template de Exemplo (Story: Resgate de Bônus)

### [QA Notes]
*   **Objetivo:** Validar o resgate manual de bônus via Backoffice e o reflexo imediato no saldo do usuário.
*   **Atenção:** O saldo deve ser atualizado instantaneamente no cache do PWA.
*   **Dependência:** Banco de dados de Homologação disponível para consulta via HeidiSQL.

### [QA Execução]
**Bloco 1: Concessão no Backoffice**
- **Cenário 1:** Conceder bônus de R$ 50,00 para usuário VIP.
    - **BDD:** *Dado* que acesso o painel admin... *Quando* concedo bônus... *Então* a requisição POST deve retornar status 201.
    - **DB Check:** `SELECT balance FROM user_wallet WHERE user_id = 'X'` deve mostrar o valor incrementado.

**Bloco 2: Consumo no PWA (Frontend)**
- **Cenário 2:** Visualizar saldo atualizado em tempo real.
    - **BDD:** *Dado* que estou logado no PWA... *Quando* acesso a carteira... *Então* o bônus deve estar visível corretamente.

---
⬅️ [Voltar para o Início](../../README.md)
