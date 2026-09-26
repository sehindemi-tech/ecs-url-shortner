<script setup lang="ts">
import { ref, onMounted } from 'vue'

const DASHBOARD_URL = import.meta.env.VITE_DASHBOARD_URL || 'http://localhost:8081'

interface Summary {
  total_urls: number
  total_clicks: number
  clicks_today: number
}

interface TopURL {
  short_code: string
  url: string
  clicks: number
}

interface RecentClick {
  short_code: string
  ip: string
  user_agent: string
  clicked_at: string
}

const summary = ref<Summary | null>(null)
const topUrls = ref<TopURL[]>([])
const recentClicks = ref<RecentClick[]>([])
const loading = ref(true)
const error = ref('')

async function fetchAll() {
  loading.value = true
  error.value = ''
  try {
    const [s, t, r] = await Promise.all([
      fetch(`${DASHBOARD_URL}/summary`),
      fetch(`${DASHBOARD_URL}/top`),
      fetch(`${DASHBOARD_URL}/recent`),
    ])
    summary.value = await s.json()
    topUrls.value = await t.json()
    recentClicks.value = await r.json()
  } catch {
    error.value = 'Failed to load dashboard — check the dashboard service is running'
  } finally {
    loading.value = false
  }
}

function truncate(str: string, n: number) {
  return str.length > n ? str.slice(0, n) + '…' : str
}

function formatDate(ts: string) {
  return new Date(ts).toLocaleString('en-GB', {
    day: '2-digit', month: 'short', year: 'numeric',
    hour: '2-digit', minute: '2-digit',
  })
}

onMounted(fetchAll)
</script>

<template>
  <div class="dashboard">

    <div class="page-header">
      <div>
        <h1 class="page-title">Analytics Dashboard</h1>
        <p class="page-sub">Real-time click tracking powered by Sehindemi-Tech</p>
      </div>
      <button @click="fetchAll" class="btn-refresh" :disabled="loading">
        <span v-if="loading" class="spinner-sm"></span>
        <span v-else>Refresh</span>
      </button>
    </div>

    <div v-if="error" class="error-banner">{{ error }}</div>

    <div v-if="summary" class="stats-grid">
      <div class="stat-card">
        <div class="stat-value">{{ summary.total_urls.toLocaleString() }}</div>
        <div class="stat-label">Total URLs</div>
      </div>
      <div class="stat-card accent-card">
        <div class="stat-value">{{ summary.total_clicks.toLocaleString() }}</div>
        <div class="stat-label">Total Clicks</div>
      </div>
      <div class="stat-card">
        <div class="stat-value">{{ summary.clicks_today.toLocaleString() }}</div>
        <div class="stat-label">Clicks Today</div>
      </div>
    </div>

    <div class="skeleton-grid" v-if="loading && !summary">
      <div class="skeleton-card" v-for="i in 3" :key="i"></div>
    </div>

    <div class="section">
      <div class="section-header">
        <h2 class="section-title">Top URLs</h2>
        <span class="section-meta">Top 10 by click count</span>
      </div>
      <div class="table-card">
        <div v-if="loading && topUrls.length === 0" class="table-loading">
          <div class="skeleton-row" v-for="i in 5" :key="i"></div>
        </div>
        <div v-else-if="topUrls.length === 0" class="empty-state">
          <div class="empty-text">No URLs shortened yet</div>
          <div class="empty-sub">Head to the Shorten tab to get started</div>
        </div>
        <table v-else class="data-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Short Code</th>
              <th>Destination URL</th>
              <th>Clicks</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, i) in topUrls" :key="item.short_code">
              <td class="rank-cell">{{ i + 1 }}</td>
              <td>
                <a :href="`/${item.short_code}`" target="_blank" class="code-link">
                  {{ item.short_code }}
                </a>
              </td>
              <td class="url-cell" :title="item.url">{{ truncate(item.url, 55) }}</td>
              <td>
                <span class="click-badge">{{ item.clicks.toLocaleString() }}</span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <div class="section">
      <div class="section-header">
        <h2 class="section-title">Recent Clicks</h2>
        <span class="section-meta">Last 50 events</span>
      </div>
      <div class="table-card">
        <div v-if="loading && recentClicks.length === 0" class="table-loading">
          <div class="skeleton-row" v-for="i in 5" :key="i"></div>
        </div>
        <div v-else-if="recentClicks.length === 0" class="empty-state">
          <div class="empty-text">No clicks recorded yet</div>
          <div class="empty-sub">Clicks appear here after the worker processes SQS events</div>
        </div>
        <table v-else class="data-table">
          <thead>
            <tr>
              <th>Short Code</th>
              <th>IP Address</th>
              <th>Time</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(click, i) in recentClicks" :key="i">
              <td>
                <a :href="`/${click.short_code}`" target="_blank" class="code-link">
                  {{ click.short_code }}
                </a>
              </td>
              <td class="ip-cell">{{ click.ip }}</td>
              <td class="time-cell">{{ formatDate(click.clicked_at) }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</template>

<style scoped>
.dashboard {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding-top: 1.5rem;
}

.page-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
}

