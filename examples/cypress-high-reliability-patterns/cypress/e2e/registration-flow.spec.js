/**
 * Blueprint: Fluxo de Registro com Alta Confiabilidade
 * Demonstra padrões de: DB Cleanup, Geolocation Stubbing e Estabilidade de Elementos.
 */

describe('Fluxo de Cadastro E2E (Sanitized)', () => {
  const testUserData = {
    cpf: '12345678901',
    email: 'qa_test@example.com',
    password: 'Password123'
  };

  // 1. Limpeza de ambiente e massa antes do teste
  before(() => {
    // Consulta o banco para garantir que o usuário de teste está limpo
    cy.task('dbQuery', {
      query: `SELECT user_id FROM users WHERE doc = '${testUserData.cpf}'`
    }).then((result) => {
      if (result && result.length > 0) {
        cy.log('Usuário já existe. Executando comando de limpeza...');
        cy.cleanupUser(result[0].user_id);
      }
    });
  });

  beforeEach(() => {
    // 2. Interceptação de APIs para validação de contrato e performance
    cy.intercept('POST', '**/api/v1/register').as('registerRequest');

    // 3. Stub de Geolocalização antes de carregar a página
    cy.visit('/', {
      onBeforeLoad(win) {
        cy.stub(win.navigator.geolocation, 'getCurrentPosition').callsFake((success) => {
          success({ coords: { latitude: -23.5505, longitude: -46.6333 } });
        });
      }
    });

    // 4. Injeção de estado no LocalStorage para pular modais de consentimento
    cy.window().then((win) => {
      win.localStorage.setItem('cookie_consent', 'true');
      win.localStorage.setItem('onboarding_seen', 'true');
    });
  });

  it('Deve preencher o formulário de registro lidando com DOM instável', () => {
    // Abrir modal de cadastro
    cy.contains('button', /registre-se/i).click();

    // 5. Llidando com "Detached DOM": garantindo que o elemento está pronto
    // Usamos um timeout estendido e verificações múltiplas encadeadas
    cy.get('input[name="cpf"]', { timeout: 10000 })
      .should('be.visible')
      .and('not.be.disabled')
      .type(testUserData.cpf);

    cy.get('input[name="email"]').type(testUserData.email);
    cy.get('input[name="password"]').type(testUserData.password);

    // 6. Cliques robustos: se o checkbox for um componente complexo (ex: React)
    // Clicamos no container pai para garantir que o evento KR (Key-Value) se propague
    cy.get('input[type="checkbox"]').parent().click();

    // Finalizar o cadastro
    cy.contains('button', /finalizar/i).should('not.be.disabled').click();

    // 7. Validação de rede (XHR) em vez de apenas visual
    cy.wait('@registerRequest').its('response.statusCode').should('eq', 201);
  });
});
