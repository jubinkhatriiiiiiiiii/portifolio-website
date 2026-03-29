#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🚀 Pushing 3D Portfolio to GitHub${NC}"
echo ""

# Navigate to project root
cd ..

echo -e "${YELLOW}📋 Current directory:${NC}"
pwd
echo ""

# Check if .git exists
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}Initializing git repository...${NC}"
    git init
    echo -e "${GREEN}✅ Git initialized${NC}"
    echo ""
fi

# Check current remotes
echo -e "${YELLOW}📡 Checking existing remotes...${NC}"
EXISTING_REMOTE=$(git remote -v | grep origin || echo "")

if [ ! -z "$EXISTING_REMOTE" ]; then
    echo -e "${YELLOW}⚠️  Remote 'origin' already exists:${NC}"
    echo "$EXISTING_REMOTE"
    echo ""
    echo -e "${YELLOW}Removing old remote...${NC}"
    git remote remove origin
    echo -e "${GREEN}✅ Old remote removed${NC}"
    echo ""
fi

# Add new remote
echo -e "${YELLOW}🔗 Adding new remote...${NC}"
git remote add origin git@github.com:jubinkhatriiiiiiiiii/portifolio-website.git
echo -e "${GREEN}✅ Remote added${NC}"
echo ""

# Verify remote
echo -e "${YELLOW}📡 Verifying remote:${NC}"
git remote -v
echo ""

# Check git status
echo -e "${YELLOW}📊 Git status:${NC}"
git status --short | head -20
echo ""

# Add all files
echo -e "${YELLOW}📦 Adding all files...${NC}"
git add .
echo -e "${GREEN}✅ Files added${NC}"
echo ""

# Commit
echo -e "${YELLOW}💾 Creating commit...${NC}"
git commit -m "Initial commit: 3D Portfolio with real-time chat features

- Next.js 14 portfolio with 3D elements
- Real-time chat and cursor tracking
- Socket.IO integration with Render
- Responsive design with dark mode
- Configured for Vercel deployment"

echo -e "${GREEN}✅ Commit created${NC}"
echo ""

# Set branch to main
echo -e "${YELLOW}🌿 Setting branch to main...${NC}"
git branch -M main
echo -e "${GREEN}✅ Branch set to main${NC}"
echo ""

# Push to GitHub
echo -e "${YELLOW}🚀 Pushing to GitHub...${NC}"
echo -e "${BLUE}This may take a moment...${NC}"
echo ""

git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    echo ""
    echo -e "${BLUE}🎉 Your repository is now live at:${NC}"
    echo -e "${GREEN}https://github.com/jubinkhatriiiiiiiiii/portifolio-website${NC}"
    echo ""
    echo -e "${YELLOW}📋 Next steps:${NC}"
    echo "1. Go to https://vercel.com"
    echo "2. Import your repository"
    echo "3. Add environment variable: NEXT_PUBLIC_WS_URL=https://socketserver-l4vg.onrender.com"
    echo "4. Deploy!"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Push failed!${NC}"
    echo ""
    echo -e "${YELLOW}Possible issues:${NC}"
    echo "1. SSH key not configured with GitHub"
    echo "2. Repository doesn't exist or you don't have access"
    echo "3. Network connection issue"
    echo ""
    echo -e "${YELLOW}To fix SSH key issue:${NC}"
    echo "1. Generate SSH key: ssh-keygen -t ed25519 -C 'your_email@example.com'"
    echo "2. Add to GitHub: cat ~/.ssh/id_ed25519.pub"
    echo "3. Go to GitHub Settings → SSH Keys → Add new key"
    echo ""
fi