.page-title {
  font-size: 1.75rem;
  font-weight: 800;
  letter-spacing: -0.02em;
  color: var(--text-primary);
}

.page-sub {
  font-size: 0.875rem;
  color: var(--text-muted);
  margin-top: 0.25rem;
}

.btn-refresh {
  display: flex;
  align-items: center;
  gap: 0.4rem;
  background-color: var(--bg-card);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
  border-radius: 8px;
  padding: 0.5rem 1.1rem;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-refresh:hover:not(:disabled) {
  background-color: var(--bg-hover);
  border-color: var(--accent);
}

.btn-refresh:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.spinner-sm {
  width: 14px;
  height: 14px;
  border: 2px solid rgba(255,255,255,0.2);
  border-top-color: var(--text-primary);
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.error-banner {
  padding: 0.75rem 1rem;
  background-color: rgba(248, 113, 113, 0.08);
  border: 1px solid rgba(248, 113, 113, 0.2);
  border-radius: 10px;
  color: var(--danger);
  font-size: 0.875rem;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.stat-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  transition: border-color 0.2s;
}

.stat-card:hover {
  border-color: var(--border-light);
}

.accent-card {
  border-color: rgba(99, 102, 241, 0.3);
  background: linear-gradient(135deg, var(--bg-card), rgba(99, 102, 241, 0.05));
}

.stat-value {
  font-size: 2rem;
  font-weight: 800;
  color: var(--accent-hover);
  letter-spacing: -0.03em;
  line-height: 1;
}

.stat-label {
  font-size: 0.8rem;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.06em;
  font-weight: 500;
}

.skeleton-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.skeleton-card {
  height: 100px;
  border-radius: 14px;
  background: linear-gradient(90deg, var(--bg-card) 25%, var(--bg-hover) 50%, var(--bg-card) 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
}

@keyframes shimmer {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

.section {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.section-title {
  font-size: 1rem;
  font-weight: 700;
  color: var(--text-primary);
}

.section-meta {
  font-size: 0.78rem;
  color: var(--text-muted);
}

.table-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 14px;
  overflow: hidden;
}

.table-loading {
  padding: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.skeleton-row {
  height: 36px;
  border-radius: 6px;
  background: linear-gradient(90deg, var(--bg-hover) 25%, var(--bg-secondary) 50%, var(--bg-hover) 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s infinite;
}

.empty-state {
  padding: 3rem 2rem;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.empty-text {
  font-size: 0.95rem;
  font-weight: 600;
  color: var(--text-secondary);
}

.empty-sub {
  font-size: 0.82rem;
  color: var(--text-muted);
}

.data-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.875rem;
}

.data-table th {
  background-color: var(--bg-secondary);
  color: var(--text-muted);
  font-weight: 600;
  text-align: left;
  padding: 0.7rem 1rem;
  border-bottom: 1px solid var(--border);
  text-transform: uppercase;
  font-size: 0.75rem;
  letter-spacing: 0.06em;
}

.data-table td {
  padding: 0.75rem 1rem;
  border-bottom: 1px solid var(--bg-hover);
  color: var(--text-primary);
  vertical-align: middle;
}

.data-table tr:last-child td {
  border-bottom: none;
}

.data-table tbody tr:hover td {
  background-color: var(--bg-hover);
}

.rank-cell {
  color: var(--text-muted);
  font-weight: 600;
  font-size: 0.8rem;
  width: 40px;
}

.code-link {
  color: var(--accent-hover);
  text-decoration: none;
  font-family: 'SFMono-Regular', Consolas, monospace;
  font-size: 0.85rem;
  font-weight: 600;
  background-color: var(--accent-dim);
  padding: 0.2rem 0.5rem;
  border-radius: 5px;
}

.code-link:hover {
  text-decoration: underline;
}

.url-cell {
  color: var(--text-muted);
  font-size: 0.82rem;
  max-width: 380px;
}

.click-badge {
  display: inline-block;
  background-color: rgba(99, 102, 241, 0.12);
  color: var(--accent-hover);
  font-weight: 700;
  font-size: 0.85rem;
  padding: 0.2rem 0.6rem;
  border-radius: 6px;
}

.ip-cell {
  font-family: monospace;
  font-size: 0.82rem;
  color: var(--text-muted);
}

.time-cell {
  font-size: 0.82rem;
  color: var(--text-muted);
  white-space: nowrap;
}
</style>
