# ⚡ Quick Deploy Reference

## 🎯 TL;DR

1. Deploy `socket-server/` folder to **Railway** → Get URL
2. Deploy Next.js to **Vercel** → Add `NEXT_PUBLIC_WS_URL` env var
3. Done!

---

## 📦 What Files to Deploy

### Socket.IO Server → Railway
```
socket-server/
├── index.js
├── package.json
└── (other config files)
```

### Next.js App → Vercel
```
Your entire Next.js project
+ Environment variable: NEXT_PUBLIC_WS_URL
```

---

## 🚀 Railway Deployment (5 minutes)

1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your repo
5. Set root directory: `socket-server`
6. Railway auto-deploys!
7. Go to Settings → Generate Domain
8. Copy your URL: `https://xxx.up.railway.app`

---

## 🌐 Vercel Deployment (3 minutes)

1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. Import your repository
4. Go to Settings → Environment Variables
5. Add:
   - Name: `NEXT_PUBLIC_WS_URL`
   - Value: `https://xxx.up.railway.app` (from Railway)
6. Redeploy

---

## ✅ Test It

```bash
# Test Socket.IO server
curl https://xxx.up.railway.app
# Should return JSON with "status": "ok"

# Test Next.js app
# Visit your Vercel URL
# Open console (F12)
# Should see: "Socket.IO connected"
```

---

## 🔧 If Something Breaks

### Can't connect to Socket.IO?
- Check Railway URL is correct
- Verify `NEXT_PUBLIC_WS_URL` in Vercel
- Redeploy Vercel after adding env var

### Railway deployment failed?
- Check `socket-server/package.json` exists
- Verify `start` script is defined
- Check Railway logs for errors

### Vercel deployment failed?
- Check if Next.js builds locally: `npm run build`
- Verify all dependencies are in `package.json`
- Check Vercel logs for errors

---

## 💰 Cost

**Free Tier:**
- Railway: $5/month credit (free)
- Vercel: Free for personal projects
- **Total: $0/month**

---

## 📚 More Help

- Full guide: `DEPLOY-GUIDE.md`
- Platform details: `socket-server/DEPLOY.md`
- Troubleshooting: `DEBUG-REALTIME.md`

---

## 🎉 That's It!

Your portfolio with real-time chat is now live on the internet!
