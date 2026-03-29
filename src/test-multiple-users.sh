#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🧪 Testing Real-time Chat with Multiple Users${NC}"
echo ""

# Get local IP
IP=$(hostname -I | awk '{print $1}' 2>/dev/null || echo "localhost")

echo -e "${GREEN}✅ Servers are running!${NC}"
echo ""
echo -e "${YELLOW}📋 How to test with multiple users:${NC}"
echo ""
echo -e "${BLUE}Method 1: Multiple Browser Windows (Easiest)${NC}"
echo "   1. Open: http://localhost:3000"
echo "   2. Open Incognito: http://localhost:3000"
echo "   3. Open different browser: http://localhost:3000"
echo ""
echo -e "${BLUE}Method 2: Share on Local Network${NC}"
echo "   Your local IP: ${GREEN}$IP${NC}"
echo "   Share this URL: ${GREEN}http://$IP:3000${NC}"
echo ""
echo -e "${YELLOW}⚠️  For Method 2, update .env.local:${NC}"
echo "   NEXT_PUBLIC_WS_URL=http://$IP:3001"
echo ""
echo -e "${BLUE}Method 3: Mobile + Desktop${NC}"
echo "   Desktop: http://localhost:3000"
echo "   Mobile (same WiFi): http://$IP:3000"
echo ""
echo -e "${GREEN}🎯 What to look for:${NC}"
echo "   • Click the users button (👥) in top-right"
echo "   • User count should increase"
echo "   • See multiple cursors moving"
echo "   • Chat messages sync in real-time"
echo "   • 'Invite a friend' message disappears"
echo ""
