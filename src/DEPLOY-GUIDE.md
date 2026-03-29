# 🚀 Complete Deployment Guide

## Overview

Your portfolio has two parts:
1. **Next.js Frontend** → Deploy to Vercel
2. **Socket.IO Server** → Deploy to Railway/Render/Fly.io (NOT Vercel)

---

## Part 1: Deploy Socket.IO Server

### Quick Deploy to Railway (Recommended)

**Why Railway?** Free tier, easy setup, no sleep mode, auto-deploys from GitHub.

#### Step-by-Step:

1. **Push socket-server to GitHub:**
   ```bash
   cd socket-server
   git init
   git add .
   git commit -m "Add Socket.IO server"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
   git push -u origin main
   ```

2. **Go to [railway.app](https://railway.app)** and sign up

3. **Create New Project:**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository
   - Select the `socket-server` directory as root

4. **Railway will auto-detect and deploy!**
   - It reads `package.json` and runs `npm start`
   - Port is automatically configured

5. **Get your URL:**
   - Click on your deployment
   - Go to "Settings" → "Domains"
   - Click "Generate Domain"
   - You'll get: `https://your-app.up.railway.app`

6. **Optional - Set Environment Variable:**
   - Go to "Variables" tab
   - Add: `CLIENT_URL` = `https://your-portfolio.vercel.app`

7. **Test it:**
   ```bash
   curl https://your-app.up.railway.app
   # Should return JSON with status: "ok"
   ```

---

## Part 2: Deploy Next.js Frontend to Vercel

1. **Update Environment Variable:**
   
   Create or update `.env.local` in your project root (not in src):
   ```env
   NEXT_PUBLIC_WS_URL=https://your-app.up.railway.app
   ```

2. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Add Socket.IO URL"
   git push
   ```

3. **Deploy to Vercel:**
   - Go to [vercel.com](https://vercel.com)
   - Import your GitHub repository
   - Vercel will auto-detect Next.js

4. **Add Environment Variable in Vercel:**
   - Go to your project settings
   - Navigate to "Environment Variables"
   - Add:
     - Name: `NEXT_PUBLIC_WS_URL`
     - Value: `https://your-app.up.railway.app`
   - Save and redeploy

5. **Your portfolio is live!**
   - URL: `https://your-portfolio.vercel.app`

---

## Part 3: Test Everything

1. **Visit your deployed portfolio**

2. **Open browser console (F12)**

3. **Look for:**
   ```
   Connecting to Socket.IO server: https://your-app.up.railway.app
   Socket.IO connected: [socket-id]
   Users updated: 1 users
   ```

4. **Open another tab/device:**
   - Should see "Users updated: 2 users"
   - Click users button (👥) to see both users
   - Test chat and cursor tracking

---

## 📋 Deployment Checklist

### Socket.IO Server (Railway)
- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] Server deployed successfully
- [ ] Domain generated
- [ ] Health check works: `curl https://your-url.com`
- [ ] Environment variables set (optional)

### Next.js Frontend (Vercel)
- [ ] Code pushed to GitHub
- [ ] Vercel project created
- [ ] Environment variable `NEXT_PUBLIC_WS_URL` added
- [ ] Deployed successfully
- [ ] Real-time features work in production

### Testing
- [ ] Can connect to Socket.IO server
- [ ] Multiple users can join
- [ ] Chat messages work
- [ ] Cursor tracking works
- [ ] No console errors

---

## 🔧 Troubleshooting

### Issue: "Cannot connect to Socket.IO server"

**Check:**
1. Is Railway server running? Visit the URL in browser
2. Is `NEXT_PUBLIC_WS_URL` set correctly in Vercel?
3. Did you redeploy Vercel after adding the env variable?
4. Check browser console for specific error messages

**Fix:**
```bash
# Test server
curl https://your-railway-url.com

# Should return:
# {"status":"ok","message":"Socket.IO server is running",...}
```

### Issue: "CORS error"

**Fix:** The server is configured to allow all origins (`origin: "*"`). For production, update `socket-server/index.js`:

```javascript
cors: {
  origin: process.env.CLIENT_URL || "https://your-portfolio.vercel.app",
  methods: ["GET", "POST"],
  credentials: true
}
```

Then set `CLIENT_URL` in Railway environment variables.

### Issue: "Users not updating"

**Check:**
1. Hard refresh browser (Ctrl+Shift+R)
2. Clear browser cache and localStorage
3. Check browser console for "Users updated" messages
4. Verify Socket.IO connection is established

---

## 💰 Cost Breakdown

### Free Tier (Recommended for Testing)

**Railway:**
- $5/month credit (free)
- Enough for small projects
- No sleep mode

**Vercel:**
- Free for personal projects
- Unlimited bandwidth
- Auto-scaling

**Total: FREE** for small to medium traffic

### Paid Options (For Production)

**Railway Pro:**
- $20/month
- More resources
- Better support

**Vercel Pro:**
- $20/month
- More team features
- Better analytics

---

## 🎯 Alternative Platforms

If Railway doesn't work for you:

### Render (Free Tier)
- Pros: Free tier available
- Cons: Spins down after 15 min inactivity (30s wake-up time)
- See `socket-server/DEPLOY.md` for instructions

### Fly.io (Free Tier)
- Pros: Good performance, free tier
- Cons: Requires CLI setup
- See `socket-server/DEPLOY.md` for instructions

### DigitalOcean ($5/month)
- Pros: Reliable, good performance
- Cons: Paid only
- See `socket-server/DEPLOY.md` for instructions

---

## 📚 Files You Need to Deploy

### For Socket.IO Server:
```
socket-server/
├── index.js          ← Main server file
├── package.json      ← Dependencies
├── .gitignore        ← Git ignore rules
├── railway.json      ← Railway config (optional)
├── render.yaml       ← Render config (optional)
└── Procfile          ← Heroku config (optional)
```

### For Next.js Frontend:
- Your entire Next.js project
- `.env.local` with `NEXT_PUBLIC_WS_URL` (or set in Vercel dashboard)

---

## 🔐 Security Best Practices

1. **Set CLIENT_URL in production:**
   ```
   CLIENT_URL=https://your-actual-domain.com
   ```

2. **Use HTTPS** (automatic on Railway/Vercel)

3. **Add rate limiting** to prevent spam

4. **Implement authentication** for sensitive features

5. **Monitor your server** with logging services

---

## 🎉 You're Done!

Your portfolio with real-time chat is now live! Share your URL and let people experience the interactive features.

**Need help?** Check `socket-server/DEPLOY.md` for detailed platform-specific instructions.
