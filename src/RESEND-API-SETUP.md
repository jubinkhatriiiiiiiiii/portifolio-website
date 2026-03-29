# 📧 Resend API Setup Guide

## What is Resend?

Resend is an email API service that lets your contact form send emails. It's used by your portfolio to forward contact form submissions to your email.

---

## 💰 Pricing - FREE TIER!

### Free Plan (Perfect for Portfolio)
✅ **3,000 emails per month** - FREE
✅ No credit card required
✅ Custom domain support
✅ Email templates
✅ API access

**This is more than enough for a personal portfolio!**

### Paid Plans (If you need more)
- **Pro:** $20/month - 50,000 emails
- **Business:** $80/month - 100,000 emails

**For your portfolio, the free tier is perfect!**

---

## 🚀 Step-by-Step Setup (5 minutes)

### Step 1: Create Resend Account

1. Go to [resend.com](https://resend.com)
2. Click **"Start Building"** or **"Sign Up"**
3. Sign up with:
   - GitHub (recommended - easiest)
   - Google
   - Email

### Step 2: Verify Your Email

1. Check your email inbox
2. Click the verification link
3. You'll be redirected to Resend dashboard

### Step 3: Create API Key

1. In Resend dashboard, click **"API Keys"** in the left sidebar
2. Click **"Create API Key"** button
3. Fill in:
   ```
   Name: Portfolio Contact Form
   Permission: Full Access (or Sending access)
   ```
4. Click **"Add"**
5. **IMPORTANT:** Copy the API key immediately!
   ```
   re_xxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
   ⚠️ You won't be able to see it again!

### Step 4: Add to Vercel

1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)
2. Click on your **portifolio-website** project
3. Go to **Settings** → **Environment Variables**
4. Click **"Add New"**
5. Add:
   ```
   Name:  RESEND_API_KEY
   Value: re_xxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
6. Select environments:
   - ✅ Production
   - ✅ Preview
   - ✅ Development
7. Click **"Save"**

### Step 5: Redeploy

1. Go to **Deployments** tab
2. Click **"..."** on the latest deployment
3. Click **"Redeploy"**
4. Wait 2-3 minutes
5. Done! ✅

---

## 🧪 Test Your Contact Form

### After Redeployment:

1. Visit your Vercel URL
2. Go to the contact page
3. Fill out the form:
   ```
   Name: Test User
   Email: test@example.com
   Message: Testing contact form
   ```
4. Click **"Send"**
5. Check your email inbox (the one in your config)
6. You should receive the message!

---

## 📧 Configure Email Settings (Optional)

### Add Your Domain (Optional but Recommended)

**Why?** Emails will come from `your-domain.com` instead of `onboarding@resend.dev`

1. In Resend dashboard, click **"Domains"**
2. Click **"Add Domain"**
3. Enter your domain: `yourdomain.com`
4. Add DNS records (shown by Resend):
   ```
   Type: TXT
   Name: @
   Value: [provided by Resend]
   
   Type: MX
   Name: @
   Value: [provided by Resend]
   ```
5. Wait for verification (5-60 minutes)
6. Update your code to use your domain

### Update Email Sender

Once domain is verified, update `app/api/send/route.ts`:

```typescript
from: "Portfolio <contact@yourdomain.com>",  // Instead of onboarding@resend.dev
```

---

## 🔧 Environment Variables Summary

### Local Development (.env.local)
```env
NEXT_PUBLIC_WS_URL=https://socketserver-l4vg.onrender.com
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Vercel (Production)
```env
NEXT_PUBLIC_WS_URL=https://socketserver-l4vg.onrender.com
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 🆘 Troubleshooting

### Issue: "Email service not configured"

**Cause:** API key not set or invalid

**Solution:**
1. Check Vercel environment variables
2. Verify API key is correct
3. Redeploy after adding/updating
4. Check Resend dashboard for API key status

### Issue: Emails not arriving

**Check:**
1. Spam folder
2. Resend dashboard → Logs (see if email was sent)
3. Email address in `data/config.ts` is correct
4. API key has "Sending" permission

### Issue: "Domain not verified"

**Solution:**
1. Check DNS records are correct
2. Wait longer (can take up to 48 hours)
3. Use default `onboarding@resend.dev` in the meantime

### Issue: Rate limit exceeded

**Cause:** Sent more than 3,000 emails this month (unlikely for portfolio)

**Solution:**
1. Wait until next month
2. Upgrade to paid plan
3. Check for spam/abuse

---

## 📊 Monitor Usage

### Check Email Stats

1. Go to Resend dashboard
2. Click **"Logs"** to see all sent emails
3. Click **"Analytics"** to see usage stats
4. Monitor your monthly limit

### Free Tier Limits

- ✅ 3,000 emails/month
- ✅ 100 emails/day
- ✅ Unlimited API keys
- ✅ Email templates
- ✅ Webhooks

**For a portfolio contact form, you'll likely use < 50 emails/month**

---

## 🔐 Security Best Practices

### Protect Your API Key

1. **Never commit to GitHub:**
   ```bash
   # Already in .gitignore
   .env.local
   .env
   ```

2. **Use environment variables only:**
   - Vercel: Settings → Environment Variables
   - Local: `.env.local` file

3. **Rotate keys if exposed:**
   - Delete old key in Resend dashboard
   - Create new key
   - Update Vercel environment variables

### Rate Limiting (Optional)

Add rate limiting to prevent spam:

```typescript
// In app/api/send/route.ts
const rateLimit = new Map();

export async function POST(req: Request) {
  const ip = req.headers.get('x-forwarded-for') || 'unknown';
  const now = Date.now();
  const limit = rateLimit.get(ip);
  
  if (limit && now - limit < 60000) {
    return Response.json({ 
      error: "Too many requests. Please wait a minute." 
    }, { status: 429 });
  }
  
  rateLimit.set(ip, now);
  
  // ... rest of your code
}
```

---

## 💡 Alternative: Disable Contact Form

If you don't want to use Resend, you can disable the contact form:

### Option 1: Remove Contact Page

```bash
# Delete the contact page
rm -rf app/contact
```

### Option 2: Replace with Social Links

Update contact page to show only social media links instead of a form.

### Option 3: Use mailto: Link

Replace form with a simple email link:

```tsx
<a href="mailto:your@email.com">Contact Me</a>
```

---

## 📚 Additional Resources

- **Resend Docs:** https://resend.com/docs
- **Resend Dashboard:** https://resend.com/dashboard
- **Resend Pricing:** https://resend.com/pricing
- **API Reference:** https://resend.com/docs/api-reference

---

## ✅ Quick Checklist

- [ ] Create Resend account (free)
- [ ] Verify email
- [ ] Create API key
- [ ] Copy API key (you won't see it again!)
- [ ] Add to Vercel environment variables
- [ ] Redeploy Vercel
- [ ] Test contact form
- [ ] Check email inbox
- [ ] (Optional) Add custom domain
- [ ] (Optional) Update sender email

---

## 🎉 Summary

**Cost:** FREE (3,000 emails/month)
**Setup Time:** 5 minutes
**Difficulty:** Easy

Your contact form will now work perfectly, and visitors can reach you directly through your portfolio!

---

## 🔗 Quick Links

- **Resend:** https://resend.com
- **Resend Dashboard:** https://resend.com/dashboard
- **Vercel Dashboard:** https://vercel.com/dashboard
- **Your Portfolio:** (your Vercel URL)
