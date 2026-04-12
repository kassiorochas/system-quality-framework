# Database Validation Patterns: Auditing the Data Lifecycle

**Conceito:**
> "A interface mente, mas o banco de dados guarda a verdade. Validar a qualidade sistêmica exige auditar a persistência e a integridade dos dados."

Este blueprint demonstra como o uso estratégico de SQL (via HeidiSQL ou scripts automatizados) eleva o nível de confiança das entregas. Aqui, tratamos o banco de dados não apenas como um local de armazenamento, mas como uma ferramenta ativa de validação de regras de negócio complexas.

---

## 🏗️ Estratégias de Validação

### 1. Orquestração de Massa e Cleanup
Em ambientes de teste, a capacidade de "resetar" o estado de um usuário de forma limpa é crucial para evitar falsos positivos.
- **Destaque:** Uso de scripts que respeitam (ou manipulam conscientemente) as chaves estrangeiras (`FOREIGN KEYS`) para garantir limpeza profunda sem deixar órfãos no sistema.
- **Exemplo:** [Exclusão e Reset de Estado](scripts/cleanup-orchestration.sql)

### 2. Auditoria de Integridade Financeira
Validação de regras de negócio que envolvem cálculos e conciliação entre diferentes tabelas.
- **Destaque:** Queries que consolidam entradas e saídas (Depósitos vs Saques) para garantir que o balanço exibido ao usuário reflete a realidade das transações gravadas.
- **Exemplo:** [Auditoria de Balanço e Transações](scripts/financial-integrity-audit.sql)

### 3. Manipulação de Fluxos de Estado
Capacidade de forçar o sistema a entrar em cenários específicos (ex: auto-exclusão, banimento, expiração de bônus) via alteração direta no banco.
- **Destaque:** Inserção de logs de auditoria e alteração de flags de status para testar comportamentos de segurança no Frontend.
- **Exemplo:** [Manipulação de Estados e Logs](scripts/state-flow-manipulation.sql)

---

## 🏆 Case Real: Identificação de Divergência de Status
Um exemplo de como o olhar clínico no banco de dados resolve problemas de arquitetura antes do lançamento.
- 👉 **[Case: Backend vs Frontend Status Mismatch](cases/back-vs-front-status-mismatch.md)**
