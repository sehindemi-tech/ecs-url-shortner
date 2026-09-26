<script setup lang="ts">
import { ref } from 'vue'

const inputUrl = ref('')
const result = ref<{ short: string; short_url: string } | null>(null)
const error = ref('')
const loading = ref(false)
const copied = ref(false)

async function shorten() {
  if (!inputUrl.value.trim()) {
    error.value = 'Please enter a URL'
    return
  }

  error.value = ''
  result.value = null
  loading.value = true

  try {
    const res = await fetch('/shorten', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ url: inputUrl.value.trim() }),
    })

    if (!res.ok) {
      const data = await res.json()
      error.value = data.detail || 'Something went wrong'
      return
    }

    result.value = await res.json()
  } catch {
    error.value = 'Failed to connect to the API'
  } finally {
    loading.value = false
  }
}

async function copy() {
  if (!result.value?.short_url) return
  await navigator.clipboard.writeText(result.value.short_url)
  copied.value = true
  setTimeout(() => (copied.value = false), 2000)
}

function reset() {
  inputUrl.value = ''
  result.value = null
  error.value = ''
}
</script>

<template>
  <div class="shortener">

    <div class="hero">
      <div class="hero-badge">URL Shortener · Sehindemi-Tech</div>
      <h1 class="hero-title">Shorten. Share. <span class="accent">Track.</span></h1>
      <p class="hero-subtitle">
        Transform long URLs into clean, trackable short links — powered by Sehindemi-Tech infrastructure on AWS.
      </p>
    </div>

    <div class="card main-card">
      <label class="field-label">Paste your long URL</label>
      <div class="input-row">
        <div class="input-wrapper">
          <input
            v-model="inputUrl"
            type="url"
            placeholder="https://example.com/very/long/path/to/something"
            class="url-input"
            @keyup.enter="shorten"
            :disabled="loading"
          />
        </div>
        <button @click="shorten" class="btn btn-primary" :disabled="loading">
          <span v-if="loading" class="spinner"></span>
          <span v-else>Shorten</span>
        </button>
      </div>

      <p v-if="error" class="error-msg">{{ error }}</p>

      <Transition name="slide">
        <div v-if="result" class="result-box">
          <div class="result-header">
            <span class="result-badge">Ready to share</span>
          </div>
          <div class="result-url-row">
            <a :href="result.short_url" target="_blank" class="result-url">
              {{ result.short_url }}
            </a>
            <button @click="copy" class="btn btn-copy" :class="{ copied }">
              {{ copied ? 'Copied' : 'Copy' }}
            </button>
          </div>
          <div class="result-meta">
            Short code: <code class="code">{{ result.short }}</code>
            · <a :href="`/stats/${result.short}`" target="_blank" class="stats-link">View stats</a>
          </div>
          <button @click="reset" class="reset-link">Shorten another URL</button>
        </div>
      </Transition>
    </div>

    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-title">Instant</div>
        <div class="feature-desc">Short links generated in milliseconds with Redis caching</div>
      </div>
      <div class="feature-card">
        <div class="feature-title">Analytics</div>
        <div class="feature-desc">Track clicks, traffic sources, and hourly breakdowns</div>
      </div>
      <div class="feature-card">
        <div class="feature-title">Secure</div>
        <div class="feature-desc">Hosted on AWS ECS Fargate in private subnets with WAF protection</div>
      </div>
    </div>

  </div>
</template>

<style scoped>
.shortener {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding-top: 2rem;
}

.hero {
  text-align: center;
  padding: 1.5rem 0;
}

.hero-badge {
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 600;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--accent-hover);
  background-color: var(--accent-dim);
  border: 1px solid var(--border-light);
  padding: 0.3rem 0.9rem;
  border-radius: 20px;
  margin-bottom: 1rem;
}

.hero-title {
  font-size: 2.6rem;
  font-weight: 800;
  letter-spacing: -0.03em;
  color: var(--text-primary);
  margin-bottom: 0.75rem;
  line-height: 1.2;
}

