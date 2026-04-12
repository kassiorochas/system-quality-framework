-- :arrows_counterclockwise: MANIPULAÇÃO DE ESTADOS PARA TESTES DE SEGURANÇA
-- Objetivo: Forçar a conta a entrar em estados de restrição para validar o comportamento do Frontend.

-- 1. Forçar Bloqueio por Conformidade (Ex: Restrição de Acesso)
UPDATE compliance_audit_status SET access_state = 'RESTRICTED' WHERE identity_token = '99988877766';

-- 2. Inserir Log de Auditoria para simular histórico de segurança
-- Isso garante que o sistema de retaguarda (Backoffice) consiga ler o motivo do bloqueio
INSERT INTO compliance_event_ledger (
    identity_token,
    logged_at,
    sync_at,
    access_state,
    provider_response,
    is_verified,
    block_reason
) VALUES (
    '99988877766',
    '2025-10-15 10:00:00',
    '2025-10-15 10:05:00',
    'RESTRICTED',
    'FAIL_COMPLIANCE',
    1,
    'USER_REQUESTED_BLOCK'
);

-- 3. Validação de Join para Auditoria de Perfil Técnico
-- Garantir que a restrição de segurança reflete corretamente nos dados do perfil
SELECT 
    info.identity_token AS documento,
    acc.id AS account_id,
    acc.account_state AS status_geral,
    audit.access_state AS status_seguranca,
    acc.last_access_timestamp AS ultimo_acesso
FROM profile_identity_info info
LEFT JOIN platform_accounts acc ON acc.id = info.account_id
LEFT JOIN compliance_audit_status audit ON audit.identity_token = info.identity_token
WHERE info.identity_token IN ('99988877766')
ORDER BY acc.updated_at DESC;
