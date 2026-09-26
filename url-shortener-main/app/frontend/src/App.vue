<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="app">
    <nav class="navbar">
      <div class="navbar-left">
        <div class="navbar-brand">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M13.5 3L5 13.5H12L10.5 21L19 10.5H12L13.5 3Z" fill="#6366f1" stroke="#818cf8" stroke-width="1.5" stroke-linejoin="round"/>
          </svg>
          <div class="brand-text">
            <span class="brand-product">Sehindemi-Tech-Shortner</span>
          </div>
        </div>
      </div>
      <div class="navbar-links">
        <RouterLink to="/" class="nav-link">Shorten</RouterLink>
        <RouterLink to="/dashboard" class="nav-link">Dashboard</RouterLink>
      </div>
      <div class="navbar-right">
        <span class="status-badge">
          <span class="status-dot"></span>
          Live
        </span>
      </div>
    </nav>

    <main class="main-content">
      <RouterView />
    </main>

    <footer class="footer">
      <div class="footer-inner">
        <span class="footer-brand">Sehindemi-Tech</span>
        <span class="footer-sep">·</span>
        <span class="footer-text">URL Shortener Platform</span>
        <span class="footer-sep">·</span>
        <span class="footer-text">Deployed on AWS ECS Fargate</span>
      </div>
    </footer>
  </div>
</template>

<style>
*, *::before, *::after {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  --bg-primary: #0a0c14;
  --bg-secondary: #111320;
  --bg-card: #161929;
  --bg-hover: #1c1f35;
  --border: #252840;
  --border-light: #2d3155;
  --accent: #6366f1;
  --accent-hover: #818cf8;
  --accent-dim: #1e2140;
  --text-primary: #f1f5f9;
  --text-secondary: #94a3b8;
  --text-muted: #475569;
  --success: #10b981;
  --danger: #f87171;
}

body {
  background-color: var(--bg-primary);
  color: var(--text-primary);
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Inter', sans-serif;
  min-height: 100vh;
  line-height: 1.6;
}

.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 2rem;
  height: 64px;
  background-color: var(--bg-secondary);
  border-bottom: 1px solid var(--border);
  position: sticky;
  top: 0;
  z-index: 100;
  backdrop-filter: blur(12px);
}

.navbar-left {
  display: flex;
  align-items: center;
}

.navbar-brand {
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

.brand-text {
  display: flex;
  align-items: baseline;
}

.brand-product {
  font-size: 1rem;
  font-weight: 700;
  color: var(--text-primary);
  letter-spacing: -0.02em;
}

.navbar-links {
  display: flex;
  gap: 0.5rem;
}

.nav-link {
  display: flex;
  align-items: center;
  color: var(--text-secondary);
  text-decoration: none;
  font-size: 0.875rem;
  font-weight: 500;
  padding: 0.45rem 0.9rem;
  border-radius: 8px;
  transition: all 0.15s ease;
}

.nav-link:hover {
  color: var(--text-primary);
  background-color: var(--bg-hover);
}

.nav-link.router-link-active {
  color: var(--accent-hover);
  background-color: var(--accent-dim);
}

.navbar-right {
  display: flex;
  align-items: center;
}

.status-badge {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  font-size: 0.75rem;
  color: var(--success);
  background-color: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.2);
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-weight: 500;
}

.status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background-color: var(--success);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}

.main-content {
  flex: 1;
  width: 100%;
  max-width: 960px;
  margin: 0 auto;
  padding: 2.5rem 2rem;
}

.footer {
  border-top: 1px solid var(--border);
  background-color: var(--bg-secondary);
  padding: 1rem 2rem;
}

.footer-inner {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  font-size: 0.8rem;
}

.footer-brand {
  color: var(--accent-hover);
  font-weight: 600;
}

.footer-sep {
  color: var(--text-muted);
}

.footer-text {
  color: var(--text-muted);
}
</style>