.accent {
  color: var(--accent-hover);
}

.hero-subtitle {
  color: var(--text-secondary);
  font-size: 1rem;
  max-width: 520px;
  margin: 0 auto;
  line-height: 1.7;
}

.main-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 2rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.field-label {
  font-size: 0.85rem;
  font-weight: 500;
  color: var(--text-secondary);
}

.input-row {
  display: flex;
  gap: 0.75rem;
}

.input-wrapper {
  flex: 1;
}

.url-input {
  width: 100%;
  background-color: var(--bg-primary);
  border: 1px solid var(--border-light);
  border-radius: 10px;
  padding: 0.8rem 1rem;
  color: var(--text-primary);
  font-size: 0.95rem;
  outline: none;
  transition: border-color 0.2s, box-shadow 0.2s;
}

.url-input:focus {
  border-color: var(--accent);
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
}

.url-input::placeholder {
  color: var(--text-muted);
}

.url-input:disabled {
  opacity: 0.6;
}

.btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  padding: 0.8rem 1.6rem;
  border-radius: 10px;
  font-size: 0.9rem;
  font-weight: 600;
  cursor: pointer;
  border: none;
  transition: all 0.2s;
  white-space: nowrap;
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.btn-primary {
  background: linear-gradient(135deg, var(--accent), #818cf8);
  color: #fff;
  min-width: 120px;
}

.btn-primary:hover:not(:disabled) {
  opacity: 0.9;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(99, 102, 241, 0.35);
}

.spinner {
  width: 16px;
  height: 16px;
  border: 2px solid rgba(255,255,255,0.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.7s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.error-msg {
  color: var(--danger);
  font-size: 0.875rem;
  padding: 0.6rem 0.9rem;
  background-color: rgba(248, 113, 113, 0.08);
  border: 1px solid rgba(248, 113, 113, 0.2);
  border-radius: 8px;
}

.result-box {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 1.25rem;
  background-color: var(--bg-primary);
  border: 1px solid rgba(99, 102, 241, 0.3);
  border-radius: 12px;
}

.result-header {
  display: flex;
  align-items: center;
}

.result-badge {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--success);
  background-color: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.2);
  padding: 0.2rem 0.7rem;
  border-radius: 20px;
}

.result-url-row {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.result-url {
  flex: 1;
  color: var(--accent-hover);
  font-size: 1.05rem;
  font-weight: 600;
  text-decoration: none;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.result-url:hover {
  text-decoration: underline;
}

.btn-copy {
  background-color: var(--bg-hover);
  color: var(--text-primary);
  border: 1px solid var(--border-light);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.85rem;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-copy.copied {
  color: var(--success);
  border-color: rgba(16, 185, 129, 0.3);
  background-color: rgba(16, 185, 129, 0.08);
}

.result-meta {
  font-size: 0.82rem;
  color: var(--text-muted);
}

.code {
  background-color: var(--bg-hover);
  padding: 0.1rem 0.4rem;
  border-radius: 4px;
  font-family: monospace;
  color: var(--text-secondary);
}

.stats-link {
  color: var(--accent-hover);
  text-decoration: none;
}

.stats-link:hover {
  text-decoration: underline;
}

.reset-link {
  background: none;
  border: none;
  color: var(--text-muted);
  font-size: 0.82rem;
  cursor: pointer;
  padding: 0;
  text-align: left;
  transition: color 0.2s;
}

.reset-link:hover {
  color: var(--text-secondary);
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.feature-card {
  background-color: var(--bg-card);
  border: 1px solid var(--border);
  border-radius: 12px;
  padding: 1.25rem;
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  transition: border-color 0.2s;
}

.feature-card:hover {
  border-color: var(--border-light);
}

.feature-title {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-primary);
}

.feature-desc {
  font-size: 0.8rem;
  color: var(--text-muted);
  line-height: 1.5;
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.25s ease;
}

.slide-enter-from,
.slide-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}
</style>
