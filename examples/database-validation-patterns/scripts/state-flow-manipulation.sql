-- :arrows_counterclockwise: MANIPULAÇÃO DE ESTADOS PARA TESTES DE SEGURANÇA
-- Objetivo: Forçar o usuário a entrar em estados de restrição para validar o comportamento do Frontend.

-- 1. Forçar Bloqueio por Auto-Exclusão (Self-Exclusion)
UPDATE user_safety_check SET status = 'FORBIDDEN' WHERE document_number = '05545888462';

-- 2. Inserir Log de Auditoria para simular histórico de segurança
-- Isso garante que o sistema de Backoffice consiga ler o motivo do bloqueio
INSERT INTO user_safety_log (
    document_number,
    created_at,
    updated_at,
    status,
    response_code,
    checked,
    reason
) VALUES (
    '08333533493',
    '2025-12-29 15:49:49',
    '2025-12-26 23:40:49',
    'FORBIDDEN',
    'SUCCESS',
    1,
    'SELF_EXCLUDED'
);

-- 3. Validação de Join Complexo para Auditoria de Perfil
-- Garantir que a restrição de segurança reflete corretamente nos dados pessoais
SELECT 
    upd.document_number AS documento,
    u.id AS user_id,
    u.status AS status_geral,
    usc.status AS status_seguranca,
    u.last_login AS ultimo_login
FROM user_personal_data upd
LEFT JOIN users u ON u.id = upd.user_id
LEFT JOIN user_safety_check usc ON usc.document_number = upd.document_number
WHERE upd.document_number IN ('15690288691')
ORDER BY u.updated_at DESC;
