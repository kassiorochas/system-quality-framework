-- :money_with_wings: AUDITORIA DE INTEGRIDADE FINANCEIRA
-- Objetivo: Validar se o balanço calculado no banco coincide com as transações de depósito e saque.

SELECT 
    data_referencia AS 'Dia',
    SUM(valor_deposito) AS 'Total Depósitos',
    SUM(valor_saque) AS 'Total Saques',
    (SUM(valor_deposito) - SUM(valor_saque)) AS 'Balanço Final'
FROM (
    -- Subconsulta: Buscar todos os saques aprovados no período
    SELECT 
        DATE(reference_day) AS data_referencia,
        amount AS valor_saque,
        0 AS valor_deposito
    FROM payment_withdraw
    WHERE user_id = 2186 AND YEAR(reference_day) = 2026

    UNION ALL

    -- Subconsulta: Buscar todos os depósitos confirmados no período
    SELECT 
        DATE(reference_day) AS data_referencia,
        0 AS valor_saque,
        amount AS valor_deposito
    FROM payment_deposit
    WHERE user_id = 2186 AND YEAR(reference_day) = 2026
) AS transacoes_unificadas
GROUP BY data_referencia
ORDER BY data_referencia DESC;

-- :mag: VALIDAÇÃO DE RELATÓRIO INDIVIDUAL
-- Garantir que os dados sumarizados na tabela de reports batem com o usuário
SELECT * FROM report_income_summary WHERE user_id = 2243;

-- :key: CONSULTA DE PERMISSÕES TÉCNICAS
-- Validar se o colaborador possui o nível de acesso correto para visualizar dados financeiros
SELECT 
    c.username AS colaborador,
    p.permission_name AS permissao,
    p.access_level AS nivel
FROM users_admin c
JOIN roles_assignment ra ON ra.admin_id = c.id
JOIN permissions p ON p.role_id = ra.role_id
WHERE c.id = 1171 AND p.id = 800;
