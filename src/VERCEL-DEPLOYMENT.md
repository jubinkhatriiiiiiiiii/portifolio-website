# 🚀 Deploy Frontend to Vercel - Complete Guide

## Prerequisites

✅ Your code is on GitHub: https://github.com/jubinkhatriiiiiiiiii/portifolio-website
✅ Render server is live: https://socketserver-l4vg.onrender.com

---

## Step 1: Go to Vercel

1. Open your browser
2. Go to [vercel.com](https://vercel.com)
3. Click "Sign Up" (if you don't have an account)
4. **Sign up with GitHub** (recommended - makes deployment easier)

---

## Step 2: Import Your Project

### 2.1 Create New Project

1. After logging in, you'll see the Vercel dashboard
2. Click **"Add New..."** button (top right)
3. Select **"Project"** from the dropdown

### 2.2 Import Git Repository

1. You'll see "Import Git Repository"
2. If this is your first time:
   - Click **"Add GitHub Account"**
   - Authorize Vercel to access your GitHub
   - Select which repositories to give access to
3. Find and select: **portifolio-website**
4. Click **"Import"**

---

## Step 3: Configure Project

Vercel will auto-detect your Next.js project. You'll see:

### 3.1 Project Settings

```
Project Name: portifolio-website
(or customize it)

Framework Preset: Next.js
(auto-detected ✅)

Root Directory: ./
(leave as default)

Build Command: npm run build
(auto-detected ✅)

Output Directory: .next
(auto-detected ✅)

Install Command: npm install
(auto-detected ✅)
```

**Don't click Deploy yet!** We need to add the environment variable first.

### 3.2 Add Environment Variable

This is the most important step!

1. Scroll down to **"Environment Variables"** section
2. Click to expand it
3. Add the following:

```
Name:  NEXT_PUBLIC_WS_URL
Value: https://socketserver-l4vg.onrender.com
```

4. Make sure it's set for:
   - ✅ Production
   - ✅ Preview
   - ✅ Development

5. Click **"Add"**

You should see it appear in the list.

---

## Step 4: Deploy!

1. Scroll to the bottom
2. Click **"Deploy"** button
3. Wait for the build (usually 2-3 minutes)

You'll see:
- "Building..." with logs
- "Deploying..."
- "Success!" 🎉

---

## Step 5: Get Your Vercel URL

Once deployed, you'll see:

```
🎉 Congratulations!

Your project is live at:
https://portifolio-website.vercel.app
```

**Copy this URL and test it!**

---

## Step 6: Test Your Deployment

### 6.1 Visit Your Site

1. Click on the Vercel URL or visit it in your browser
2. Your portfolio should load

### 6.2 Test Real-time Features

1. **Open Browser Console** (Press F12)
2. Look for these messages:
   ```
   Connecting to Socket.IO server: https://socketserver-l4vg.onrender.com
   Socket.IO connected: [socket-id]
   Users updated: 1 users
   ```

3. **Open Incognito Window**
   - Visit the same URL
   - Both windows should show: `Users updated: 2 users`

4. **Test Features:**
   - Click the users button (👥) in top-right
   - Should see 2 users in the list
   - "Invite a friend" message should be gone
   - Send a chat message - should appear in both windows
   - Move mouse - should see cursors in both windows

✅ **If all this works, your deployment is successful!**

---

## Step 7: Add Custom Domain (Optional)

### 7.1 Add Domain in Vercel

1. In Vercel dashboard, go to your project
2. Click **"Settings"** tab
3. Click **"Domains"** in the sidebar
4. Enter your custom domain (e.g., `yourdomain.com`)
5. Click **"Add"**

### 7.2 Configure DNS

Vercel will show you DNS records to add. Go to your domain registrar (GoDaddy, Namecheap, Cloudflare, etc.):

**For root domain (yourdomain.com):**
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

### 7.3 Wait for DNS Propagation

- Usually takes 5-60 minutes
- Can take up to 48 hours in rare cases
- Vercel will show "Valid Configuration" when ready
- SSL certificate is automatically provisioned

### 7.4 Update Render with Custom Domain

Once your custom domain is working:

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click on your **socketserver-l4vg** service
3. Go to **"Environment"** tab
4. Add or update environment variable:
   ```
   Key: CLIENT_URL
   Value: https://yourdomain.com
   ```
5. Click **"Save Changes"**
6. Render will automatically redeploy

---

## 📋 Deployment Checklist

### Before Deployment
- [x] Code pushed to GitHub
- [x] Render server is live
- [x] Render URL obtained

### Vercel Deployment
- [ ] Vercel account created
- [ ] GitHub connected to Vercel
- [ ] Project imported from GitHub
- [ ] Environment variable `NEXT_PUBLIC_WS_URL` added
- [ ] Deployed successfully
- [ ] Vercel URL obtained: `_______________________________`

### Testing
- [ ] Website loads correctly
- [ ] No build errors
- [ ] Browser console shows "Socket.IO connected"
- [ ] Multiple users can connect
- [ ] Chat messages work
- [ ] Cursor tracking works
- [ ] No console errors

### Custom Domain (Optional)
- [ ] Domain added in Vercel
- [ ] DNS records configured
- [ ] DNS propagation complete
- [ ] SSL certificate active
- [ ] Custom domain working
- [ ] Render `CLIENT_URL` updated

---

## 🔧 Troubleshooting

### Issue: Build Failed

**Check the build logs in Vercel:**

1. Click on the failed deployment
2. View the logs
3. Common issues:
   - Missing dependencies
   - TypeScript errors
   - Build command issues

**Solution:**
```bash
# Test build locally first
npm run build

# If it works locally, check Vercel logs for specific errors
```

### Issue: Environment Variable Not Working

**Symptoms:**
- Console shows: `NEXT_PUBLIC_WS_URL is not set`
- Can't connect to Socket.IO

**Solution:**
1. Go to Vercel → Settings → Environment Variables
2. Verify `NEXT_PUBLIC_WS_URL` is set correctly
3. Make sure it's enabled for Production, Preview, and Development
4. **Redeploy** (important! Env vars only apply after redeploy)
   - Go to Deployments tab
   - Click "..." on latest deployment
   - Click "Redeploy"

### Issue: Can't Connect to Socket.IO

**Check:**
1. Render server is running: `curl https://socketserver-l4vg.onrender.com`
2. Environment variable is correct in Vercel
3. Browser console for specific errors
4. Hard refresh browser (Ctrl+Shift+R)

**If Render server is sleeping (503 error):**
- Wait 30 seconds for it to wake up
- This is normal for free tier
- Consider using UptimeRobot to keep it awake

### Issue: CORS Error

**Solution:**
1. Go to Render dashboard
2. Add `CLIENT_URL` environment variable
3. Set to your Vercel URL or custom domain
4. Render will auto-redeploy

### Issue: Custom Domain Not Working

**Check:**
1. DNS records are correct
2. Wait longer (DNS can take time)
3. Try `www.yourdomain.com` if root doesn't work yet
4. Check Vercel dashboard for domain status

---

## 🎯 Environment Variables Reference

### Vercel Environment Variables

```env
NEXT_PUBLIC_WS_URL=https://socketserver-l4vg.onrender.com
```

**How to add:**
1. Vercel Dashboard → Your Project
2. Settings → Environment Variables
3. Add the variable
4. Redeploy

**How to update:**
1. Settings → Environment Variables
2. Click "Edit" on the variable
3. Update the value
4. Save
5. Redeploy (important!)

---

## 🔄 Redeploying

### Auto-Deploy (Recommended)

Vercel automatically redeploys when you push to GitHub:

```bash
# Make changes to your code
git add .
git commit -m "Update portfolio"
git push origin main

# Vercel automatically deploys in 2-3 minutes
```

### Manual Deploy

To manually trigger a deployment:

1. Go to Vercel dashboard
2. Click on your project
3. Go to "Deployments" tab
4. Click "..." on any deployment
5. Click "Redeploy"

---

## 📊 Vercel Dashboard Overview

### Deployments Tab
- See all deployments
- View build logs
- Redeploy if needed

### Settings Tab
- Environment Variables
- Domains
- General settings
- Build & Development settings

### Analytics Tab (Optional)
- Upgrade to Pro for analytics
- See visitor stats
- Performance metrics

---

## 💰 Cost

### Vercel Free Tier (Hobby)

**Includes:**
- ✅ Unlimited deployments
- ✅ Unlimited bandwidth
- ✅ Custom domains (unlimited)
- ✅ SSL certificates (automatic)
- ✅ Auto-scaling
- ✅ Edge network (CDN)
- ✅ Preview deployments

**Limits:**
- 100 GB bandwidth/month (usually enough)
- 100 build hours/month
- 1 concurrent build

**Cost: $0/month**

### Vercel Pro (Optional)

**If you need:**
- More bandwidth
- Team collaboration
- Analytics
- Password protection
- More concurrent builds

**Cost: $20/month**

---

## 🎉 Success!

Your portfolio is now live on Vercel!

**Your URLs:**
- Vercel: `https://portifolio-website.vercel.app`
- Custom Domain: `https://yourdomain.com` (if configured)
- Socket Server: `https://socketserver-l4vg.onrender.com`

**Share your portfolio with the world!** 🚀

---

## 📚 Additional Resources

**Vercel Documentation:**
- [Next.js on Vercel](https://vercel.com/docs/frameworks/nextjs)
- [Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)
- [Custom Domains](https://vercel.com/docs/concepts/projects/domains)

**Need Help?**
- Vercel Support: https://vercel.com/support
- Vercel Community: https://github.com/vercel/vercel/discussions

---

## 🔗 Quick Links

- **Vercel Dashboard:** https://vercel.com/dashboard
- **Your GitHub Repo:** https://github.com/jubinkhatriiiiiiiiii/portifolio-website
- **Render Dashboard:** https://dashboard.render.com
- **Socket Server:** https://socketserver-l4vg.onrender.com
