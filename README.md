# LiaAI License Backend

## Deploy karne ke steps

### 1. Supabase setup (free database)
1. supabase.com pe account banao
2. New project banao
3. SQL Editor mein jao
4. `supabase_schema.sql` ka poora content paste karo aur Run karo
5. Settings → API se yeh copy karo:
   - Project URL → SUPABASE_URL
   - service_role key → SUPABASE_SERVICE_KEY

### 2. Railway deploy (free hosting)
1. railway.app pe GitHub se login karo
2. New Project → Deploy from GitHub repo
3. Variables mein yeh add karo:
   - SUPABASE_URL
   - SUPABASE_SERVICE_KEY
   - ADMIN_SECRET (koi bhi strong password)
4. Deploy ho jaayega — URL milegi jaise: https://lia-backend.up.railway.app

### 3. App mein URL set karo
`license-config.json` banao app ke assets mein:
```json
{
  "backend_url": "https://lia-backend.up.railway.app/api"
}
```

---

## Admin Commands (Postman ya curl se)

### Nayi key generate karo
```bash
curl -X POST https://YOUR-URL/api/generate \
  -H "Content-Type: application/json" \
  -H "x-admin-secret: mera-secret-password-123" \
  -d '{"plan": "pro", "expires_days": 30, "email": "user@email.com"}'
```

### Key block karo
```bash
curl -X POST https://YOUR-URL/api/revoke \
  -H "Content-Type: application/json" \
  -H "x-admin-secret: mera-secret-password-123" \
  -d '{"key": "LIA-PRO-XXXX-XXXX-XXXX"}'
```

### Stats dekho
```bash
curl https://YOUR-URL/api/stats \
  -H "x-admin-secret: mera-secret-password-123"
```

---

## Endpoints

| Method | URL | Kaam |
|--------|-----|------|
| POST | /api/generate | Nayi key banao (admin) |
| POST | /api/activate | Key activate karo (app) |
| POST | /api/check | Key verify karo (app) |
| POST | /api/revoke | Key block karo (admin) |
| GET | /api/stats | Total/active/blocked count (admin) |
