# ⚡ Vercel Deployment - Quick Guide

## 🎯 Deploy in 5 Minutes

### Step 1: Go to Vercel (1 min)
1. Visit [vercel.com](https://vercel.com)
2. Click "Sign Up"
3. Choose "Continue with GitHub"

### Step 2: Import Project (1 min)
1. Click "Add New..." → "Project"
2. Find: **portifolio-website**
3. Click "Import"

### Step 3: Add Environment Variable (1 min)
**IMPORTANT: Do this before deploying!**

Scroll to "Environment Variables" and add:
```
Name:  NEXT_PUBLIC_WS_URL
Value: https://socketserver-l4vg.onrender.com
```

### Step 4: Deploy (2 min)
1. Click "Deploy" button
2. Wait for build to complete
3. Done! 🎉

### Step 5: Test (30 sec)
1. Visit your Vercel URL
2. Press F12 (open console)
3. Look for: "Socket.IO connected"
4. Open incognito window
5. Should see 2 users

---

## ✅ Quick Checklist

- [ ] Go to vercel.com
- [ ] Sign up with GitHub
- [ ] Import portifolio-website repo
- [ ] Add `NEXT_PUBLIC_WS_URL` environment variable
- [ ] Click Deploy
- [ ] Wait for build
- [ ] Test the site
- [ ] Verify real-time features work

---

## 🔑 Critical Information

**Environment Variable (MUST ADD):**
```
NEXT_PUBLIC_WS_URL=https://socketserver-l4vg.onrender.com
```

**Where to add:**
- Vercel → Project Settings → Environment Variables
- Add BEFORE first deployment
- Or add and then redeploy

---

## 🆘 Quick Troubleshooting

**Build failed?**
→ Check build logs in Vercel

**Can't connect to Socket.IO?**
→ Check environment variable is set
→ Redeploy after adding it

**Site loads but no real-time features?**
→ Hard refresh (Ctrl+Shift+R)
→ Check browser console for errors

---

## 🎉 That's It!

Your portfolio will be live at:
```
https://portifolio-website.vercel.app
```

**Full guide:** `VERCEL-DEPLOYMENT.md`

---

## 📱 Add Custom Domain (Optional)

1. Vercel → Settings → Domains
2. Add your domain
3. Configure DNS:
   ```
   A record: @ → 76.76.21.21
   CNAME: www → cname.vercel-dns.com
   ```
4. Wait 5-60 minutes
5. Done!

---

## 🔗 Important Links

- **Vercel Dashboard:** https://vercel.com/dashboard
- **Your Render Server:** https://socketserver-l4vg.onrender.com
- **GitHub Repo:** https://github.com/jubinkhatriiiiiiiiii/portifolio-website
