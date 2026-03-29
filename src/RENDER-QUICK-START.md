# ⚡ Render Quick Start

## 🎯 Deploy in 5 Minutes

### Step 1: Create Render Account (1 min)
1. Go to [render.com](https://render.com)
2. Click "Get Started"
3. Sign up with GitHub

### Step 2: Deploy Socket Server (2 min)
1. Click "New +" → "Web Service"
2. Connect repository: **socketserver**
3. Fill in:
   ```
   Name: portfolio-socket-server
   Runtime: Node
   Build Command: npm install
   Start Command: npm start
   Instance Type: Free
   ```
4. Click "Create Web Service"
5. Wait 2-3 minutes for deployment

### Step 3: Get Your URL (30 sec)
Copy your Render URL:
```
https://portfolio-socket-server.onrender.com
```

### Step 4: Test It (30 sec)
```bash
curl https://portfolio-socket-server.onrender.com
# Should return: {"status":"ok",...}
```

### Step 5: Deploy to Vercel (1 min)
1. Update `.env.local`:
   ```
   NEXT_PUBLIC_WS_URL=https://portfolio-socket-server.onrender.com
   ```
2. Go to [vercel.com](https://vercel.com)
3. Import your portfolio repo
4. Add environment variable: `NEXT_PUBLIC_WS_URL`
5. Deploy!

---

## ✅ Done!

Your real-time chat is now live!

**Full guide:** `RENDER-DEPLOYMENT.md`

---

## ⚠️ Important: Free Tier Sleep Mode

Render free tier sleeps after 15 minutes of inactivity.

**What this means:**
- First request after sleep: ~30 seconds to wake up
- Subsequent requests: Instant
- Fine for personal projects!

**To prevent sleep:**
- Upgrade to Starter ($7/month), OR
- Use [UptimeRobot](https://uptimerobot.com) to ping every 5 minutes (free)

---

## 🔗 Quick Links

- **Render Dashboard:** https://dashboard.render.com
- **Vercel Dashboard:** https://vercel.com/dashboard
- **Your Socket Server:** https://github.com/jubinkhatriiiiiiiiii/socketserver

---

## 📝 Environment Variables

**Render:**
```
CLIENT_URL=https://your-custom-domain.com
```

**Vercel:**
```
NEXT_PUBLIC_WS_URL=https://portfolio-socket-server.onrender.com
```

---

## 🆘 Troubleshooting

**503 Error?** → Server is waking up, wait 30 seconds

**Can't connect?** → Check `NEXT_PUBLIC_WS_URL` in Vercel

**CORS error?** → Set `CLIENT_URL` in Render

**Full troubleshooting:** See `RENDER-DEPLOYMENT.md`
