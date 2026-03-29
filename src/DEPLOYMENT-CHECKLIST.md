# ✅ Deployment Checklist

Print this and check off as you go!

---

## 🔴 Phase 1: Railway (Socket.IO Server)

- [ ] Push `socket-server/` folder to GitHub
- [ ] Go to railway.app and sign up
- [ ] Create new project from GitHub repo
- [ ] Set root directory to `socket-server`
- [ ] Wait for deployment (1-2 min)
- [ ] Generate domain in Settings → Networking
- [ ] Copy Railway URL: `_______________________________`
- [ ] Test: `curl https://your-railway-url.com`
- [ ] Add environment variable `CLIENT_URL` = your custom domain
- [ ] Verify deployment is running

**Railway URL:** `https://________________________________.up.railway.app`

---

## 🔵 Phase 2: Vercel (Next.js Frontend)

- [ ] Push code to GitHub
- [ ] Go to vercel.com and sign up
- [ ] Import project from GitHub
- [ ] Add environment variable:
  - Name: `NEXT_PUBLIC_WS_URL`
  - Value: (paste Railway URL from above)
- [ ] Click Deploy
- [ ] Wait for build (2-3 min)
- [ ] Copy Vercel URL: `_______________________________`
- [ ] Test: Visit Vercel URL in browser

**Vercel URL:** `https://________________________________.vercel.app`

---

## 🟢 Phase 3: Custom Domain

- [ ] In Vercel: Settings → Domains
- [ ] Add your custom domain: `_______________________________`
- [ ] Go to your domain registrar (GoDaddy, Namecheap, etc.)
- [ ] Add DNS records:
  - [ ] A record: `@` → `76.76.21.21`
  - [ ] CNAME record: `www` → `cname.vercel-dns.com`
- [ ] Wait for DNS propagation (5-60 min)
- [ ] Verify Vercel shows "Valid Configuration"
- [ ] Test: Visit your custom domain

**Custom Domain:** `https://________________________________`

---

## 🟡 Phase 4: Update Railway with Custom Domain

- [ ] Go back to Railway dashboard
- [ ] Select your Socket.IO service
- [ ] Go to Variables tab
- [ ] Update `CLIENT_URL` to your custom domain
- [ ] Save (Railway will auto-redeploy)

---

## 🟣 Phase 5: Final Testing

### Test Socket.IO Server
- [ ] `curl https://your-railway-url.com` returns JSON
- [ ] Status shows "ok"
- [ ] No errors in Railway logs

### Test Website
- [ ] Visit `https://your-domain.com`
- [ ] Page loads correctly
- [ ] No console errors (F12)
- [ ] See "Socket.IO connected" in console
- [ ] See "Users updated: 1 users" in console

### Test Real-time Features
- [ ] Open incognito window to your domain
- [ ] Both windows show "Users updated: 2 users"
- [ ] Click users button (👥) shows 2 users
- [ ] "Invite a friend" message is gone
- [ ] Send chat message - appears in both windows
- [ ] Move mouse - see cursor in other window
- [ ] Typing indicator works
- [ ] Profile editing works

---

## 📝 Important Information

**Railway URL:**
```
https://________________________________.up.railway.app
```

**Vercel URL:**
```
https://________________________________.vercel.app
```

**Custom Domain:**
```
https://________________________________
```

**Environment Variables:**

Railway:
```
CLIENT_URL=https://your-domain.com
```

Vercel:
```
NEXT_PUBLIC_WS_URL=https://your-railway-url.up.railway.app
```

---

## 🆘 If Something Goes Wrong

### Socket.IO won't connect
1. Check Railway URL is correct
2. Verify `NEXT_PUBLIC_WS_URL` in Vercel
3. Redeploy Vercel
4. Hard refresh browser (Ctrl+Shift+R)

### Custom domain not working
1. Check DNS records are correct
2. Wait longer (DNS can take up to 48 hours)
3. Try `www.your-domain.com` instead
4. Check Vercel dashboard for errors

### CORS errors
1. Verify `CLIENT_URL` in Railway
2. Make sure it's `https://` not `http://`
3. No trailing slash
4. Redeploy Railway

---

## ✅ Success Criteria

You're done when:
- ✅ Custom domain loads your site
- ✅ Browser console shows "Socket.IO connected"
- ✅ Multiple browser windows show multiple users
- ✅ Chat messages sync in real-time
- ✅ Cursors move in real-time
- ✅ No errors in console

---

## 🎉 Congratulations!

Your portfolio is live with real-time features!

**Share your domain:** `https://________________________________`

---

**Date Deployed:** _______________

**Notes:**
_________________________________________________________________
_________________________________________________________________
_________________________________________________________________
