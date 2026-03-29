# 🚀 Your Deployment Plan

## Setup Overview

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  Frontend (Next.js)              Socket.IO Server          │
│  ┌──────────────────┐            ┌──────────────────┐     │
│  │                  │   WSS      │                  │     │
│  │  your-domain.com │◄──────────►│  Railway         │     │
│  │                  │            │  xxx.railway.app │     │
│  │  Vercel          │            │                  │     │
│  └──────────────────┘            └──────────────────┘     │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Step 1: Deploy Socket.IO Server to Railway

### 1.1 Prepare Your Code

```bash
# Make sure socket-server folder is in your git repo
cd socket-server
ls -la
# Should see: index.js, package.json, etc.
```

### 1.2 Push to GitHub (if not already)

```bash
cd ..  # Go to project root
git add socket-server/
git commit -m "Add Socket.IO server for deployment"
git push origin main
```

### 1.3 Deploy to Railway

1. **Go to [railway.app](https://railway.app)**

2. **Sign up/Login** with GitHub

3. **Create New Project:**
   - Click "New Project"
   - Select "Deploy from GitHub repo"
   - Choose your repository
   - Railway will scan and detect Node.js

4. **Configure Root Directory:**
   - Click on your service
   - Go to "Settings"
   - Under "Root Directory", enter: `socket-server`
   - Save changes

5. **Railway Auto-Deploys:**
   - It will automatically run `npm install` and `npm start`
   - Wait for deployment to complete (1-2 minutes)

6. **Generate Domain:**
   - Go to "Settings" tab
   - Scroll to "Networking" section
   - Click "Generate Domain"
   - You'll get: `https://your-app-name.up.railway.app`
   - **Copy this URL** - you'll need it!

7. **Optional - Set Environment Variable:**
   - Go to "Variables" tab
   - Click "New Variable"
   - Add:
     - Variable: `CLIENT_URL`
     - Value: `https://your-domain.com` (your custom domain)
   - Save

8. **Test Your Server:**
   ```bash
   curl https://your-app-name.up.railway.app
   # Should return: {"status":"ok","message":"Socket.IO server is running",...}
   ```

✅ **Railway Deployment Complete!**

---

## Step 2: Deploy Frontend to Vercel with Custom Domain

### 2.1 Update Environment Variable

**Option A: Local .env.local (for testing)**
```bash
# In project root (not in src/)
echo "NEXT_PUBLIC_WS_URL=https://your-app-name.up.railway.app" > .env.local
```

**Option B: Vercel Dashboard (for production)**
You'll add this in Vercel after deployment.

### 2.2 Push to GitHub

```bash
git add .
git commit -m "Ready for production deployment"
git push origin main
```

### 2.3 Deploy to Vercel

1. **Go to [vercel.com](https://vercel.com)**

2. **Sign up/Login** with GitHub

3. **Import Project:**
   - Click "Add New..." → "Project"
   - Select your GitHub repository
   - Vercel auto-detects Next.js

4. **Configure Project:**
   - Framework Preset: Next.js (auto-detected)
   - Root Directory: `./` (leave as default)
   - Build Command: `npm run build` (auto-detected)
   - Output Directory: `.next` (auto-detected)

5. **Add Environment Variable:**
   - Before clicking "Deploy", expand "Environment Variables"
   - Add:
     - Name: `NEXT_PUBLIC_WS_URL`
     - Value: `https://your-app-name.up.railway.app`
   - Click "Add"

6. **Deploy:**
   - Click "Deploy"
   - Wait 2-3 minutes for build to complete

7. **You'll get a Vercel URL:**
   - `https://your-project.vercel.app`

✅ **Vercel Deployment Complete!**

### 2.4 Add Your Custom Domain

1. **In Vercel Dashboard:**
   - Go to your project
   - Click "Settings" → "Domains"

2. **Add Domain:**
   - Enter your domain: `your-domain.com`
   - Click "Add"

3. **Configure DNS:**
   
   Vercel will show you DNS records to add. Go to your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.) and add:

   **For root domain (your-domain.com):**
   ```
   Type: A
   Name: @
   Value: 76.76.21.21
   ```

   **For www subdomain:**
   ```
   Type: CNAME
   Name: www
   Value: cname.vercel-dns.com
   ```

4. **Wait for DNS Propagation:**
   - Usually takes 5-60 minutes
   - Vercel will show "Valid Configuration" when ready

5. **SSL Certificate:**
   - Vercel automatically provisions SSL
   - Your site will be available at `https://your-domain.com`

✅ **Custom Domain Setup Complete!**

---

## Step 3: Update Railway with Your Custom Domain

Now that you have your custom domain, update Railway:

1. **Go to Railway Dashboard**

2. **Select your Socket.IO service**

3. **Go to "Variables" tab**

4. **Update or Add `CLIENT_URL`:**
   - Variable: `CLIENT_URL`
   - Value: `https://your-domain.com`
   - Save

5. **Redeploy** (Railway will auto-redeploy on variable change)

This ensures CORS is properly configured for your custom domain.

---

## Step 4: Test Everything

### 4.1 Test Socket.IO Server

```bash
curl https://your-app-name.up.railway.app
# Should return: {"status":"ok","message":"Socket.IO server is running",...}
```

### 4.2 Test Your Website

1. **Visit your custom domain:**
   ```
   https://your-domain.com
   ```

2. **Open Browser Console (F12):**
   - Should see: `Connecting to Socket.IO server: https://your-app-name.up.railway.app`
   - Should see: `Socket.IO connected: [socket-id]`
   - Should see: `Users updated: 1 users`

3. **Open Incognito Window:**
   - Visit `https://your-domain.com`
   - Both windows should show: `Users updated: 2 users`

4. **Test Features:**
   - Click users button (👥) in top-right
   - Should see 2 users in the list
   - "Invite a friend" message should be gone
   - Send a chat message - should appear in both windows
   - Move mouse - should see cursors in both windows

✅ **Everything Working!**

---

## 📋 Deployment Checklist

### Railway (Socket.IO Server)
- [ ] Code pushed to GitHub
- [ ] Railway project created
- [ ] Root directory set to `socket-server`
- [ ] Deployment successful
- [ ] Domain generated
- [ ] Health check works: `curl https://xxx.railway.app`
- [ ] `CLIENT_URL` environment variable set to your custom domain

### Vercel (Next.js Frontend)
- [ ] Code pushed to GitHub
- [ ] Vercel project created
- [ ] `NEXT_PUBLIC_WS_URL` environment variable added
- [ ] Deployment successful
- [ ] Custom domain added
- [ ] DNS records configured
- [ ] SSL certificate active
- [ ] Site accessible at `https://your-domain.com`

### Testing
- [ ] Socket.IO server responds to health check
- [ ] Website loads on custom domain
- [ ] Browser console shows "Socket.IO connected"
- [ ] Multiple users can connect
- [ ] Chat messages work
- [ ] Cursor tracking works
- [ ] No console errors

---

## 🔧 Troubleshooting

### Issue: "Mixed Content" Error

**Problem:** Browser blocks HTTP connection from HTTPS site

**Solution:** Make sure Railway URL uses HTTPS (it should by default)
```
✅ https://xxx.railway.app
❌ http://xxx.railway.app
```

### Issue: CORS Error

**Problem:** `Access-Control-Allow-Origin` error in console

**Solution:** 
1. Check `CLIENT_URL` in Railway is set to your custom domain
2. Make sure it includes `https://` and no trailing slash
3. Redeploy Railway after changing

### Issue: Can't Connect to Socket.IO

**Problem:** "Connection refused" or timeout

**Solution:**
1. Test Railway server: `curl https://xxx.railway.app`
2. Check `NEXT_PUBLIC_WS_URL` in Vercel environment variables
3. Redeploy Vercel after adding/changing env variable
4. Hard refresh browser (Ctrl+Shift+R)

### Issue: Custom Domain Not Working

**Problem:** Domain shows error or doesn't load

**Solution:**
1. Check DNS records are correct in your registrar
2. Wait for DNS propagation (can take up to 48 hours, usually 5-60 min)
3. Try accessing via `www.your-domain.com` if root doesn't work yet
4. Check Vercel dashboard shows "Valid Configuration"

---

## 💰 Cost Breakdown

### Your Setup (Free Tier)

**Railway:**
- Free: $5/month credit
- Your usage: ~$0.50-$2/month (well within free tier)
- No credit card required initially

**Vercel:**
- Free: Unlimited bandwidth for personal projects
- Custom domain: Free
- SSL certificate: Free
- Your usage: $0/month

**Domain Registration:**
- Your cost: $10-15/year (from your registrar)

**Total Monthly Cost: $0** (plus domain registration)

---

## 🎯 Environment Variables Summary

### Railway Environment Variables
```env
PORT=3001                          # Auto-set by Railway
CLIENT_URL=https://your-domain.com # Set manually
```

### Vercel Environment Variables
```env
NEXT_PUBLIC_WS_URL=https://your-app-name.up.railway.app
```

---

## 📝 Important URLs to Save

```
Socket.IO Server:  https://your-app-name.up.railway.app
Your Website:      https://your-domain.com
Railway Dashboard: https://railway.app/dashboard
Vercel Dashboard:  https://vercel.com/dashboard
```

---

## 🎉 You're All Set!

Your portfolio with real-time chat is now:
- ✅ Deployed on Railway (Socket.IO)
- ✅ Deployed on Vercel (Next.js)
- ✅ Accessible via your custom domain
- ✅ Fully functional with HTTPS
- ✅ Ready to share with the world!

Share your custom domain and let people experience the interactive features! 🚀
