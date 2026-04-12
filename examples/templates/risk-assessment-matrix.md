# Template: Matriz de Risco Técnico (QA Scope)

**Objetivo:** Este artefato auxilia na definição de onde os esforços de automação e teste manual devem ser concentrados, priorizando o que realmente importa para o negócio.

---

## 📊 Matriz de Criticidade (Impacto x Probabilidade)

| Funcionalidade | Impacto (Negócio) | Probabilidade (Falha) | Prioridade de Teste | Estratégia Recomendada |
| :--- | :--- | :--- | :--- | :--- |
| **Login / Auth** | Altíssimo | Baixa | **P1 (Crítico)** | Automação E2E + Smoke Test Pipeline |
| **Integração Pagamento** | Altíssimo | Média | **P1 (Crítico)** | Automação API + Validação de Banco |
| **Atualização Perfil** | Médio | Alta | **P2 (Alto)** | Exploratório + Automação de Regressão |
| **Relatórios Históricos** | Baixo | Baixa | **P3 (Baixo)** | Teste Manual / Amostragem |

---

## 🔍 Critérios de Escopo (Discussion Points)

Ao discutir o escopo com Product Owners e Desenvolvedores, considere:

1.  **Complexidade Técnica:** O código envolve integrações externas (parceiros) ou múltiplos microsserviços?
2.  **Volume de Dados:** O fluxo afeta a base de dados central de usuários?
3.  **Frequência de Uso:** Esta funcionalidade é usada pelo "usuário final" (Front) ou apenas por moderadores (Backoffice)?
4.  **Histórico de Débito Técnico:** Esta área do sistema costuma gerar bugs recorrentes?

---
> **Uso Recomendado:** Utilize este template durante as sessões de Refinement ou Sprint Planning para alinhar o escopo de qualidade com o time de engenharia.
