#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}📤 Pushing Changes to GitHub${NC}"
echo ""

# Navigate to project root
cd ..

# Show what changed
echo -e "${YELLOW}📋 Files changed:${NC}"
git status --short
echo ""

# Add all changes
echo -e "${YELLOW}📦 Adding all changes...${NC}"
git add .
echo -e "${GREEN}✅ Changes staged${NC}"
echo ""

# Commit with message
echo -e "${YELLOW}💾 Creating commit...${NC}"
read -p "Enter commit message (or press Enter for default): " COMMIT_MSG

if [ -z "$COMMIT_MSG" ]; then
    COMMIT_MSG="Update portfolio changes"
fi

git commit -m "$COMMIT_MSG"
echo -e "${GREEN}✅ Commit created${NC}"
echo ""

# Push to GitHub
echo -e "${YELLOW}🚀 Pushing to GitHub...${NC}"
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    echo ""
    echo -e "${BLUE}🎉 Vercel will auto-deploy in 2-3 minutes${NC}"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Push failed!${NC}"
    echo ""
    echo -e "${YELLOW}Try manually:${NC}"
    echo "git add ."
    echo "git commit -m 'Update changes'"
    echo "git push origin main"
    echo ""
fi
