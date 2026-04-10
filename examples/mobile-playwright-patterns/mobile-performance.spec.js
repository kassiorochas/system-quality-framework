/**
 * Blueprint: Playwright Mobile Testing (PWA Focused)
 * Demonstra emulação de dispositivos, geolocalização e throttling de rede.
 */

import { test, expect, devices } from '@playwright/test';

test.use({
  ...devices['iPhone 13'], // Emulando Safari no iOS
  locale: 'pt-BR',
  geolocation: { longitude: -46.633308, latitude: -23.550520 }, // São Paulo, SP
  permissions: ['geolocation'],
});

test.describe('Estratégia Mobile: UX & Resilience', () => {
  
  test('Deve validar carregamento resiliente em rede 3G instável', async ({ page }) => {
    // 1. Simulação de rede instável (Throttling)
    // Útil para testar Service Workers e estratégias de Offline em PWAs
    const client = await page.context().newCDPSession(page);
    await client.send('Network.emulateNetworkConditions', {
      offline: false,
      downloadThroughput: (750 * 1024) / 8, // ~750kbps
      uploadThroughput: (250 * 1024) / 8, // ~250kbps
      latency: 100, // 100ms
    });

    await page.goto('/');

    // 2. Validação de visibilidade de elementos críticos no Viewport Mobile
    const buyButton = page.locator('button:has-text("Comprar")');
    await expect(buyButton).toBeInViewport();
    await expect(buyButton).toBeEnabled();
  });

  test('Deve validar interações de toque (Touch gestures)', async ({ page }) => {
    await page.goto('/catalogo');

    // 3. Simulação de Tap (Toque) - Diferente de um click de mouse
    await page.tap('.product-card:first-child');
    
    // 4. Validação de Navegação Mobile (Menu Hambúrguer)
    await page.tap('#menu-mobile-btn');
    await expect(page.locator('.side-menu')).toBeVisible();
  });

  test('Métricas de Performance (Web Vitals) via Playwright', async ({ page }) => {
    // 5. Capturando métricas de performance para relatórios estratégicos
    // Isso é o que diferencia uma automação Sênior de uma Júnior.
    const performanceTiming = await page.evaluate(() => JSON.stringify(window.performance.timing));
    console.log(`Performance Metrics: ${performanceTiming}`);
    
    // Assertiva de carregamento básico
    const navigationStart = await page.evaluate(() => window.performance.timing.navigationStart);
    const loadEventEnd = await page.evaluate(() => window.performance.timing.loadEventEnd);
    const loadTime = loadEventEnd - navigationStart;
    
    console.log(`Total Load Time: ${loadTime}ms`);
    expect(loadTime).toBeLessThan(3000); // Meta de 3 segundos no mobile
  });
});
