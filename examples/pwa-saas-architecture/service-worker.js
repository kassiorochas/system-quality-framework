/**
 * Blueprint Service Worker: Professional PWA Hybrid Strategy
 * Combinando 'Cache First' para Assets e 'Network First' para Documentos.
 */

const CACHE_NAME = 'app-pwa-v1';
const STATIC_CACHE = 'assets-static-v1';

// Ativos que nunca mudam com frequência (UI, Fonts, Base CSS/JS)
const ASSETS_TO_CACHE = [
    './',
    './index.html',
    './style.css',
    './script.js',
    './manifest.json',
    './icon/icon-192.png',
    './icon/icon-512.png'
];

self.addEventListener('install', (event) => {
    self.skipWaiting();
    event.waitUntil(
        caches.open(STATIC_CACHE).then((cache) => cache.addAll(ASSETS_TO_CACHE))
    );
});

self.addEventListener('activate', (event) => {
    event.waitUntil(clients.claim());
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.filter((name) => name !== STATIC_CACHE).map((name) => caches.delete(name))
            );
        })
    );
});

self.addEventListener('fetch', (event) => {
    const { request } = event;
    const url = new URL(request.url);

    // 1. Ignorar requisições de API/Banco de Dados para manter consistência Real-time
    if (url.origin !== location.origin || url.pathname.includes('/api/')) {
        return;
    }

    // 2. Estratégia de Imagens: Cache First (Economia de dados no Mobile)
    if (request.destination === 'image') {
        event.respondWith(
            caches.match(request).then((cached) => {
                return cached || fetch(request).then((response) => {
                    return caches.open(STATIC_CACHE).then((cache) => {
                        cache.put(request, response.clone());
                        return response;
                    });
                });
            })
        );
        return;
    }

    // 3. Estratégia para Documentos (HTML): Network First (Sempre atualizado)
    // Com fallback automático para o cache se estiver OFFLINE.
    event.respondWith(
        fetch(request)
            .then((response) => {
                if (response.status === 200) {
                    const responseClone = response.clone();
                    caches.open(STATIC_CACHE).then((cache) => {
                        cache.put(request, responseClone);
                    });
                }
                return response;
            })
            .catch(() => {
                return caches.match(request) || caches.match('./index.html');
            })
    );
});
