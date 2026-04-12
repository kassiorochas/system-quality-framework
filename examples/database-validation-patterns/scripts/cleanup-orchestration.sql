####################################
##### DATA RESET & USER CLEANUP #####
####################################

-- :brain: Definir ID do usuário alvo para o reset
SET @target_account_id = 5544; 

-- :lock: Desativar verificação de chave estrangeira para garantir a limpeza de tabelas relacionadas
SET FOREIGN_KEY_CHECKS = 0;

-- :clipboard: HISTÓRICO DE SESSÃO E ACESSOS
DELETE FROM account_access_logs WHERE account_id = @target_account_id;
DELETE FROM account_activity_audit WHERE account_id = @target_account_id;
DELETE FROM session_tracking_data WHERE account_id = @target_account_id;
DELETE FROM lifecycle_status_history WHERE account_id = @target_account_id;

-- :standing_person: DADOS CADASTRAIS E DOCUMENTAÇÃO
DELETE FROM profile_personal_info WHERE account_id = @target_account_id;
DELETE FROM profile_address_data WHERE account_id = @target_account_id;
DELETE FROM financial_risk_profile WHERE account_id = @target_account_id;
DELETE FROM compliance_consent_log WHERE account_id = @target_account_id;

-- :moneybag: LIVRO CAIXA E TRANSAÇÕES (Ledger)
DELETE FROM ledger_transaction_entries WHERE account_id = @target_account_id;
DELETE FROM wallet_snapshot_balance WHERE account_id = @target_account_id;
DELETE FROM inbound_payment_history WHERE account_id = @target_account_id;
DELETE FROM outbound_payout_history WHERE account_id = @target_account_id;

-- :gift: CAMPANHAS E FIDELIDADE
DELETE FROM campaign_user_mapping WHERE account_id = @target_account_id;
DELETE FROM reward_progress_tracker WHERE account_id = @target_account_id;

-- :bar_chart: MÉTRICAS E ANALYTICS
DELETE FROM analytics_user_engagement WHERE account_id = @target_account_id;
DELETE FROM summary_financial_reports WHERE account_id = @target_account_id;

-- :receipt: INTEGRAÇÕES EXTERNAS (KYC/AML)
DELETE FROM ext_provider_background_sync WHERE doc_reference = '12345678901';
DELETE FROM ext_identity_verification_audit WHERE doc_reference = '12345678901';

-- :loudspeaker: FINALIZAÇÃO
-- Reativar as verificações de integridade
SET FOREIGN_KEY_CHECKS = 1;

-- Validar se a limpeza foi concluída
SELECT 'Cleanup finalizado para a conta: ' as status, @target_account_id as account;
