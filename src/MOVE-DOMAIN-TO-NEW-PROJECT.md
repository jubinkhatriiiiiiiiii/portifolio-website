# 🔄 Move Custom Domain to New Project in Vercel

## Step-by-Step Guide

### Step 1: Remove Domain from Old Project

1. **Go to Vercel Dashboard:** [vercel.com/dashboard](https://vercel.com/dashboard)

2. **Click on your OLD project** (the one currently using your domain)

3. **Go to Settings tab**

4. **Click "Domains" in the sidebar**

5. **Find your custom domain** in the list

6. **Click the "..." (three dots)** next to your domain

7. **Click "Remove"**

8. **Confirm removal**

✅ Your domain is now free to use in another project!

---

### Step 2: Add Domain to New Project

1. **Go back to Vercel Dashboard**

2. **Click on your NEW project** (portifolio-website)

3. **Go to Settings tab**

4. **Click "Domains" in the sidebar**

5. **Enter your domain** in the input field:
   ```
   yourdomain.com
   ```

6. **Click "Add"**

7. **Vercel will automatically configure it** ✅

---

## 🎯 Quick Steps Summary

```
Old Project → Settings → Domains → Remove domain
    ↓
New Project → Settings → Domains → Add domain
    ↓
Done! ✅
```

---

## ⚡ Alternative: Use Vercel CLI (Faster)

If you prefer command line:

```bash
# Install Vercel CLI (if not installed)
npm i -g vercel

# Login
vercel login

# Remove from old project
vercel domains rm yourdomain.com --scope=your-team

# Add to new project
cd /path/to/new-project
vercel domains add yourdomain.com
```

---

## 📋 Important Notes

### DNS Records Stay the Same

You **don't need to change DNS records** at your registrar! They stay the same:

```
Type: A
Name: @
Value: 76.76.21.21

Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

### SSL Certificate

- Vercel automatically provisions a new SSL certificate
- Takes 1-5 minutes
- Your site will be HTTPS automatically

### Propagation Time

- Domain switch is instant on Vercel
- May take 1-5 minutes for SSL certificate
- No DNS propagation needed (records stay same)

---

## 🆘 Troubleshooting

### Issue: "Domain is already in use"

**Cause:** Domain not removed from old project yet

**Solution:**
1. Go to old project
2. Settings → Domains
3. Remove the domain
4. Try adding to new project again

### Issue: Can't find old project

**Solution:**
1. Go to Vercel Dashboard
2. Look at all your projects
3. Check each one's domains
4. Or search for your domain in the search bar

### Issue: Domain shows error after moving

**Solution:**
1. Wait 5 minutes for SSL certificate
2. Hard refresh browser (Ctrl+Shift+R)
3. Check Vercel dashboard for domain status

---

## ✅ Verification

After moving the domain:

1. **Visit your domain:** `https://yourdomain.com`
2. **Should load your NEW project** ✅
3. **Check SSL certificate** (padlock icon in browser)
4. **Test all features**

---

## 🎯 Example Walkthrough

Let's say your domain is `example.com`:

### Current State:
```
example.com → Old Project (old-portfolio)
```

### After Moving:
```
example.com → New Project (portifolio-website)
```

### Steps:
1. Old Project → Settings → Domains → Remove `example.com`
2. New Project → Settings → Domains → Add `example.com`
3. Wait 2-3 minutes
4. Visit `https://example.com` → See new project! ✅

---

## 💡 Pro Tips

### Keep Old Project Accessible

The old project will still be accessible at:
```
https://old-project-name.vercel.app
```

### Multiple Domains

You can add multiple domains to one project:
```
yourdomain.com
www.yourdomain.com
yourdomain.net
```

### Subdomain for Old Project

If you want to keep old project accessible:
1. Add subdomain to old project: `old.yourdomain.com`
2. Add DNS record:
   ```
   Type: CNAME
   Name: old
   Value: cname.vercel-dns.com
   ```

---

## 🚀 Quick Action Plan

**Right now:**

1. ✅ Go to Vercel Dashboard
2. ✅ Find old project
3. ✅ Remove domain from old project
4. ✅ Go to new project (portifolio-website)
5. ✅ Add domain to new project
6. ✅ Wait 2-3 minutes
7. ✅ Visit your domain
8. ✅ Enjoy your new portfolio! 🎉

---

## 📝 Checklist

- [ ] Identified old project using the domain
- [ ] Removed domain from old project
- [ ] Added domain to new project (portifolio-website)
- [ ] Waited for SSL certificate (2-3 minutes)
- [ ] Visited domain and verified it works
- [ ] Tested all features (real-time chat, contact form, etc.)
- [ ] Old project still accessible at .vercel.app URL

---

## 🎉 Done!

Your custom domain is now pointing to your new portfolio project with real-time features! 🚀
