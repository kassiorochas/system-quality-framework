⬅️ [Voltar para o Início](../../README.md)

# Metodologia: Narrativa de Testes (Full-Stack Quality)

**Conceito:**
> "A qualidade sistêmica é alcançada quando o teste valida não apenas a tela, mas a integridade de toda a jornada: da interface ao banco de dados."

Este documento detalha o meu workflow operacional para execução de testes. Utilizo uma abordagem chamada **Narrativa de Testes**, que organiza a estratégia em dois momentos principais: o planejamento antecipado (QA Notes) e a execução detalhada (QA Execução).

---

## 🏗️ As Duas Fases da Entrega

Sempre que inicio uma tarefa, divido o meu trabalho em dois estágios:

### 1. QA Notes (Planejamento e Descoberta)
Criado logo no início da tarefa. O foco aqui é o **Shift-Left** (trazer a qualidade para o começo do processo).
- **Objetivo:** Descrição clara do que está sendo validado.
- **Escopo:** O que será testado e o que está fora do escopo.
- **Dependências:** O que eu preciso ter em mãos (ambientes, massa de dados, permissões) para começar.
- **Diagnóstico Prévio (RCA):** Se um problema for identificado já no refinamento, documento a possível causa raiz (ex: erro de tipo de dado) para que o desenvolvedor já saiba por onde começar.

### 2. QA Execução (Evidência Técnica)
Focado no registro da execução real, garantindo que o teste seja auditável e claro.
- **Escrita em BDD:** Uso da estrutura Dado/Quando/Então em linguagem clara para que todos os stakeholders entendam o resultado.
- **Rastreabilidade:** Cada cenário é acompanhado de evidências técnicas, como logs de rede, prints ou links de captura de tela.

---

## 🔍 Validação Full-Stack: Além do Visual

Um diferencial desta metodologia é a profundidade técnica em cada validação:

### Banco de Dados (Database Testing)
Utilizo ferramentas como **SQL Server / MySQL** para garantir que o que aconteceu na tela foi gravado corretamente no banco.
- **Consultas (Queries):** Validação de persistência de dados e integridade de registros.

### Backend e Network (API Testing)
Uso do **DevTools** para acompanhar o tráfego de dados.
- **Validação de Payload:** Verificação se os dados enviados e os códigos de resposta (Status Codes) estão corretos.
- **Observabilidade:** Identificação de erros silenciosos que não aparecem na interface, mas impactam o sistema.

---

## 📝 Exemplo Prático (QA Notes)

### [Diagnóstico de Causa Raiz - Exemplo]
*   **Cenário:** Falha no campo de Geolocalização.
*   **Análise:** Identificado que, quando o GPS falha, o Frontend envia a palavra `"undefined"` em vez de um valor vazio. 
*   **Impacto:** Isso causa erro na API que espera um valor nulo, não uma String.
*   **Dica Técnica:** Preparar a massa de dados forçando a expiração do cadastro no banco via SQL para testar o fluxo de atualização.

---
⬅️ [Voltar para o Início](../../README.md)
