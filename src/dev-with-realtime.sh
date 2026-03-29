#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Portfolio with Real-time Features${NC}"
echo ""

# Check if dependencies are installed
if [ ! -d "node_modules/socket.io" ]; then
    echo -e "${YELLOW}📦 Installing server dependencies...${NC}"
    npm install express socket.io cors
    echo -e "${GREEN}✅ Dependencies installed${NC}"
    echo ""
fi

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo -e "${YELLOW}⚠️  .env.local not found. Creating from example...${NC}"
    cp .env.local.example .env.local
    echo -e "${GREEN}✅ .env.local created${NC}"
    echo ""
fi

echo -e "${GREEN}Starting services...${NC}"
echo ""
echo -e "${BLUE}📡 Socket.IO Server:${NC} http://localhost:3001"
echo -e "${BLUE}🌐 Next.js App:${NC} http://localhost:3000"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop all services${NC}"
echo ""

# Function to cleanup on exit
cleanup() {
    echo ""
    echo -e "${YELLOW}Stopping services...${NC}"
    kill $SOCKET_PID $NEXT_PID 2>/dev/null
    exit 0
}

trap cleanup SIGINT SIGTERM

# Start Socket.IO server in background
node server.js &
SOCKET_PID=$!

# Wait a bit for socket server to start
sleep 2

# Start Next.js dev server in background
cd .. && npm run dev &
NEXT_PID=$!

# Wait for both processes
wait
