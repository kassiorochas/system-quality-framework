-- :money_with_wings: AUDITORIA DE INTEGRIDADE FINANCEIRA
-- Objetivo: Validar se o balanço calculado no banco coincide com as transações de entrada e saída.

SELECT 
    data_referencia AS 'Dia',
    SUM(valor_entrada) AS 'Total Entradas',
    SUM(valor_saida) AS 'Total Saídas',
    (SUM(valor_entrada) - SUM(valor_saida)) AS 'Balanço Final'
FROM (
    -- Subconsulta: Buscar todos os saques aprovados no período
    SELECT 
        DATE(event_timestamp) AS data_referencia,
        amount_value AS valor_saida,
        0 AS valor_entrada
    FROM ledger_payout_records
    WHERE account_id = 7788 AND YEAR(event_timestamp) = 2026

    UNION ALL

    -- Subconsulta: Buscar todas as entradas confirmadas no período
    SELECT 
        DATE(event_timestamp) AS data_referencia,
        0 AS valor_saida,
        amount_value AS valor_entrada
    FROM ledger_inbound_records
    WHERE account_id = 7788 AND YEAR(event_timestamp) = 2026
) AS consolidated_ledger
GROUP BY data_referencia
ORDER BY data_referencia DESC;

-- :mag: VALIDAÇÃO DE RELATÓRIO INDIVIDUAL
-- Garantir que os dados sumarizados na tabela de métricas batem com a conta
SELECT * FROM summary_account_metrics WHERE account_id = 7788;

-- :key: CONSULTA DE PERMISSÕES TÉCNICAS
-- Validar se o operador de sistema possui o nível de acesso correto
SELECT 
    operator.alias_name AS operador,
    perm.capability_label AS permissao,
    perm.access_level AS nivel
FROM system_operators operator
JOIN access_assignments assign ON assign.operator_id = operator.id
JOIN capabilities_catalog perm ON perm.role_id = assign.role_id
WHERE operator.id = 5544 AND perm.id = 900;
