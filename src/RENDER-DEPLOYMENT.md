# 🚀 Deploy to Render - Step by Step

## Why Render?

✅ Free tier available
✅ Easy setup (no CLI needed)
✅ Auto-deploys from GitHub
✅ Good performance
✅ Simple dashboard

⚠️ **Note:** Free tier spins down after 15 minutes of inactivity (takes ~30 seconds to wake up on first request)

---

## Step 1: Deploy Socket.IO Server to Render

### 1.1 Go to Render

1. Open [render.com](https://render.com) in your browser
2. Click "Get Started" or "Sign Up"
3. Sign up with GitHub (recommended)

### 1.2 Create New Web Service

1. Click "New +" button (top right)
2. Select "Web Service"

### 1.3 Connect Repository

1. You'll see "Connect a repository"
2. If this is your first time:
   - Click "Configure account" 
   - Grant Render access to your GitHub
3. Find and select: **socketserver**
4. Click "Connect"

### 1.4 Configure Web Service

Fill in the following settings:

**Basic Settings:**
```
Name: portfolio-socket-server
(or any name you prefer)

Region: Choose closest to your users
(e.g., Oregon (US West), Frankfurt (EU), Singapore)

Branch: main

Root Directory: (leave blank)
```

**Build & Deploy:**
```
Runtime: Node

Build Command: npm install

Start Command: npm start
```

**Instance Type:**
```
Select: Free
(or paid if you want no sleep mode)
```

### 1.5 Add Environment Variables (Optional)

Scroll down to "Environment Variables" section:

1. Click "Add Environment Variable"
2. Add:
   - Key: `CLIENT_URL`
   - Value: `https://your-custom-domain.com` (your actual domain)
3. Click "Add"

**Note:** You can add this later after you set up your custom domain.

### 1.6 Create Web Service

1. Scroll to bottom
2. Click "Create Web Service"
3. Render will start deploying (takes 2-3 minutes)

### 1.7 Wait for Deployment

You'll see:
- "Build in progress..." 
- "Deploying..."
- "Live" ✅

Watch the logs to see the deployment progress.

### 1.8 Get Your Render URL

Once deployed, you'll see your URL at the top:
```
https://portfolio-socket-server.onrender.com
```

**Copy this URL!** You'll need it for Vercel.

### 1.9 Test Your Server

```bash
curl https://portfolio-socket-server.onrender.com
```

You should see:
```json
{
  "status": "ok",
  "message": "Socket.IO server is running",
  "timestamp": "...",
  "connections": 0,
  "uptime": ...
}
```

✅ **Socket.IO Server is Live on Render!**

---

## Step 2: Deploy Frontend to Vercel

### 2.1 Update Environment Variable

In your main portfolio project (not socket-server):

```bash
# In your project root (where package.json is)
echo "NEXT_PUBLIC_WS_URL=https://portfolio-socket-server.onrender.com" > .env.local
```

Replace with your actual Render URL.

### 2.2 Push to GitHub

```bash
git add .
git commit -m "Add Render Socket.IO server URL"
git push origin main
```

### 2.3 Deploy to Vercel

1. Go to [vercel.com](https://vercel.com)
2. Sign in with GitHub
3. Click "Add New..." → "Project"
4. Select your portfolio repository
5. Before deploying, add environment variable:
   - Click "Environment Variables"
   - Name: `NEXT_PUBLIC_WS_URL`
   - Value: `https://portfolio-socket-server.onrender.com`
   - Click "Add"
6. Click "Deploy"
7. Wait 2-3 minutes

### 2.4 Add Custom Domain to Vercel

1. In Vercel dashboard, go to your project
2. Click "Settings" → "Domains"
3. Enter your custom domain: `your-domain.com`
4. Click "Add"

### 2.5 Configure DNS

Go to your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.) and add:

**For root domain:**
```
Type: A
Name: @
Value: 76.76.21.21
TTL: 3600
```

**For www subdomain:**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
TTL: 3600
```

Wait 5-60 minutes for DNS propagation.

### 2.6 Update Render with Custom Domain

Once your custom domain is working:

1. Go back to Render dashboard
2. Click on your "portfolio-socket-server" service
3. Go to "Environment" tab
4. Update or add `CLIENT_URL`:
   - Key: `CLIENT_URL`
   - Value: `https://your-custom-domain.com`
5. Click "Save Changes"
6. Render will automatically redeploy

---

## Step 3: Test Everything

### 3.1 Test Socket.IO Server

```bash
# Test health endpoint
curl https://portfolio-socket-server.onrender.com

# Should return JSON with status: "ok"
```

### 3.2 Test Your Website

1. Visit your custom domain: `https://your-domain.com`

2. Open Browser Console (F12):
   - Should see: `Connecting to Socket.IO server: https://portfolio-socket-server.onrender.com`
   - Should see: `Socket.IO connected: [socket-id]`
   - Should see: `Users updated: 1 users`

3. Open Incognito Window:
   - Visit `https://your-domain.com`
   - Both windows should show: `Users updated: 2 users`

4. Test Features:
   - Click users button (👥)
   - Should see 2 users
   - "Invite a friend" message should be gone
   - Send chat messages
   - Move mouse to see cursors

✅ **Everything Working!**

---

## 📋 Deployment Checklist

### Render (Socket.IO Server)
- [x] GitHub repo created (socketserver)
- [ ] Render account created
- [ ] Web Service created
- [ ] Repository connected
- [ ] Build settings configured
- [ ] Deployment successful
- [ ] Render URL copied: `_______________________________`
- [ ] Health check passed
- [ ] Environment variable `CLIENT_URL` added (optional for now)

### Vercel (Next.js Frontend)
- [ ] `.env.local` updated with Render URL
- [ ] Code pushed to GitHub
- [ ] Vercel account created
- [ ] Project imported
- [ ] Environment variable `NEXT_PUBLIC_WS_URL` added
- [ ] Deployment successful
- [ ] Custom domain added
- [ ] DNS records configured
- [ ] SSL certificate active
- [ ] Custom domain working
- [ ] Render `CLIENT_URL` updated to custom domain

### Testing
- [ ] Render server responds to health check
- [ ] Website loads on custom domain
- [ ] Browser console shows "Socket.IO connected"
- [ ] Multiple users can connect
- [ ] Chat messages work
- [ ] Cursor tracking works
- [ ] No console errors

---

## 🔧 Render-Specific Tips

### Free Tier Limitations

**Sleep Mode:**
- Free tier spins down after 15 minutes of inactivity
- Takes ~30 seconds to wake up on first request
- Subsequent requests are instant

**Solution for Sleep Mode:**
1. Upgrade to paid tier ($7/month) - no sleep
2. Use a service like [UptimeRobot](https://uptimerobot.com) to ping your server every 10 minutes
3. Accept the 30-second wake-up time (fine for personal projects)

### Keep Server Awake (Optional)

If you want to prevent sleep on free tier, use UptimeRobot:

1. Sign up at [uptimerobot.com](https://uptimerobot.com)
2. Add new monitor:
   - Type: HTTP(s)
   - URL: `https://portfolio-socket-server.onrender.com`
   - Interval: 5 minutes
3. This will ping your server every 5 minutes, keeping it awake

### Auto-Deploy from GitHub

Render automatically redeploys when you push to GitHub:

```bash
# Make changes to socket-server
cd socket-server
git add .
git commit -m "Update server"
git push origin main

# Render will auto-deploy in 1-2 minutes
```

### View Logs

To see server logs:
1. Go to Render dashboard
2. Click on your service
3. Click "Logs" tab
4. See real-time logs

### Manual Deploy

To manually trigger a deploy:
1. Go to Render dashboard
2. Click on your service
3. Click "Manual Deploy" → "Deploy latest commit"

---

## 💰 Cost Breakdown

### Free Tier
**Render:**
- Free tier: 750 hours/month
- Spins down after 15 min inactivity
- 512 MB RAM
- Shared CPU
- Cost: $0/month

**Vercel:**
- Free for personal projects
- Unlimited bandwidth
- Custom domain: Free
- SSL: Free
- Cost: $0/month

**Total: $0/month** (plus domain registration ~$10-15/year)

### Paid Tier (No Sleep Mode)
**Render Starter:**
- $7/month
- No sleep mode
- 512 MB RAM
- Shared CPU

**Vercel Pro:**
- $20/month (optional)
- More features

**Total: $7-27/month**

---

## 🆘 Troubleshooting

### Issue: "Build Failed"

**Check:**
1. Render logs for specific error
2. Verify `package.json` has correct `start` script
3. Check Node.js version compatibility

**Fix:**
Add `engines` to `package.json`:
```json
"engines": {
  "node": ">=18.0.0"
}
```

### Issue: "Service Unavailable" (503)

**Cause:** Server is waking up from sleep (free tier)

**Solution:** Wait 30 seconds and refresh

### Issue: CORS Error

**Check:**
1. `CLIENT_URL` is set correctly in Render
2. URL includes `https://` and no trailing slash
3. Redeploy after changing environment variables

### Issue: Can't Connect to Socket.IO

**Check:**
1. Render URL is correct
2. `NEXT_PUBLIC_WS_URL` in Vercel matches Render URL
3. Redeploy Vercel after adding env variable
4. Hard refresh browser (Ctrl+Shift+R)

---

## 📝 Important URLs

**Your Render URL:**
```
https://portfolio-socket-server.onrender.com
```

**Your Vercel URL:**
```
https://your-project.vercel.app
```

**Your Custom Domain:**
```
https://your-domain.com
```

**Dashboards:**
- Render: https://dashboard.render.com
- Vercel: https://vercel.com/dashboard

---

## 🎯 Environment Variables Summary

### Render Environment Variables
```env
CLIENT_URL=https://your-custom-domain.com
```

### Vercel Environment Variables
```env
NEXT_PUBLIC_WS_URL=https://portfolio-socket-server.onrender.com
```

---

## 🎉 You're All Set!

Your portfolio with real-time chat is now:
- ✅ Deployed on Render (Socket.IO)
- ✅ Deployed on Vercel (Next.js)
- ✅ Accessible via your custom domain
- ✅ Fully functional with HTTPS
- ✅ Ready to share!

**Note:** First load might take 30 seconds if server was sleeping (free tier). After that, it's instant!

---

## 🔄 Next Time You Update

**Update Socket Server:**
```bash
cd socket-server
# Make changes
git add .
git commit -m "Update server"
git push origin main
# Render auto-deploys
```

**Update Frontend:**
```bash
# Make changes
git add .
git commit -m "Update frontend"
git push origin main
# Vercel auto-deploys
```

Both platforms auto-deploy from GitHub! 🚀
