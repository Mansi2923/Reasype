# Deployment Guide

## Railway Deployment (Recommended)

### Step 1: Sign up for Railway
1. Go to [railway.app](https://railway.app)
2. Sign up with your GitHub account
3. Click "New Project"

### Step 2: Deploy from GitHub
1. Select "Deploy from GitHub repo"
2. Choose your `Mansi2923/Reasype` repository
3. Railway will auto-detect Rails and deploy

### Step 3: Add Environment Variables
In Railway dashboard, go to Variables tab and add:

```
GOOGLE_CLOUD_PROJECT_ID=movielistapp-27e91
GOOGLE_CLOUD_PRIVATE_KEY_ID=a5f011d6abb036a6222c6c9642a659d4f4ddad72
GOOGLE_CLOUD_PRIVATE_KEY=-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCShhyrSGVqZcEO\nkT/IiFyGDSRW2Tvm7WY7wSUGPWYosrK3Jzb+YdGKuQz8mjnWBhUBOUm2nR7rpAFL\nkB0C7BgyPxNOhdBHNecLHlR43gmm3hxg7MHZtAl1E7FF/ty+u+fyqztAeaPuK1yZ\nE3JMu6+q5YX0T1TQ6JNyT4I1nxhxUAvFXvELBHKsdPBaCQL3P5qrEC3JvMpXEZ3U\n2DlozTMXLH/Zw7Ir5OvUJmn5UwUbq18ehf6z4NRHM/zF/tPM7Yg/V/3LttOc0LJm\nNzDL8u+wB9RkJjf5kx6TG4Av5Ul8CttdqMkpkh2REk3yqxb9VNX/iL7bHPXHzgY5\nTlqFt4XFAgMBAAECggEAH7HsBK8Z5PyS2NRZoEbDAOpZ2IGQQCFNUpKysBla/mW9\nW/obHsbJHYFvCjtQVHgnVgbu55YwSJfHAfHwHKA2kbPsOLmgdq71xgVvD2A0ZUi5\nicvdGPslapJyb+o0FPwvreIVZJqLd+sgUiqPOIMG+mhA5Dq+5ZvRvVHuoCvEjUoH\n9Kp8UAeQS9ZGJ/4u9weMnj5u38fcOhtmr6VHrcKBwx+WCsDrQvGsX/xHXPc7nk45\nMDs38OfrFlj7ZQjsM9Sd2YJ7q/mI/tzB6dd5acfhAdv8cR30YQXkPfdDdQ2LtjLk\nG7Oz6oxtDYwoIWed3d7GmIQ+F8MlJWtb89AmEcU79wKBgQDOT24GSn1RdM5aIGYm\ne/k0/osJb7EAGMkmE/+ac2SlHMN2AVCks6WUMgnMSuHGN4zWqD3Mc74//iKYgL0+\ne6v8QNRnGmB5Oj+Tv4KfC5/ndW/4pztqmysFPEFnELG5spxZ9ZVvqu9awXOROZ2r\ns1xMHH65TWISM94/ZpB5kY0qUwKBgQC10GdqEfHfwjxqI/8aQRnINh8coxh+ZBp1\nqGDMxWzAsR2LNQ+UXah6xXd3/7X9vKgABnWOFR+SnDlZizLFeUIFqsXXIjbnzvuc\ntCIvp8KW7/fpqKq9yPr6eLqPpjQQAO5lZ+X+oYt7eSCSRrtAA1feIaY7HR2ff3Md\nfV7VEGJ8hwKBgD5Aa2OMkHnGtAkv44LTP6QE9nEXeaIc2H0b5bF2BjVoE3aE+Q9p\ngZnQ63HwWmXUFzQiOdt6RTrL9SZtGi1DZebMrQqbQ+bwc4SicciJ2msd3XZ7B4uo\nXHfM8bMmr2noAhOG7dtvCaAp5TQ53WCU01HH+1jwh5oUeohI62kzSRQvAoGAUTk/\nWfWWVt5RWyGlr7bxq63yDDsYkC5sW6/TPufcA+GcTzpvMVr+D4r0KlnElgyYCRrZ\nnZX2Ousr+8Lh9bKMOjfmloukd77STVl0BFIv7npaCLrfPFXzOb6BqfcYPyYLWqYl\n67GDvK+KS47pzFkyAfyKZNJHD6BCbyQ5H3poZTUCgYBVro6anuZLZ7Pr/4ad4EbU\nLuCp2Q2Lg6PI0GSBxE87W1+8E4F7dieTlL4l+EHxTTrIbvnunHyvfCWbGVSAJcH5\nbNpFTQBO1uhe7XXJ7jlmBKAex/hjCzH1YgNqVSzerrAfrgcIUpOeqfFWRw6MVtP4\n45NeDxB+Q5OiW3gWrAzKmg==\n-----END PRIVATE KEY-----\n
GOOGLE_CLOUD_CLIENT_EMAIL=vision-sa@movielistapp-27e91.iam.gserviceaccount.com
GOOGLE_CLOUD_CLIENT_ID=101207643088691203849
GOOGLE_CLOUD_CLIENT_X509_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/vision-sa%40movielistapp-27e91.iam.gserviceaccount.com
RAILS_ENV=production
RAILS_MASTER_KEY=4da50b2ffbc9c7f7b9e92382887d6732
```

### Step 4: Add Database (Optional)
1. In Railway dashboard, click "New"
2. Select "Database" → "PostgreSQL"
3. Connect it to your Rails app

### Step 5: Deploy
1. Railway will automatically deploy when you push to GitHub
2. Your app will be available at the provided Railway URL

## Why Railway is Better than Vercel for Rails:

✅ **Native Rails support** - Built for Ruby apps  
✅ **Persistent server** - Full Rails server running  
✅ **Database included** - PostgreSQL support  
✅ **File uploads work** - Persistent storage  
✅ **No gem issues** - All gems work properly  
✅ **Free tier** - 500 hours/month free  
✅ **Easy deployment** - Just connect GitHub repo  

## Alternative: Render

If Railway doesn't work, try [render.com](https://render.com):
1. Sign up with GitHub
2. Create "Web Service"
3. Connect your repo
4. Add environment variables
5. Deploy! 