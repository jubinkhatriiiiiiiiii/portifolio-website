#!/bin/bash

echo "🔒 Fixing security vulnerability in next-mdx-remote..."
echo ""

cd ..

# Update next-mdx-remote to latest version
echo "📦 Updating next-mdx-remote to version 6.0.0..."
npm install next-mdx-remote@^6.0.0

echo ""
echo "✅ Security fix applied!"
echo ""
echo "📝 Next steps:"
echo "1. git add package.json package-lock.json"
echo "2. git commit -m 'Security: Update next-mdx-remote to fix CVE-2026-0969'"
echo "3. git push origin main"
echo ""
echo "Vercel will auto-deploy the fix!"
