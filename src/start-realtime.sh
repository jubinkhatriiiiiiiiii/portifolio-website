#!/bin/bash

echo "🚀 Starting Real-time Chat & Cursor Feature"
echo ""

# Check if node_modules for server exists
if [ ! -d "node_modules/socket.io" ]; then
    echo "📦 Installing server dependencies..."
    npm install express socket.io cors
    echo "✅ Dependencies installed"
    echo ""
fi

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "⚠️  .env.local not found. Creating from example..."
    cp .env.local.example .env.local
    echo "✅ .env.local created"
    echo ""
fi

echo "🔌 Starting Socket.IO server on port 3001..."
echo "   (Press Ctrl+C to stop)"
echo ""

node server.js
