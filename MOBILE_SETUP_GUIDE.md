# 📱 Setup From Your Phone (5 Minutes Total)

## ✅ I Already Did:
- Photo upload code is 100% complete
- All API routes are ready
- Adopt page will auto-display photos
- Prisma schema is configured for SQLite

## 📋 You Need To Do (3 Simple Tasks):

---

## TASK 1: Enable R2 Public Access (2 minutes)

**Go to:** https://dash.cloudflare.com/

1. Tap **R2** in the sidebar
2. Tap on bucket: **spar-animals**
3. Tap **Settings** tab (top)
4. Scroll to **Public Access** section
5. Tap **Allow Access** button
6. Choose **r2.dev subdomain** (it's free and instant)
7. **COPY** the public URL that appears (starts with `https://pub-`)
   - Example: `https://pub-1a2b3c4d5e6f.r2.dev`
   - **Write this down** - you'll need it in Task 3

8. Scroll down to **CORS Policy**
9. Tap **Add CORS policy**
10. Delete any text and paste this:
```json
[
  {
    "AllowedOrigins": ["*"],
    "AllowedMethods": ["GET", "HEAD"],
    "AllowedHeaders": ["*"],
    "MaxAgeSeconds": 3000
  }
]
```
11. Tap **Save**

✅ **Done with R2!**

---

## TASK 2: Create D1 Database (2 minutes)

**Go to:** https://dash.cloudflare.com/

1. Tap **Workers & Pages** in the sidebar
2. Tap **D1 SQL Database**
3. Tap **Create database** button
4. Name it: **spar-animals-db**
5. Tap **Create**
6. Wait 10 seconds for it to be created
7. **COPY** the database ID that appears
   - It's a long string like: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`
   - **Write this down** - you'll need it in Task 3

✅ **Done with D1!**

---

## TASK 3: Add Environment Variables to Vercel (3 minutes)

**Go to:** https://vercel.com/

1. Tap your project: **southern-pets-animal-rescue**
2. Tap **Settings** tab (top)
3. Tap **Environment Variables** in sidebar
4. Add these 6 variables (**Important:** For EACH variable, check ALL THREE boxes: Production, Preview, Development)

### Variable 1:
- Key: `DATABASE_URL`
- Value: `file:/tmp/prod.db`
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

### Variable 2:
- Key: `CLOUDFLARE_R2_ACCOUNT_ID`
- Value: `ede6590ac0d2fb7daf155b35653457b2`
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

### Variable 3:
- Key: `CLOUDFLARE_R2_ACCESS_KEY_ID`
- Value: `89dbdd887021bbeaaa10ded04b62d421`
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

### Variable 4:
- Key: `CLOUDFLARE_R2_SECRET_ACCESS_KEY`
- Value: `4c28c448983c64fb760cecc2c434e05621225f9f8bf20d14346b0fb1f77ec438`
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

### Variable 5:
- Key: `CLOUDFLARE_R2_BUCKET_NAME`
- Value: `spar-animals`
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

### Variable 6:
- Key: `CLOUDFLARE_R2_PUBLIC_URL`
- Value: **PASTE THE URL FROM TASK 1** (starts with `https://pub-`)
- ✅ Production ✅ Preview ✅ Development
- Tap **Save**

✅ **Done with Vercel!**

---

## TASK 4: Redeploy (30 seconds)

Still in Vercel:

1. Tap **Deployments** tab (top)
2. Tap the three dots **⋯** on the top deployment
3. Tap **Redeploy**
4. Tap **Redeploy** again to confirm
5. Wait 2 minutes for deployment to finish

✅ **Deployment started!**

---

## 🎉 TEST IT!

Once deployment finishes (you'll get a notification):

1. Go to: `https://southern-pets-animal-rescue.vercel.app/admin/animals`
2. You should see "No animals found" (that's good!)
3. Scroll down for next step...

---

## Add Your First Animal (From Phone)

**Method 1: Use the API (Easiest from phone)**

Open this in your phone browser:
```
https://southern-pets-animal-rescue.vercel.app/api/animals
```

Then use a URL builder app or just text me and I'll give you the curl command formatted for iOS Shortcuts.

**Method 2: I'll do it for you**

Just reply "add test animal" and I'll give you a simple link to tap.

---

## 📞 After Setup:

1. **Test photo upload:**
   - Go to: `https://southern-pets-animal-rescue.vercel.app/admin/animals`
   - Tap on an animal
   - Tap "Manage Photos"
   - Select photo from phone
   - Tap "Upload"

2. **View on adopt page:**
   - Go to: `https://southern-pets-animal-rescue.vercel.app/adopt`
   - See your photos!

---

## ✅ Checklist:

- [ ] Task 1: Enable R2 public access + CORS
- [ ] Task 1: Copy the public URL (starts with https://pub-)
- [ ] Task 2: Create D1 database named "spar-animals-db"
- [ ] Task 2: Copy the database ID
- [ ] Task 3: Add 6 environment variables to Vercel
- [ ] Task 4: Redeploy in Vercel
- [ ] Wait 2 minutes for deployment
- [ ] Test: Go to /admin/animals
- [ ] Add first animal
- [ ] Upload a photo!

---

## 🆘 If You Get Stuck:

Text me which task number you're on and what you're seeing. I'll help immediately!

**Estimated total time: 5-7 minutes**

Ready? Start with Task 1! 🚀
