/**
 * Blueprint: Commands.js (Sanitized)
 * Comandos customizados para abstração de complexidade.
 */

/**
 * Comando para realizar a limpeza de um usuário de teste.
 * Abstrai a chamada de API/DB necessária para resetar o cenário.
 */
Cypress.Commands.add('cleanupUser', (userId) => {
  cy.log(`Limpando rastro do usuário ID: ${userId}`);

  // Exemplo de chamada de API de suporte/admin para deleção
  // Nota: Em um ambiente real, isso usaria tokens de service-account protegidos
  cy.request({
    method: 'DELETE',
    url: `/api/internal/test-cleanup/users/${userId}`,
    failOnStatusCode: false // Evita quebrar o teste se o usuário já tiver sido removido
  }).then((response) => {
    if (response.status === 200) {
      cy.log('Usuário removido com sucesso.');
    } else {
      cy.log('Usuário não encontrado ou erro na deleção. Prosseguindo...');
    }
  });
});

/**
 * Utilitário para lidar com Popups de terceiros (ex: Chat, Suporte)
 * que podem surgir durante o teste e bloquear elementos.
 */
Cypress.Commands.add('closeAllPopups', () => {
  cy.get('body').then(($body) => {
    const selectors = ['.modal-close', '.btn-close', '[aria-label="close"]'];
    selectors.forEach((dotSelector) => {
      if ($body.find(dotSelector).length > 0) {
        cy.get(dotSelector).each(($btn) => {
          cy.wrap($btn).click({ force: true });
        });
      }
    });
  });
});
