# Case Técnico: Divergência de Estrutura entre Camadas

### 🔍 O Problema Identificado
Durante a validação de uma demanda de atualização de perfil, identifiquei um erro crítico na comunicação entre o Frontend e o Banco de Dados que inviabilizava a persistência dos dados.

- **O que aconteceu:** O sistema apresentava falhas intermitentes ao tentar salvar o novo estado de um usuário após a conclusão do fluxo.
- **Minha investigação:** Ao realizar uma auditoria na estrutura da tabela via **HeidiSQL**, identifiquei que o banco esperava valores numéricos específicos para representar os status (ex: `1`, `2`, `3`), baseados em uma `ENUM` de banco de dados. No entanto, o Frontend estava enviando strings (ex: `"active"`, `"pending"`) que não eram reconhecidas pela camada de persistência.

---

### 🛠️ Resolução e Valor Agregado
Ao analisar a documentação técnica da demanda e o contrato da API, confirmei que:
1.  A estrutura do Banco de Dados estava correta e seguia o padrão de arquitetura definido.
2.  O Frontend estava implementado com uma lógica divergente do contrato de dados.

**Ação tomada:**
Documentei o bug detalhando a causa raiz, apontando exatamente a divergência de tipos entre as camadas. Essa investigação técnica profunda evitou que o time de desenvolvimento perdesse tempo tentando "adivinhar" o erro, acelerando a correção e garantindo a janela de lançamento.

### ✅ Lição Aprendida
Qualidade sistêmica exige entender o **Contrato de Dados**. Ser capaz de abrir o banco de dados e validar se a estrutura do código reflete a realidade da persistência é o que diferencia o teste superficial da engenharia de qualidade sênior.
