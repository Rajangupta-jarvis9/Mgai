-- LiaAI License Keys Table
-- Run this in Supabase SQL Editor

CREATE TABLE license_keys (
  id           BIGSERIAL PRIMARY KEY,
  key          TEXT UNIQUE NOT NULL,
  plan         TEXT NOT NULL DEFAULT 'basic',  -- 'basic' | 'pro'
  email        TEXT,
  active       BOOLEAN NOT NULL DEFAULT true,
  blocked      BOOLEAN NOT NULL DEFAULT false,
  device_id    TEXT,
  expires_at   TIMESTAMPTZ,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  last_check   TIMESTAMPTZ
);

-- Index for fast key lookup (100k rows pe bhi fast)
CREATE INDEX idx_license_key ON license_keys(key);
CREATE INDEX idx_license_active ON license_keys(active, blocked);
CREATE INDEX idx_license_email ON license_keys(email);

-- Row Level Security — sirf service key se access
ALTER TABLE license_keys ENABLE ROW LEVEL SECURITY;

-- Policy: service role sab kuch kar sakta hai
CREATE POLICY "Service role full access"
  ON license_keys
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);
