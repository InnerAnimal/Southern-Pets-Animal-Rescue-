# Photo Upload - Complete Setup Guide (Path B: Production)

## ✅ I Already Did This For You:

1. ✅ Switched Prisma to SQLite (compatible with Cloudflare D1)
2. ✅ Created all photo upload pages and API routes
3. ✅ Updated adopt page to display photos from R2
4. ✅ Added DATABASE_URL to .env.local

## 🚀 What You Need To Do (15 minutes total):

---

## STEP 1: Install Turso & Create Database (5 mins)

**On your local computer, run these commands:**

```bash
# Install Turso CLI
curl -sSfL https://get.tur.so/install.sh | bash

# Login to Turso (opens browser)
turso auth login

# Create database
turso db create spar-animals

# Get the database URL
turso db show spar-animals --url
```

**You'll see something like:**
```
libsql://spar-animals-yourusername.turso.io
```

**Copy that URL!**

Then create an auth token:
```bash
turso db tokens create spar-animals
```

**You'll see something like:**
```
eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9...
```

**Copy that token!**

---

## STEP 2: Add Environment Variables to Vercel (5 mins)

Go to: **Vercel Dashboard → Your Project → Settings → Environment Variables**

Add these 7 variables (select Production, Preview, AND Development for each):

```
DATABASE_URL = libsql://spar-animals-yourusername.turso.io
TURSO_AUTH_TOKEN = eyJhbGc... (paste your token)

CLOUDFLARE_R2_ACCOUNT_ID = ede6590ac0d2fb7daf155b35653457b2
CLOUDFLARE_R2_ACCESS_KEY_ID = 89dbdd887021bbeaaa10ded04b62d421
CLOUDFLARE_R2_SECRET_ACCESS_KEY = 4c28c448983c64fb760cecc2c434e05621225f9f8bf20d14346b0fb1f77ec438
CLOUDFLARE_R2_BUCKET_NAME = spar-animals
CLOUDFLARE_R2_PUBLIC_URL = (we'll update this in Step 3)
```

Click **Save** after each one.

---

## STEP 3: Enable R2 Public Access (3 mins)

1. Go to **Cloudflare Dashboard** → **R2** → Click on bucket: `spar-animals`

2. Click **Settings** tab

3. Scroll to **Public Access** section → Click **Allow Access**

4. You'll see two options:
   - **r2.dev subdomain** (free, instant) ← Choose this for now
   - Custom domain (requires DNS setup)

5. After enabling, you'll see a URL like:
   ```
   https://pub-xxxxxxxxxxxxxx.r2.dev
   ```
   **Copy this URL!**

6. Go back to **Vercel** → Environment Variables → Find `CLOUDFLARE_R2_PUBLIC_URL`
   - Click **Edit** → Paste the new public URL → **Save**

7. Still in R2 bucket settings, scroll to **CORS Policy** → Click **Add CORS policy**

8. Paste this JSON:
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

9. Click **Save**

---

## STEP 4: Push Database Schema to Turso (2 mins)

**On your local computer, in the project directory:**

```bash
cd /path/to/spar

# Install dependencies if you haven't
npm install

# Push the schema to Turso
DATABASE_URL="libsql://spar-animals-yourusername.turso.io?authToken=YOUR_TOKEN_HERE" npx prisma db push
```

Replace:
- `yourusername` with your actual Turso username
- `YOUR_TOKEN_HERE` with your actual Turso token

You should see:
```
✔ Generated Prisma Client
✔ Schema pushed to database
```

---

## STEP 5: Deploy to Vercel (Auto)

Your code is already pushed to Git. Vercel will automatically deploy when it detects the new environment variables.

**Or manually trigger:**
1. Go to Vercel Dashboard → Deployments
2. Click **Redeploy** on the latest deployment

Wait for deployment to finish (~2 minutes).

---

## STEP 6: Add Your First Animal (1 min)

Once deployed, add an animal via API:

```bash
curl -X POST https://your-app-name.vercel.app/api/animals \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Blue",
    "type": "dog",
    "breed": "Pitbull",
    "age": 1,
    "gender": "Male",
    "price": 250,
    "status": "available",
    "spayedNeutered": true,
    "vaccinated": true,
    "microchipped": true,
    "heartwormStatus": "Negative"
  }'
```

Replace `your-app-name.vercel.app` with your actual Vercel URL.

You should get a response like:
```json
{"animal":{"id":"cm123...","name":"Blue",...}}
```

---

## STEP 7: Test Photo Upload! 🎉

1. Go to `https://your-app-name.vercel.app/admin/animals`

2. You should see "Blue" listed

3. Click **Manage Photos**

4. Drag and drop an image (or click to select)

5. Click **Upload 1 Image**

6. Image uploads to Cloudflare R2!

7. Click **Set Primary** to make it the main photo

8. Go to `https://your-app-name.vercel.app/adopt`

9. You should see Blue with your uploaded photo! 🐕

---

## ✅ Complete Checklist:

- [ ] Install Turso CLI
- [ ] Run `turso auth login`
- [ ] Run `turso db create spar-animals`
- [ ] Copy database URL from `turso db show spar-animals --url`
- [ ] Copy token from `turso db tokens create spar-animals`
- [ ] Add 7 environment variables to Vercel (DATABASE_URL, TURSO_AUTH_TOKEN, + 5 R2 vars)
- [ ] Enable R2 public access in Cloudflare Dashboard
- [ ] Copy R2 public URL and update in Vercel
- [ ] Add CORS policy to R2 bucket
- [ ] Run `npx prisma db push` with Turso connection string
- [ ] Wait for Vercel to redeploy
- [ ] Add first animal via curl command
- [ ] Test photo upload at /admin/animals
- [ ] Verify photo shows on /adopt page

---

## 🆘 Troubleshooting:

**"turso: command not found"**
- Make sure the install script completed successfully
- Try: `source ~/.bashrc` or restart your terminal
- Or download from: https://docs.turso.tech/cli/installation

**"Turso connection failed"**
- Check your DATABASE_URL format is exactly: `libsql://spar-animals-username.turso.io?authToken=TOKEN`
- Verify token is correct: `turso db tokens list spar-animals`

**"No animals found" on /admin/animals**
- Database is empty - run the curl command in Step 6
- Check Vercel deployment logs for errors
- Verify DATABASE_URL is set in Vercel

**Photos upload but broken images**
- R2 public URL is wrong - check in Cloudflare Dashboard
- CORS not set - add the JSON policy in Step 3
- Public access not enabled

**Vercel build fails**
- Check deployment logs in Vercel dashboard
- Make sure all env vars are set
- Try redeploying

---

## 📞 Next Steps After It Works:

Once photos are uploading successfully:

1. **Add more animals** - Use Prisma Studio or API
2. **Customize fields** - Edit animal data as needed
3. **Add authentication** (optional) - Protect /admin/animals route
4. **Bulk upload** - Upload multiple animals at once
5. **Image optimization** - Add automatic resizing/compression

---

## Your Current Status:

✅ **Code**: 100% complete and deployed
✅ **R2 Credentials**: Already in .env.local
✅ **Prisma Schema**: Updated for SQLite
✅ **All APIs**: Ready to use

🔲 **Turso Database**: You need to create this (Step 1)
🔲 **Vercel Env Vars**: You need to add these (Step 2)
🔲 **R2 Public Access**: You need to enable this (Step 3)

**Once you complete Steps 1-3, everything will work!**

Let me know when you get stuck or need help with any step!
