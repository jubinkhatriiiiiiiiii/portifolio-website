#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔧 Fixing Real-time Chat Feature${NC}"
echo ""

# 1. Check .env.local in root
echo -e "${YELLOW}1. Checking environment configuration...${NC}"
if [ ! -f "../.env.local" ]; then
    echo -e "${YELLOW}   Creating .env.local in root directory...${NC}"
    echo "NEXT_PUBLIC_WS_URL=http://localhost:3001" > ../.env.local
    echo -e "${GREEN}   ✅ Created ../.env.local${NC}"
else
    echo -e "${GREEN}   ✅ ../.env.local exists${NC}"
fi
cat ../.env.local
echo ""

# 2. Install dependencies if needed
echo -e "${YELLOW}2. Checking server dependencies...${NC}"
if [ ! -d "node_modules/socket.io" ]; then
    echo -e "${YELLOW}   Installing dependencies...${NC}"
    npm install express socket.io cors
    echo -e "${GREEN}   ✅ Dependencies installed${NC}"
else
    echo -e "${GREEN}   ✅ Dependencies already installed${NC}"
fi
echo ""

# 3. Kill any existing processes on ports 3000 and 3001
echo -e "${YELLOW}3. Cleaning up existing processes...${NC}"
lsof -ti:3001 | xargs kill -9 2>/dev/null && echo -e "${GREEN}   ✅ Killed process on port 3001${NC}" || echo -e "   ℹ️  No process on port 3001"
lsof -ti:3000 | xargs kill -9 2>/dev/null && echo -e "${GREEN}   ✅ Killed process on port 3000${NC}" || echo -e "   ℹ️  No process on port 3000"
echo ""

# 4. Start servers
echo -e "${GREEN}🚀 Starting services...${NC}"
echo ""
echo -e "${BLUE}📡 Socket.IO Server:${NC} http://localhost:3001"
echo -e "${BLUE}🌐 Next.js App:${NC} http://localhost:3000"
echo ""
echo -e "${YELLOW}📋 Testing Instructions:${NC}"
echo "   1. Open http://localhost:3000 in your browser"
echo "   2. Press F12 to open Developer Console"
echo "   3. Look for: 'Socket.IO connected' and 'Users updated: 1 users'"
echo "   4. Open an Incognito window to http://localhost:3000"
echo "   5. Both consoles should show: 'Users updated: 2 users'"
echo "   6. Click the users button (👥) - should show 2 users"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop all services${NC}"
echo ""

# Cleanup function
cleanup() {
    echo ""
    echo -e "${YELLOW}Stopping services...${NC}"
    kill $SOCKET_PID $NEXT_PID 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM

# Start Socket.IO server
node server.js &
SOCKET_PID=$!

# Wait for socket server to start
sleep 2

# Start Next.js dev server
cd .. && npm run dev &
NEXT_PID=$!

# Wait for both processes
wait
