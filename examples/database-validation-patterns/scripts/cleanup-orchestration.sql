####################################
##### EXCLUSÃO DE USUÁRIO (RESET) #####
####################################

-- :brain: Definir ID do usuário alvo para o reset
SET @target_user_id = 9999; 

-- :lock: Desativar verificação de chave estrangeira temporariamente para limpeza profunda
SET FOREIGN_KEY_CHECKS = 0;

-- :clipboard: LOGS DE ACESSO E SESSÃO
DELETE FROM user_access_log WHERE user_id = @target_user_id;
DELETE FROM user_action_log WHERE user_id = @target_user_id;
DELETE FROM user_session_log WHERE user_id = @target_user_id;
DELETE FROM user_status_history WHERE user_id = @target_user_id;

-- :standing_person: DADOS PESSOAIS E DOCUMENTAÇÃO
DELETE FROM user_personal_data WHERE user_id = @target_user_id;
DELETE FROM user_address WHERE user_id = @target_user_id;
DELETE FROM user_financial_profile WHERE user_id = @target_user_id;
DELETE FROM user_consent_history WHERE user_id = @target_user_id;

-- :moneybag: TRANSAÇÕES FINANCEIRAS (Audit Trail)
DELETE FROM wallet_transaction_history WHERE user_id = @target_user_id;
DELETE FROM wallet_balance_snapshot WHERE user_id = @target_user_id;
DELETE FROM payment_deposit_history WHERE user_id = @target_user_id;
DELETE FROM payment_withdraw_history WHERE user_id = @target_user_id;

-- :gift: PROMOÇÕES E BÔNUS
DELETE FROM promo_user_assignment WHERE user_id = @target_user_id;
DELETE FROM promo_rollover_progress WHERE user_id = @target_user_id;

-- :bar_chart: RELATÓRIOS E ANALYTICS
DELETE FROM report_user_engagement WHERE user_id = @target_user_id;
DELETE FROM report_financial_summary WHERE user_id = @target_user_id;

-- :loudspeaker: FINALIZAÇÃO
-- Reativar as verificações de integridade
SET FOREIGN_KEY_CHECKS = 1;

-- Validar se a limpeza foi concluída
SELECT 'Cleanup concluído para ID: ' as status, @target_user_id as id;
