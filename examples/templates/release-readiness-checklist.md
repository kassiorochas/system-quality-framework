# Template: Release Readiness Checklist (Go/No-Go)

**Objetivo:** Este checklist serve como artefato de decisão técnica para líderes de QA durante War Rooms ou reuniões de homologação. Ele foca na prontidão sistêmica e não apenas em "passou no teste".

---

## 🏗️ 1. Cobertura E2E (Cross-Squad)
- [ ] Todos os fluxos críticos (Golden Path) foram validados entre os diferentes silos técnicos?
- [ ] Houve impacto em serviços legados? Se sim, a regressão foi concluída?
- [ ] As integrações com parceiros externos foram validadas em ambiente de homologação?

## 🧪 2. Sanidade Técnica & Automação
- [ ] A suíte de fumaça (Smoke Test) está rodando com 100% de sucesso na pipeline?
- [ ] Não existem "testes instáveis" (flakes) mascarando problemas reais?
- [ ] A validação de banco de dados (Data Integrity) confirmou que os registros estão populando conforme o contrato?

## 🔒 3. Riscos & Mitigação
- [ ] Existe um plano de Rollback testado e aprovado?
- [ ] Quais são os "Bugs Conhecidos" (Known Issues)? Eles possuem contorno (WA - Workaround) claro?
- [ ] O monitoramento (Dashboards/Alertas) está configurado para o pós-lançamento?

## 📝 4. Narrativa de Decisão
- **Status Final:** [ ] GO / [ ] NO-GO / [ ] GO COM RESSALVAS
- **Ressalvas:** Descreva aqui se houve algum item não cumprido e qual o risco aceito.

---
> **Uso Recomendado:** Este template deve ser preenchido pelo QA Lead e compartilhado com os stakeholders técnicos antes de cada deploy em produção.
