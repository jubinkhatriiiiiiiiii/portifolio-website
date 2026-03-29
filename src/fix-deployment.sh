#!/bin/bash

echo "🔧 Fixing Vercel deployment issue..."
echo ""

cd ..

echo "📦 Removing old lock files..."
rm -f package-lock.json yarn.lock pnpm-lock.yaml

echo "📦 Installing dependencies with npm..."
npm install

echo "✅ Dependencies updated!"
echo ""

echo "📝 Committing changes..."
git add package.json package-lock.json
git commit -m "Fix: Update dependencies and regenerate lock file"

echo "🚀 Pushing to GitHub..."
git push origin main

echo ""
echo "✅ Done! Vercel will auto-deploy in 2-3 minutes."
echo ""
echo "Check your Vercel dashboard for the new deployment!"
